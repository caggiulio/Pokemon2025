//
//  SpritesDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct SpritesDataSource: Decodable {
  let officialArtwork: OfficialArtworkDataSource

  private enum RootKeys: String, CodingKey {
    case other
  }

  private enum CodingKeys: String, CodingKey {
    case officialArtwork = "official-artwork"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: RootKeys.self)
    let container = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
    officialArtwork = try container.decode(OfficialArtworkDataSource.self, forKey: .officialArtwork)
  }
}
