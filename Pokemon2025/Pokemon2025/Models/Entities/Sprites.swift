//
//  Sprites.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 17/06/25.
//

import Foundation

extension Model.Entity {
  struct Sprites: Decodable {
    /// The official artwork representations for this Pokémon.
    let officialArtwork: Model.Entity.OfficialArtwork
  }
}
