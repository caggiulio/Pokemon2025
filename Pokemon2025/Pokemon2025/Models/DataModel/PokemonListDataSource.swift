//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//
import Foundation

struct PokemonListDataSource: Decodable {
  let count: Int
  let next: String
  let results: [PokemonListItemDataSource]
}

extension PokemonListDataSource: Normalizable {
  func normalizedForApp() -> PokemonList {
    PokemonList(
      count: count,
      next: next,
      pokemonItems: results.map { $0.normalizedForApp() }
    )
  }
}
