//
//  MainActorButton.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 01/08/25.
//

import SwiftUI

/// A SwiftUI button that runs its asynchronous action on the main actor using a new `Task`.
///
/// This view helps ensure that any asynchronous, throwing action is always executed on the main actor when the button is pressed,
/// simplifying UI updates and concurrency correctness in SwiftUI code. The action is wrapped with `mainActorTask` for safe execution.
///
/// - Note: Use this view when you need a button that triggers an async/throwing operation on the main actor.
struct MainActorButton<Label: View>: View {

  // MARK: - Stored Properties

  /// The asynchronous, potentially throwing action to perform when the button is pressed.
  private var action: @MainActor @Sendable () async throws -> Void

  /// A closure that produces the label view for the button.
  @ViewBuilder private var label: () -> Label

  // MARK: - Init

  /// Creates a `MainActorButton` with the provided async action and label.
  /// - Parameters:
  ///   - action: The asynchronous, potentially throwing action to perform when pressed.
  ///   - label: A closure that produces the label view for the button.
  public init(action: @escaping @MainActor @Sendable () async throws -> Void, @ViewBuilder label: @escaping () -> Label)
  {
    self.action = action
    self.label = label
  }

  // MARK: - Body

  var body: some View {
    Button {
      mainActorTask {
        try await action()
      }
    } label: {
      label()
    }
  }
}
