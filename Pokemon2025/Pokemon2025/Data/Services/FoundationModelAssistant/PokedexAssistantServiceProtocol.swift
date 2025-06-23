//
//  PokedexAssistantServiceProtocol.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 23/06/25.
//

import Foundation

/// A protocol defining a service for assisting with Pokémon-related information queries.
protocol PokedexAssistantServiceProtocol {
  /// Retrieves detailed information about a given Pokémon.
  ///
  /// - Parameter pokemon: The `Pokemon` instance representing the Pokémon to query.
  /// - Returns: A `PokemonInformation` object containing comprehensive information about the specified Pokémon.
  /// - Throws: An error if the information could not be retrieved.
  func getPokemonInformation(from pokemon: Model.Entity.Pokemon) async throws -> Model.Foundation.PokemonInformation
}
