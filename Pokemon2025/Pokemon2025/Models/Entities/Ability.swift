//
//  Ability.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

extension Model.Entity {
  /// Represents a Pokémon's ability.
  struct Ability: PKMNModel {
    /// The display name of the ability.
    let name: String
  }

  /// Represents a collection of Pokémon abilities.
  struct AbilitiesArray: PKMNModel {
    /// An optional array of Ability objects.
    let array: [Ability]?
  }

}
