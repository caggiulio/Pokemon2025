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
  /// - Returns: The `Model.Entity.Pokemon`.
  /// - Throws: An error if the fetch fails.
  func getPokemon(identifier: String) async throws -> Model.Entity.Pokemon

  /// Fetches the Pokedex information fetched by AI Assistant.
  /// - Parameter pokemon: The Pokemon object.
  /// - Returns: The `Model.Foundation.PokemonInformation`.
  /// - Throws: An error if the fetch fails.
  func getPokedexInformation(for pokemon: Model.Entity.Pokemon) async throws -> Model.Foundation.PokemonInformation

  /// Fetches a list of all available Pokémon.
  /// - Parameter next: An optional pagination URL for fetching the next page. Pass `nil` to fetch the first page.
  /// - Returns: The `Model.Entity.PokemonList`.
  /// - Throws: An error if the fetch fails.
  func fetchPokemonList(next: String?) async throws -> Model.Entity.PokemonList
}
