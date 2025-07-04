//
//  HomeList+ViewModel.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 03/07/25.
//

//
//  HomeListCell+ViewModel.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 03/07/25.
//

import Factory
import Foundation
import SwiftUI

extension UI.Funnel.Home.View.List {
  /// The `ViewModel` class serves as the observable view model for the Pokémon Home List screen.
  class ViewModel: ObservableObject {

    // MARK: - Stored Properties

    @Published private(set) var pokemons: [Model.Entity.PokemonListItem] = []

    /// Represents the current local state of the ViewModel,
    /// including loading, success, and failure states used to update the UI.
    @Published private(set) var localState: LocalState<Empty, Error> = .idle

    /// A reference to the app's navigation coordinator, injected using Factory's property wrapper.
    /// The coordinator is responsible for managing navigation and flow control within the Home UI,
    /// enabling the ViewModel to trigger navigation actions without tightly coupling to the navigation logic.
    @Injected(\.coordinator) private var coordinator: Coordinator

    // MARK: - Init

    /// Initializes the `ViewModel` with an initial list of Pokémon items.
    ///
    /// - Parameter pokemons: An array of `PokemonListItem` representing the Pokémon to display or manage within the home list view.
    ///                       This initial data can be used to populate the UI or serve as a basis for further operations.
    init(pokemons: [Model.Entity.PokemonListItem]) {
      self.pokemons = pokemons
    }

    // MARK: - Functions

    /// Asynchronously fetches the detailed information for a given Pokémon and updates the local state accordingly.
    ///
    /// This function sets the `localState` to `.loading` while the data is being fetched, then updates it to `.success`
    /// upon successful completion, or `.failure` if an error occurs. After successfully fetching the Pokémon detail,
    /// this function also triggers the navigation to the details screen via the coordinator.
    ///
    /// - Parameter pokemon: The `PokemonListItem` for which to fetch detailed information.
    /// - Throws: Rethrows any error encountered during the data fetch operation.
    @MainActor
    func fetchPokemonDetail(for pokemon: Model.Entity.PokemonListItem, animation: Namespace.ID) async throws {
      localState = .loading
      do {
        try await UseCase.GetPokemonByIdentifier().execute(identifier: pokemon.id)
        localState = .success
        coordinator.details(transitionIdentifier: matchedTransitionIdentifier(for: pokemon), animation: animation)
      } catch {
        localState = .failure(error)
      }
    }

    /// Returns a unique transition identifier for the given Pokémon item,
    /// used to match transitions in navigation or animation contexts.
    ///
    /// The identifier is constructed by combining the prefix "pokemon#" with
    /// the Pokémon's unique identifier, ensuring that each Pokémon can be
    /// distinctly referenced during view transitions.
    ///
    /// - Parameter pokemon: The `PokemonListItem` for which to generate the transition identifier.
    /// - Returns: A hashable value representing the unique transition identifier for the Pokémon.
    private func matchedTransitionIdentifier(for pokemon: Model.Entity.PokemonListItem) -> String {
      "pokemon#\(pokemon.id)"
    }
  }
}
