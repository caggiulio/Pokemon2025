//
//  PokemonsList.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct PokemonList: PKMNModel {
  let count: Int
  let next: String
  let pokemonItems: [PokemonListItem]
}
