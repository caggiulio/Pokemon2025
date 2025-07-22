//
//  PokemonDetail.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 12/06/25.
//

/// Represents the state for the Pokemon list view, holding the current list of Pokemon (if loaded).
public struct PokemonListState {
  
  // MARK: - Stored Properties
  
  /// The current list of Pokemon fetched from the data source. Nil if not yet loaded or on error.
  var pokemonList: Model.Entity.PokemonList?
}
