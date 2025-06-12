//
//  PokemonDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct PokemonDataSource: Decodable {
  let abilities: [AbilitiesDataSource]
  let baseExperience: Int
  let forms: [FormsDataSource]
  let height: Int
  let id: Int
  let name: String
  let order: Int
  let species: SpeciesDataSource
  let sprites: SpritesDataSource
  let stats: [StatsDataSource]
  let weight: Int

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

extension PokemonDataSource: Normalizable {
  func normalizedForApp() -> Pokemon {
    Pokemon(pokemonDataSource: self)
  }
}
