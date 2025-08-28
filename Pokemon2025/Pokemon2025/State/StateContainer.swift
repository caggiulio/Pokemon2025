//
//  StateContainer.swift
//

import Factory
import Foundation

/// The app state containter. The object `AppState` is a `@Published`.
public class StateContainer: ObservableObject {

  // MARK: - Stored Properties

  /// The object conforms to `AppStateable`.
  @Published var state: AppStateable = Container.shared.appState.resolve()
}

extension StateContainer {
  /// The func to reset the app state.
  func reset() {
    state.reset()
  }
}
