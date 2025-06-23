//
//  NetworkDataSourceProtocol.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

/// `PokemonServiceProtocol` defines the set of methods required for fetching Pokémon data from a remote source.
///
/// - Note: All methods are asynchronous and may throw errors.
/// - SeeAlso: `Pokemon`, `PokemonList`
///
import Foundation

/// The protocol to defines the list of API calls to implements.
protocol PokemonServiceProtocol {
  /// Fetches detailed information for a specific Pokémon by its unique identifier.
  ///
  /// - Parameter id: The identifier of the Pokémon to fetch.
  /// - Returns: A `Pokemon` object containing detailed information.
  /// - Throws: An error if the fetch fails.
  /// - Note: This method is asynchronous.
  func getPokemon(id: String) async throws -> Model.Entity.Pokemon

  /// Retrieves a paginated list of Pokémon from the API.
  ///
  /// - Parameter next: An optional pagination URL for fetching the next page. Pass `nil` to fetch the first page.
  /// - Returns: A `PokemonList` containing Pokémon entries and metadata for pagination.
  /// - Throws: An error if the fetch fails.
  /// - Note: This method is asynchronous.
  func getPokemonList(next: String?) async throws -> PokemonList
}
