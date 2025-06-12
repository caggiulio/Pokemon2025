//
//  OfficialArtworkDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct OfficialArtworkDataSource: Decodable {
  let frontDefault: String

  private enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
  }
}
