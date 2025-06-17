//
//  SpeciesDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Data model representing a Pokémon species entry from the remote API.
struct SpeciesDataSource: Decodable {
  /// The name of the species.
  let name: String
  /// The detailed URL for this species entry in the API.
  let url: String
}
