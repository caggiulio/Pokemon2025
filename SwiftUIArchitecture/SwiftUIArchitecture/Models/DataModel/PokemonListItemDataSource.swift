//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//
import Foundation

struct PokemonListItemDataSource: Decodable {
  let name: String
  let url: String

  init(pokemon: Pokemon) {
    name = pokemon.name
    url = "https://pokeapi.co/api/v2/" + "pokemon/\(pokemon.id)/"
  }
}
