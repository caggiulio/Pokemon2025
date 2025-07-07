//
//  StateContainer.swift
//

import Foundation

/// The app state containter. The object `AppState` is a `@Published`.
public class StateContainer: ObservableObject {

  // MARK: - Stored Properties

  /// The object conforms to `AppStateable`.
  @Published var state: AppStateable

  // MARK: - Init

  /// The init of the `StateContainer` object.
  /// - Parameter state: The App state in which every current session information is stored. Is used only to store data.
  init(state: AppStateable) {
    self.state = state
  }
}

extension StateContainer {
  /// The func to reset the app state.
  func reset() {
    state.reset()
  }
}
