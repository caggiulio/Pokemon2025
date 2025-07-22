//
//  AppState.swift
//

import Foundation

/// Represents the global state of the application, containing all app-wide state data.
public struct AppState: AppStateable {

  // MARK: - Stored Properties

  /// The state associated with the currently selected Pokémon's detail view.
  public var pokemonDetail = PokemonDetail()

  /// The state for the Pokémon list view, containing all loaded Pokémon.
  public var pokemonList = PokemonListState()

  // MARK: - Methods

  /// Resets all state to their initial values.
  public mutating func reset() {
    pokemonDetail = PokemonDetail()
    pokemonList = PokemonListState()
  }
}
