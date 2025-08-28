//
//  BaseView.swift
//

import Foundation
import SwiftUI

struct MystiqueView<
  Value: Equatable,
  SuccessView: View,
  LoadingView: View,
  ErrorView: View
>: View
where SuccessView: View, LoadingView: View, ErrorView: View, Value: Sendable {

  // MARK: - Structured Data

  /// A private handling view state.
  private enum Inner<Content> {
    /// The idle state.
    case idle

    /// The loaded state.
    case loaded(Content)
  }

  // MARK: - Stored Properties

  /// The local state that manages loading, error, and success for a value.
  let localState: LocalState<Value, CustomError>

  /// The closure to generate the success view with the loaded value.
  let successView: (Value) -> SuccessView

  /// The view to display when loading is in progress.
  let loadingView: LoadingView

  /// The closure to generate the error view using a custom error.
  let errorView: (CustomError) -> ErrorView

  /// The configuration for how error views should be displayed and dismissed.
  private var errorViewKind: ErrorViewKind

  /// Internal state for tracking whether content is loaded or idle.
  @State private var innerState: Inner<Value> = .idle

  /// Tracks whether the error view should currently be shown.
  @State private var isShowingError: Bool = false

  // MARK: - Init

  /// The init of the `LocalStateView`.
  /// - Parameters:
  ///   - localState: The specialized `LocalState`.
  ///   - errorViewKind: The kind of the error view.
  ///   - successView: The success `View`.
  ///   - loadingView: The loading `View`.
  ///   - errorView: The error `View`.
  init(
    localState: LocalState<Value, CustomError>,
    errorViewKind: ErrorViewKind = .static,
    @ViewBuilder successView: @escaping (Value) -> SuccessView,
    @ViewBuilder loadingView: () -> LoadingView = { Color.clear },
    @ViewBuilder errorView: @escaping (Error) -> ErrorView = { _ in Color.clear }
  ) {
    self.localState = localState
    self.successView = successView
    self.loadingView = loadingView()
    self.errorView = errorView
    self.errorViewKind = errorViewKind
  }

  // MARK: - Body

  var body: some SwiftUI.View {
    ZStack {
      if case .loaded(let content) = innerState {
        successView(content)
      }

      if case .loading = localState {
        loadingView
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }

      if case .failure(let error) = localState {
        if isShowingError {
          errorView(error)
        }
      }
    }
    .onChange(of: localState) {
      if case .success(let value) = localState {
        innerState = .loaded(value)
      }
      if case .failure = localState {
        isShowingError = true
      }
    }
    .background(
      ErrorDismissHandler(
        state: localState,
        errorViewKind: errorViewKind,
        onDismiss: { isShowingError = false }
      )
    )
  }
}

/// The kind of the error view.
enum ErrorViewKind {
  /// The static state.
  case `static`

  /// The hiding view state(after seconds).
  case hide(after: Double)
}

/// A SwiftUI view responsible for managing the automatic dismissal of error states.
///
/// `ErrorDismissHandler` is used as a background view to handle the timing and animation
/// of dismissing error presentations in response to changes in a `LocalState` value.
/// When the associated `LocalState` enters the `.failure` case and the `ErrorViewKind`
/// is set to `.hide(after:)`, this view schedules a timed task to dismiss the error view
/// after the specified duration. The dismissal is performed with animation and triggers
/// the provided `onDismiss` closure.
///
/// - Note: This view does not present any visible content. It should be used in a
///   `.background` or similar modifier to coordinate error state transitions.
///
private struct ErrorDismissHandler<Value: Equatable & Sendable>: View {

  // MARK: - Stored Properties

  /// The local state being observed for error presentation or dismissal.
  let state: LocalState<Value, CustomError>
  /// The configuration for how and when the error view should be hidden.
  let errorViewKind: ErrorViewKind
  /// The closure called to perform error view dismissal.
  let onDismiss: @MainActor @Sendable () -> Void

  // MARK: - Body

  var body: some View {
    Color.clear
      .task(id: state) {
        if case .failure = state {
          if case .hide(let seconds) = errorViewKind {
            try? await Task.sleep(for: .seconds(seconds))
            withAnimation {
              onDismiss()
            }
          }
        }
      }
  }
}
