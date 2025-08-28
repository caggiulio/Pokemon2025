//
//  AbilityDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

extension Model.Data {
  /// Represents a Pokémon ability with its name and resource URL.
  struct AbilityDataSource: Decodable {
    /// The name of the Pokémon ability.
    let name: String
    /// The URL for more information about the ability.
    let url: String
  }

}

// MARK: - Normalizable

extension Model.Data.AbilityDataSource: Normalizable {
  func normalizedForApp() -> Model.Entity.Ability {
    Model.Entity.Ability(name: name)
  }
}
