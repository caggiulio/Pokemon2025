//
//  StateContainer.swift
//

import Foundation

/// The app state containter. The object `AppState` is a `@Published`.
public class StateContainer: ObservableObject {
  @Published var state: AppState
  
  init() {
    state = AppState()
  }
}

extension StateContainer {
  /// The func to reset the app state.
  func reset() {
    state = AppState()
  }
}
