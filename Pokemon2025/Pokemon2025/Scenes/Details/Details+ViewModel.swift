//
//  Home+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Foundation

/// Extension providing the ViewModel for the Details funnel in the UI.
extension UI.Funnel.Details {
  /// ViewModel responsible for managing the state and logic of the details view within the funnel.
  class ViewModel: StaterViewModel {

    // MARK: - Stored Properties

    /// Represents the currently selected Pokémon for the detail view.
    @Published var selectedPokemon: Pokemon?

    // MARK: - Computed Properties

    /// Returns the name of the selected Pokémon or an empty string if none is selected.
    var name: String {
      selectedPokemon?.name ?? ""
    }

    /// Provides the URL string of the selected Pokémon's front image, or an empty string.
    var imageURL: String {
      selectedPokemon?.frontImage.stringURL ?? ""
    }

    // MARK: - Update

    /// Updates the ViewModel with the latest application state.
    ///
    /// This method synchronizes the ViewModel's `selectedPokemon` property
    /// with the `selectedPokemon` from the application's `pokemonDetail` state.
    /// It first calls the superclass implementation to perform any required base updates,
    /// then updates the local state to reflect any changes.
    ///
    /// - Parameter state: The latest `AppState` containing updated application data.
    override func update(state: AppState) {
      super.update(state: state)

      selectedPokemon = state.pokemonDetail.selectedPokemon
    }

    // MARK: - Functions

  }
}
