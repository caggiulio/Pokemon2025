//
//  Stats+ViewModel.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 27/06/25.
//

import Foundation

/// A view model responsible for providing the stats data of the selected Pokémon
/// to the UI. It observes changes in the application state and updates the stats
/// accordingly.
///
/// This class inherits from `StaterViewModel`, which provides the infrastructure
/// for observing and reacting to state updates.
extension UI.Funnel.Details.Stats {
  class ViewModel: StaterViewModel {

    // MARK: - Stored Properties

    /// The list of stats associated with the currently selected Pokémon.
    /// This is updated automatically when the app state changes.
    @Published private(set) var stats: [Model.Entity.Stat] = []

    // MARK: - Update

    /// Updates the view model with the latest application state.
    ///
    /// - Parameter state: The current application state.
    /// Updates the `stats` array with the stats of the selected Pokémon.
    override func update(state: AppStateable) {
      super.update(state: state)

      stats = state.pokemonDetail.selectedPokemon?.stats ?? []
    }
  }
}
