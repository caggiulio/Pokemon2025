//
//  PokemonsList.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct PokemonsList: PKMNModel {
  let count: Int
  let next: String
  let pokemonItems: [PokemonListItem]

  init(pokemonsListDataSource: PokemonListDataSource) {
    count = pokemonsListDataSource.count
    next = pokemonsListDataSource.next
    pokemonItems = pokemonsListDataSource.results.map { _pokemonListItemsDataSource in
      PokemonListItem(pokemonListItemDataSource: _pokemonListItemsDataSource)
    }
  }
}
