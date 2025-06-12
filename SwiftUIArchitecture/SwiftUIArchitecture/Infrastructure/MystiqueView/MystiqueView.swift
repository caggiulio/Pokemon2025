//
//  BaseView.swift
//

import Foundation
import SwiftUI

struct MystiqueView<Value: Equatable,
                SuccessView: View,
                LoadingView: View,
                ErrorView: View>: View
where SuccessView: View, LoadingView: View, ErrorView: View, Value: Sendable {

  // MARK: - Structured Data

  /// The kind of the error view.
  enum ErrorViewKind {
    /// The static state.
    case `static`

    /// The hiding view state(after seconds).
    case hide(after: Double)
  }

  /// A private handling view state.
  private enum Inner<Content> {
    /// The idle state.
    case idle

    /// The loaded state.
    case loaded(Content)
  }

  // MARK: - Stored Properties

  /// The specialized `LocalState`.
  let localState: LocalState<Value, CustomError>

  /// The success `View`.
  let successView: (Value) -> SuccessView

  /// The loading `View`.
  let loadingView: LoadingView

  /// The error `View`.
  let errorView: (CustomError) -> ErrorView

  /// The error view kind.
  private var errorViewKind: ErrorViewKind

  /// The private handling view state.
  @State private var innerState: Inner<Value> = .idle

  /// If the view showing error.
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
        if case .hide(let seconds) = errorViewKind {
          Task {
            try await Task.sleep(for: .seconds(seconds))
            withAnimation {
              isShowingError = false
            }
          }
        }
      }
    }
  }
}
