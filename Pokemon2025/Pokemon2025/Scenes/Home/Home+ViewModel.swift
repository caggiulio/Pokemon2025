//
//  Home+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Foundation

/// Extension containing the ViewModel for the Home UI funnel,
/// managing state and data interactions for the Home view.
extension UI.Funnel.Home {
  /// ViewModel responsible for handling the UI state and business logic
  /// for the Home screen in the app's funnel architecture.
  class ViewModel: StaterViewModel {

    // MARK: - Stored Properties

    /// Represents the current local state of the ViewModel,
    /// including loading, success, and failure states used to update the UI.
    @Published private(set) var localState: LocalState<Empty, Error> = .idle

    /// Holds the current list of Pokémon items to be displayed in the UI.
    @Published private(set) var pokemons: [PokemonListItem] = []

    // MARK: - Update

    /// Updates the ViewModel state based on the given `AppState`.
    /// This method is called whenever the global app state changes,
    /// refreshing the local list of Pokémon accordingly.
    override func update(state: AppState) {
      super.update(state: state)

      pokemons = state.pokemonList.pokemonList?.pokemonItems ?? []
    }

    // MARK: - Functions

    /// Asynchronously loads additional data for the Home view.
    /// Sets the local state to `.loading` during the fetch,
    /// updates to `.success` on completion, or `.failure` if an error occurs.
    /// Errors thrown during the fetch are handled and reflected in the local state.
    @MainActor
    func loadOthers() async throws {
      localState = .loading
      do {
        try await UseCase.FetchPokemonList().execute()
        localState = .success(Empty())
      } catch {
        localState = .failure(error)
      }
    }

    /// Returns the capitalized name of the given Pokémon.
    ///
    /// - Parameter pokemon: The `PokemonListItem` whose name should be formatted.
    /// - Returns: The capitalized name of the Pokémon as a `String`.
    func name(for pokemon: PokemonListItem) -> String {
      return pokemon.name.capitalized
    }
  }
}
