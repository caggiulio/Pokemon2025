//
//  AppState.swift
//

import Foundation

public struct AppState: AppStateable {
  public var pokemonDetail = PokemonDetail()

  public var pokemonList = PokemonListState()

  public mutating func reset() {
    pokemonDetail = PokemonDetail()
    pokemonList = PokemonListState()
  }
}
