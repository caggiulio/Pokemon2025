//
//  Ability.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct Ability: PKMNModel {
  let name: String

  init(abilityDataSource: AbilityDataSource) {
    name = abilityDataSource.name
  }
}

struct AbilitiesArray: PKMNModel {
  let array: [Ability]?
}
