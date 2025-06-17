//
//  Pokemon.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents a Pokémon entity with various stats, forms, and details.
struct Pokemon: Identifiable, PKMNModel {
  /// The abilities that the Pokémon can have.
  let abilities: [Ability]
  /// The base experience value gained for defeating this Pokémon.
  let baseExperience: Int
  /// The different forms this Pokémon can take.
  let forms: [Forms]
  /// The height of the Pokémon in decimetres.
  let height: Int
  /// The unique identifier of the Pokémon.
  let id: Int
  /// The name of the Pokémon.
  let name: String
  /// The order value for sorting Pokémon species.
  let order: Int
  /// The species details for the Pokémon.
  let species: Species
  /// The front-facing image/sprite set for this Pokémon.
  let frontImage: FrontImage
  /// The stats describing this Pokémon's capabilities.
  let stats: [Stat]
  /// The weight of the Pokémon in hectograms.
  let weight: Int

  // MARK: - Init
  
  /// Initializes a new `Pokemon` from a given data source.
  /// - Parameter pokemonDataSource: The data source containing Pokémon details.
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
