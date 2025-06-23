//
//  PokemonRepositoryProtocol.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/12/23.
//

import Foundation

/// A protocol defining methods for retrieving Pokémon-related data.
protocol PokemonRepositoryProtocol {
  /// Fetches a single Pokémon by its unique identifier.
  /// - Parameter identifier: The unique identifier (name or ID) of the Pokémon to fetch.
  /// - Throws: An error if the fetch fails.
  func getPokemon(identifier: String) async throws

  /// Fetches the Pokedex information fetched by AI Assistant.
  /// - Parameter pokemon: The Pokemon object.
  /// - Throws: An error if the fetch fails.
  func getPokedexInformation(for pokemon: Model.Entity.Pokemon) async throws

  /// Fetches a list of all available Pokémon.
  /// - Throws: An error if the fetch fails.
  func fetchPokemonList() async throws

  /// Clears any cached or stored Pokédex information.
  /// Use this to reset or remove previously fetched Pokédex details from the repository.
  func clearPokedexInformation()
}
