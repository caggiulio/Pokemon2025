//
//  StatsDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct StatsDataSource: Decodable {
  let baseStat: Int
  let effort: Int
  let stat: StatDataSource

  private enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
    case effort
    case stat
  }
}
