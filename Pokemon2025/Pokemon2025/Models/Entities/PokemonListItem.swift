//
//  PokemonListItem.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

extension Model.Entity {
  /// A lightweight model representing a Pokémon displayed in a list, including its name, image URL, identifier, and ranking.
  struct PokemonListItem: PKMNModel, Identifiable, Equatable, Hashable {
    /// The display name of the Pokémon.
    var name: String
    /// The URL string pointing to the Pokémon's image.
    var imageURL: String
    /// A unique identifier for the Pokémon.
    var id: String
    /// The Pokémon's ranking, represented as a string.
    var ranking: String
  }
}

extension Model.Entity.PokemonListItem {
  static func == (lhs: Model.Entity.PokemonListItem, rhs: Model.Entity.PokemonListItem) -> Bool {
    lhs.id == rhs.id
  }
}
