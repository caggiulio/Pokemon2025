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
/// Methods:
///   - `getPokemon(id:)`: Fetches detailed information for a specific Pokémon by its identifier.
///   - `getPokemonList(next:)`: Retrieves a paginated list of Pokémon, optionally using a pagination URL for subsequent pages.
import Foundation

/// The protocol to defines the list of API calls to implements.
protocol PokemonServiceProtocol {
  func getPokemon(id: String) async throws -> Pokemon
  func getPokemonList(next: String?) async throws -> PokemonList
}
