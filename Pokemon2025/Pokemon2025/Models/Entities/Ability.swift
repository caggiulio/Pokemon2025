//
//  Ability.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents a Pokémon's ability.
struct Ability: PKMNModel {
  /// The display name of the ability.
  let name: String
  
  // MARK: - Init

  /// Initializes an Ability from a data source.
  /// - Parameter abilityDataSource: The data source containing ability information.
  init(abilityDataSource: AbilityDataSource) {
    name = abilityDataSource.name
  }
}

/// Represents a collection of Pokémon abilities.
struct AbilitiesArray: PKMNModel {
  /// An optional array of Ability objects.
  let array: [Ability]?
}
