//
//  PokemonListItem.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// A lightweight model representing a Pokémon displayed in a list, including its name, image URL, identifier, and ranking.
struct PokemonListItem: PKMNModel, Identifiable, Equatable {
    /// The display name of the Pokémon.
    var name: String
    /// The URL string pointing to the Pokémon's image.
    var imageURL: String
    /// A unique identifier for the Pokémon.
    var id: String
    /// The Pokémon's ranking, represented as a string.
    var ranking: String
}

extension PokemonListItem {
  static func == (lhs: PokemonListItem, rhs: PokemonListItem) -> Bool {
    lhs.id == rhs.id
  }
}
