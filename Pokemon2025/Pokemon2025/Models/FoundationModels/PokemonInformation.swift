//
//  PokemonInformation.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 23/06/25.
//

import Foundation
import FoundationModels
import SwiftUI

extension Model.Foundation {
  /// Represents detailed information about a Pokémon, including its Pokedex description and advantageous categories.
  @Generable
  struct PokemonInformation {
    /// The Pokedex description of the Pokémon.
    @Guide(description: "The Pokedex description of the Pokemon.")
    var description: String

    /// The types of the Pokemon.
    @Guide(description: "The types with which the Pokemon is identified.")
    var types: [String]

    /// The type color of the Pokemon.
    @Guide(description: "The type SwiftUI Color HEX of the Pokemon. (Example: #ff0000)")
    var color: String
  }
}
