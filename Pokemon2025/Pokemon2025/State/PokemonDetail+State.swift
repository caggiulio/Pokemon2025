//
//  PokemonDetail+State.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation

/// The state in which the Pokemon detail information will stored.
public struct PokemonDetail {
  /// The selected Pokemon.
  var selectedPokemon: Model.Entity.Pokemon?

  /// The pokedex information provided by assistant.
  var pokedexInformation: Model.Foundation.PokemonInformation?
}
