//
//  MystiqueObservableViewModel.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 08/08/25.
//

import SwiftUI

@Observable
@MainActor
open class MystiqueObservableViewModel<Model: CustomModel>: ObservableObject {

  // MARK: - Computed Properties

  /// The loading state with his related `Model`.
  var localState: LocalState<Model, CustomError> = .idle

  /// The last value of the `Model` if exist. This variable is assigned when a `LocalState`
  /// become `.success`.
  private var model: Model?

  // MARK: - Init

  /// Initializes the view model with default values and sets up subscriptions to the local state and app state.
  init() {
    Task { [weak self] in
      guard let self, let newState = localState.value else { return }
      model = newState
    }
  }
}
