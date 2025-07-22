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

    /// The AI Assistant servicethat returns the Pokedex information.
    @Injected(\.pokedexAssistantService) private var pokedexAssistanService: PokedexAssistantServiceProtocol

    func getPokemon(identifier: String) async throws -> Model.Entity.Pokemon {
      return try await pokemonService.getPokemon(id: identifier)
    }

    func fetchPokemonList(next: String?) async throws -> Model.Entity.PokemonList {
      return try await pokemonService.getPokemonList(next: next)
    }

    func getPokedexInformation(for pokemon: Model.Entity.Pokemon) async throws -> Model.Foundation.PokemonInformation {
      return try await pokedexAssistanService.getPokemonInformation(from: pokemon)
    }
  }
}
