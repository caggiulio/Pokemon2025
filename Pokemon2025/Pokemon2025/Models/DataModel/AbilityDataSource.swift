//
//  AbilityDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents a Pokémon ability with its name and resource URL.
struct AbilityDataSource: Decodable {
  /// The name of the Pokémon ability.
  let name: String
  /// The URL for more information about the ability.
  let url: String
}

// MARK: - Normalizable

extension AbilityDataSource: Normalizable {
  func normalizedForApp() -> Ability {
    Ability(name: name)
  }
}
