//
//  PokemonRepository.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Factory
import Foundation

extension Repository {
  struct Pokemon: PokemonRepositoryProtocol {
    /// The networking worker.
    @Injected(\.networkManager) private var networkingManager: NetworkManager

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    /// Get the information of a Pokemon by his identifier.
    func getPokemon(identifier: String) async throws {
      let pokemon = try await networkingManager.pokemonService.getPokemon(id: identifier)
      stateContainer.state.pokemonDetail.selectedPokemon = pokemon
    }

    func getPokemonList(page: Int?) async throws {
      let pokemonList = try await networkingManager.pokemonService.getPokemonList(page: page)
      stateContainer.state.pokemonList.pokemonList = pokemonList
    }
  }
}
