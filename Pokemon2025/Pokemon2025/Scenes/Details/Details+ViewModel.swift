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
    @Published var selectedPokemon: Model.Entity.Pokemon?

    /// Represents the currently selected Pokémon Pokedex information for the detail view.
    @Published var selectedPokemonPokedexInformation: Model.Foundation.PokemonInformation?

    /// Tracks the current loading state for the details view's local operations (such as fetching Pokédex information).
    @Published var localState: LocalState<Empty, Error> = .idle

    // MARK: - Computed Properties

    /// Returns the name of the selected Pokémon or an empty string if none is selected.
    var name: String {
      selectedPokemon?.name.capitalized ?? ""
    }

    /// Provides the URL string of the selected Pokémon's front image, or an empty string.
    var imageURL: String {
      selectedPokemon?.frontImage.stringURL ?? ""
    }

    /// Returns a human-readable description of the currently selected Pokémon's Pokédex information.
    var readablePokedexInformation: String {
      selectedPokemonPokedexInformation?.description ?? ""
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
      selectedPokemonPokedexInformation = state.pokemonDetail.pokedexInformation
    }

    // MARK: - Functions

    /// Asynchronously fetches detailed Pokédex information for the currently selected Pokémon.
    ///
    /// This method sets the local state to `.loading` before attempting to retrieve data. If no Pokémon is
    /// currently selected, it sets the state back to `.idle` and returns early. Otherwise, it performs an
    /// asynchronous operation to fetch the Pokédex information using the `GetPokedexAssistantInformation` use case.
    /// Upon successful completion, the local state is updated to `.success`.
    ///
    /// - Throws: Propagates any error thrown by the underlying use case execution.
    ///
    /// - Note: This method should be called when up-to-date Pokédex information is required for the selected Pokémon.
    @MainActor
    func getPokedexInformation() async throws {
      localState = .loading
      guard let selectedPokemon else {
        localState = .idle
        return
      }
      do {
        try await UseCase.GetPokedexAssistantInformation().execute(for: selectedPokemon)
        localState = .success
      } catch {
        localState = .failure(error)
      }
    }

    /// The `Interaction` called when the confirmation is tapped on error view.
    func errorConfirmationIsTapped() {
      localState = .idle
    }

    deinit {
      UseCase.ClearPokedexAssistantInformationCache().execute()
    }
  }
}
