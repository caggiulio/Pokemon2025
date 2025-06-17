//
//  PokemonDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// A data transfer object representing a Pokémon fetched from an external API, containing all core details as received from the network.
struct PokemonDataSource: Decodable {
  /// The abilities that this Pokémon can have.
  let abilities: [AbilitiesDataSource]
  /// The base experience gained for defeating this Pokémon.
  let baseExperience: Int
  /// Different forms the Pokémon can take.
  let forms: [FormsDataSource]
  /// The height of the Pokémon in decimetres.
  let height: Int
  /// The unique identifier for the Pokémon.
  let id: Int
  /// The name of the Pokémon.
  let name: String
  /// The order for sorting Pokémon; usually according to the National Pokédex.
  let order: Int
  /// The species data associated with the Pokémon.
  let species: SpeciesDataSource
  /// Visual representations/sprites of the Pokémon.
  let sprites: SpritesDataSource
  /// The base stats of the Pokémon.
  let stats: [StatsDataSource]
  /// The weight of the Pokémon in hectograms.
  let weight: Int

  /// Coding keys to map JSON keys to struct properties.
  private enum CodingKeys: String, CodingKey {
    case abilities
    case baseExperience = "base_experience"
    case forms
    case height
    case id
    case name
    case order
    case species
    case sprites
    case stats
    case weight
  }
}

// MARK: - Normalizable

extension PokemonDataSource: Normalizable {
  func normalizedForApp() -> Pokemon {
    Pokemon(
      abilities: abilities.map { $0.ability.normalizedForApp() },
      baseExperience: baseExperience,
      forms: forms.map { $0.normalizedForApp() },
      height: height,
      id: id,
      name: name,
      order: order,
      species: species.normalizedForApp(),
      frontImage: FrontImage(stringURL: sprites.officialArtwork.normalizedForApp().frontDefault),
      stats: stats.map { $0.normalizedForApp() },
      weight: weight
    )
  }
}
