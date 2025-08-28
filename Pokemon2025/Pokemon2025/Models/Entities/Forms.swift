//
//  Forms.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

extension Model.Entity {
  /// A model representing a specific form of a Pokémon.
  /// This struct encapsulates information about the form, such as its name.
  struct Forms: PKMNModel {
    /// The unique name of this Pokémon form.
    let name: String
  }

}
