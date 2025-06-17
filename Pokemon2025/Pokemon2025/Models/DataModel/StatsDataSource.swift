//
//  StatsDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents the stats information of a Pokémon as received from the API.
struct StatsDataSource: Decodable {
  /// The base value of the stat.
  let baseStat: Int
  /// The effort points the Pokémon yields in this stat.
  let effort: Int
  /// The stat information.
  let stat: StatDataSource

  private enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case effort
    case stat
  }
}

// MARK: - Normalizable

extension StatsDataSource: Normalizable {
  func normalizedForApp() -> Stat {
    Stat(name: stat.name, baseStat: Float(baseStat), percentStat: Float(baseStat) / 100)
  }
}
