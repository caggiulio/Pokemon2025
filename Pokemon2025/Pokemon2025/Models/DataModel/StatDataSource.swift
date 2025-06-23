//
//  StatDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

extension Model.Data {
  /// A data transfer object representing a stat as received from the external API.
  /// Contains the stat name and the URL for more details about the stat.
  struct StatDataSource: Decodable {
    /// The name of the stat (e.g., "speed", "attack", etc.).
    let name: String
    /// The URL providing detailed information about this stat.
    let url: String
  }
}
