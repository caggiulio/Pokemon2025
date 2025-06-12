//
//  AbilitiesDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct AbilitiesDataSource: Decodable {
  let ability: AbilityDataSource
  let isHidden: Bool
  let slot: Int

  private enum CodingKeys: String, CodingKey {
    case ability
    case isHidden = "is_hidden"
    case slot
  }
}
