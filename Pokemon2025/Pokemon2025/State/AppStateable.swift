//
//  AppStateable.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 07/07/25.
//

/// The App state in which every current session information is stored. Is used only to store data.
public protocol AppStateable {
  /// The `PokemonDetail` state.
  var pokemonDetail: PokemonDetail { get set }

  /// The `PokemonListState` state.
  var pokemonList: PokemonListState { get set }

  /// The func to reset the app state.
  mutating func reset()
}
