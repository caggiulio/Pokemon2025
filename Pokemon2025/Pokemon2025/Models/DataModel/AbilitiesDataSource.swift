//
//  AbilitiesDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

extension Model.Data {
  /// Represents a data source for a Pokémon's ability as returned from the API.
  struct AbilitiesDataSource: Decodable {
    /// The main ability information of the Pokémon.
    let ability: AbilityDataSource
    /// Indicates whether this ability is hidden for the Pokémon.
    let isHidden: Bool
    /// The slot position of this ability for the Pokémon.
    let slot: Int

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      case ability
      case isHidden = "is_hidden"
      case slot
    }
  }

}
