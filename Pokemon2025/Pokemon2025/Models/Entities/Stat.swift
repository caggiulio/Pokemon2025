//
//  Stat.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents a Pokémon's individual stat, such as HP, Attack, etc.
struct Stat: PKMNModel {
  /// The name of the stat (e.g., HP, Attack).
  let name: String
  /// The base value of the stat.
  let baseStat: Float
  /// The stat value represented as a percentage.
  let percentStat: Float
}

/// A wrapper for an array of Stat objects.
struct StatArray: PKMNModel {
  /// The underlying array of Stat objects. Optional.
  let array: [Stat]?
}
