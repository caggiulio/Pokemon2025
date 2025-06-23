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
    /// This is the implementation of `NetworkDataSourceProtocol`
    @Injected(\.pokemonService) private var pokemonService: PokemonServiceProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    /// The AI Assistant servicethat returns the Pokedex information.
    @Injected(\.pokedexAssistanService) private var pokedexAssistanService: PokedexAssistantServiceProtocol

    func getPokemon(identifier: String) async throws {
      let pokemon = try await pokemonService.getPokemon(id: identifier)
      stateContainer.state.pokemonDetail.selectedPokemon = pokemon
    }

    func fetchPokemonList() async throws {
      let pokemonList = try await pokemonService.getPokemonList(
        next: stateContainer.state.pokemonList.pokemonList?.next
      )
      if let pokemonListState = stateContainer.state.pokemonList.pokemonList,
        pokemonListState.pokemonItems.allSatisfy({ pokemon in
          pokemonList.pokemonItems.contains { $0 == pokemon }
        })
      {
        return
      }
      var pokemonItems = stateContainer.state.pokemonList.pokemonList?.pokemonItems ?? []
      pokemonItems += pokemonList.pokemonItems
      let newPokemonList = PokemonList(
        count: pokemonList.count,
        next: pokemonList.next,
        pokemonItems: pokemonItems
      )

      stateContainer.state.pokemonList.pokemonList = newPokemonList
    }

    func getPokedexInformation(for pokemon: Model.Entity.Pokemon) async throws {
      let pokedexInformation = try await pokedexAssistanService.getPokemonInformation(from: pokemon)
      stateContainer.state.pokemonDetail.pokedexInformation = pokedexInformation
    }

    func clearPokedexInformation() {
      stateContainer.state.pokemonDetail.pokedexInformation = nil
    }
  }
}
