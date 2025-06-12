//
//  PokemonListItem.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct PokemonListItem: PKMNModel, Identifiable, Equatable {
  var name: String
  var imageURL: String
  var id: String
  var ranking: String
}

extension PokemonListItem {
  static func == (lhs: PokemonListItem, rhs: PokemonListItem) -> Bool {
    lhs.id == rhs.id
  }
}
