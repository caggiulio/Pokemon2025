//
//  Species.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct Species: PKMNModel {
  let name: String

  init(speciesDataSource: SpeciesDataSource) {
    name = speciesDataSource.name
  }
}
