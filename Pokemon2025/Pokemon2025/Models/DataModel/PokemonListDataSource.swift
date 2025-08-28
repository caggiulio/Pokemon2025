//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//
import Foundation

extension Model.Data {
  /// A data source model representing a list of Pokémon fetched from the network API.
  struct PokemonListDataSource: Decodable {
    /// The total number of Pokémon available from the API.
    let count: Int
    /// The URL for the next page of Pokémon, if available.
    let next: String
    /// The list of Pokémon items for the current page.
    let results: [PokemonListItemDataSource]
  }
}

// MARK: - Normalizable

extension Model.Data.PokemonListDataSource: Normalizable {
  func normalizedForApp() -> Model.Entity.PokemonList {
    Model.Entity.PokemonList(
      count: count,
      next: next,
      pokemonItems: results.map { $0.normalizedForApp() }
    )
  }
}
