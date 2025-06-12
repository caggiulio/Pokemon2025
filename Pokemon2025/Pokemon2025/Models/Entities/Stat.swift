//
//  Stat.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct Stat: PKMNModel {
  let name: String
  let baseStat: Float
  let percentStat: Float

  init(statDataSource: StatsDataSource) {
    name = statDataSource.stat.name
    baseStat = Float(statDataSource.baseStat)
    percentStat = Float(baseStat) / 100
  }
}

struct StatArray: PKMNModel {
  let array: [Stat]?
}
