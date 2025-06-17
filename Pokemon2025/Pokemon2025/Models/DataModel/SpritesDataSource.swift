//
//  SpritesDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// A data transfer object for sprites information of a Pokémon, specifically decoding the
/// 'other/official-artwork' section from the remote API response.
struct SpritesDataSource: Decodable {
  /// The official artwork representations for this Pokémon.
  let officialArtwork: OfficialArtworkDataSource

  private enum RootKeys: String, CodingKey {
    case other
  }

  private enum CodingKeys: String, CodingKey {
    case officialArtwork = "official-artwork"
  }

  /// Initializes a new instance by decoding the 'other/official-artwork' object from the API response.
  /// - Parameter decoder: The decoder to read data from.
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: RootKeys.self)
    let container = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
    officialArtwork = try container.decode(OfficialArtworkDataSource.self, forKey: .officialArtwork)
  }
}
