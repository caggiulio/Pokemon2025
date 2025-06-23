//
//  Species.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

extension Model.Entity {
  /// Represents a Pokémon species in the application.
  struct Species: PKMNModel {
    /// The name of the Pokémon species.
    let name: String
  }
}
