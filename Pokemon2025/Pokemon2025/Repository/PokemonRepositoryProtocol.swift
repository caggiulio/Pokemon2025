//
//  PokemonRepositoryProtocol.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/12/23.
//

import Foundation

/// A protocol defining methods for retrieving Pokémon-related data.
public protocol PokemonRepositoryProtocol {
  /// Fetches a single Pokémon by its unique identifier.
  /// - Parameter identifier: The unique identifier (name or ID) of the Pokémon to fetch.
  /// - Throws: An error if the fetch fails.
  func getPokemon(identifier: String) async throws

  /// Fetches a list of all available Pokémon.
  /// - Throws: An error if the fetch fails.
  func fetchPokemonList() async throws
}
