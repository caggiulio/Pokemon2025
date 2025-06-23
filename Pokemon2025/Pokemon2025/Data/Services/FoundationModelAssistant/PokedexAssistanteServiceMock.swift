//
//  PokedexAssistanteServiceMock.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 23/06/25.
//

import Foundation

struct PokedexAssistanteServiceMock: PokedexAssistantServiceProtocol {
  func getPokemonInformation(from pokemon: Model.Entity.Pokemon) async throws -> PokemonInformation {
    PokemonInformation(
      description:
        "Pikachu is an Electric type Pokémon introduced in Generation 1. Pikachu has a Gigantamax form available in Pokémon Sword/Shield, with an exclusive G-Max move, G-Max Volt Crash.",
      types: ["Electric"]
    )
  }
}
