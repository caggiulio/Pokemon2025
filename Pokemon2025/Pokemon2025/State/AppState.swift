//
//  AppState.swift
//

import Foundation

/// Represents the global state of the application, containing all app-wide state data.
public struct AppState: AppStateable {

  // MARK: - Stored Properties

  /// The state associated with the currently selected Pokémon's detail view.
  public var pokemonDetail = Model.State.PokemonDetail()

  /// The state for the Pokémon list view, containing all loaded Pokémon.
  public var pokemonList = Model.State.PokemonList()

  // MARK: - Methods

  /// Resets all state to their initial values.
  public mutating func reset() {
    pokemonDetail = Model.State.PokemonDetail()
    pokemonList = Model.State.PokemonList()
  }
}
