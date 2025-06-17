//
//  PokemonsList.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents a paginated list of Pokémon retrieved from the API.
struct PokemonList: PKMNModel {
  /// The total number of available Pokémon.
  let count: Int
  /// The URL string for the next page in the paginated list.
  let next: String
  /// The list of Pokémon items contained in this list.
  let pokemonItems: [PokemonListItem]
}
