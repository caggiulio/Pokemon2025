//
//  PKMNNetworkingManager.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// A data source model representing a Pokémon entry from the remote API.
/// Provides the name, detailed URL, and methods to extract image URL and ID.
struct PokemonListItemDataSource: Decodable {
  /// The name of the Pokémon.
  let name: String
  /// The detailed URL for this Pokémon entry in the API.
  let url: String

  /// Initializes a new data source item for a Pokémon.
  /// - Parameter pokemon: The source Pokémon data object.
  init(pokemon: PokemonDataSource) {
    name = pokemon.name
    url = "https://pokeapi.co/api/v2/" + "pokemon/\(pokemon.id)/"
  }

  /// The image URL for the Pokémon's official artwork.
  private var imageURL: String {
    let baseUrl =
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%@.png"
    return String(format: baseUrl, getID(pokemonListItemDataSource: self))
  }

  /// Extracts the numeric Pokémon ID from the API URL.
  /// - Parameter pokemonListItemDataSource: The data source instance to extract from.
  /// - Returns: The Pokémon's numeric ID as a string.
  private func getID(pokemonListItemDataSource: PokemonListItemDataSource) -> String {
    let components = pokemonListItemDataSource.url.components(separatedBy: "/")
    return components[components.count - 2]
  }
}

// MARK: - Normalizable

extension PokemonListItemDataSource: Normalizable {
  /// Normalizes the data source for use within the app as a `PokemonListItem`.
  func normalizedForApp() -> PokemonListItem {
    PokemonListItem(
      name: name,
      imageURL: imageURL,
      id: getID(pokemonListItemDataSource: self),
      ranking: getID(pokemonListItemDataSource: self)
    )
  }
}
