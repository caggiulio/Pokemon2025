//
//  Species.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents a Pokémon species in the application.
struct Species: PKMNModel {
  /// The name of the Pokémon species.
  let name: String

  // MARK: - Init

  /// Initializes a new `Species` instance using the provided data source.
  /// - Parameter speciesDataSource: The data source containing species information.
  init(speciesDataSource: SpeciesDataSource) {
    name = speciesDataSource.name
  }
}
