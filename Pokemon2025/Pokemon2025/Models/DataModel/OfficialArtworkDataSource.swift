//
//  OfficialArtworkDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// A data source representing the official artwork image URLs for a Pokémon.
struct OfficialArtworkDataSource: Decodable {
  /// The URL string for the Pokémon's default front official artwork image.
  let frontDefault: String

  private enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
  }
}
