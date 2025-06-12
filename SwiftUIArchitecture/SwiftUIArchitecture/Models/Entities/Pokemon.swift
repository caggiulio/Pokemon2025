//
//  Pokemon.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct Pokemon: Identifiable, PKMNModel {
  let abilities: [Ability]
  let baseExperience: Int
  let forms: [Forms]
  let height: Int
  let id: Int
  let name: String
  let order: Int
  let species: Species
  let frontImage: FrontImage
  let stats: [Stat]
  let weight: Int
  
  // MARK: - Init

  init(pokemonDataSource: PokemonDataSource) {
    abilities = pokemonDataSource.abilities.map { _abilities in
      Ability(abilityDataSource: _abilities.ability)
    }
    baseExperience = pokemonDataSource.baseExperience
    forms = pokemonDataSource.forms.map { formDataSource in
      Forms(formsDataSource: formDataSource)
    }
    height = pokemonDataSource.height
    id = pokemonDataSource.id
    name = pokemonDataSource.name
    order = pokemonDataSource.order
    species = Species(speciesDataSource: pokemonDataSource.species)
    frontImage = FrontImage(spritesDataSource: pokemonDataSource.sprites)
    stats = pokemonDataSource.stats.map { statDataSource in
      Stat(statDataSource: statDataSource)
    }
    weight = pokemonDataSource.weight
  }
}
