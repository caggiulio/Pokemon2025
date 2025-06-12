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

  init(pokemon: PokemonDataSource) {
    name = pokemon.name
    url = "https://pokeapi.co/api/v2/" + "pokemon/\(pokemon.id)/"
  }
}

extension PokemonListItemDataSource: Normalizable {
  func normalizedForApp() -> PokemonListItem {
    PokemonListItem(
      name: name,
      imageURL: imageURL,
      id: getID(pokemonListItemDataSource: self),
      ranking: getID(pokemonListItemDataSource: self)
    )
  }

  private var imageURL: String {
    let baseUrl =
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%@.png"
    return String(format: baseUrl, getID(pokemonListItemDataSource: self))
  }

  private func getID(pokemonListItemDataSource: PokemonListItemDataSource) -> String {
    let components = pokemonListItemDataSource.url.components(separatedBy: "/")
    return components[components.count - 2]
  }
}
