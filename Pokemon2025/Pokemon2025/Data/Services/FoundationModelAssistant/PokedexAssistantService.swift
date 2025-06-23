//
//  PokedexAssistantService.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 23/06/25.
//

import Factory
import Foundation
import FoundationModels
import Playgrounds

/// A service that communicates with a language model to retrieve Pokedex information about Pokémon.
struct PokedexAssistantService: PokedexAssistantServiceProtocol {

  // MARK: - Stored Properties

  /// The injected language model assistant used to interact with the underlying language model service.
  @Injected(\.foundationModelPokedexAssistant) private var pokedexAssistantService: FoundationModelPokedexAssistant

  @Injected(\.stateContainer) private var state: StateContainer

  // MARK: - Computed Properties

  /// Provides a language model session used for generating responses related to Pokémon data.
  var session: LanguageModelSession {
    pokedexAssistantService.getSession()
  }

  /// Retrieves Pokedex information for the specified Pokémon using the language model.
  /// - Parameter pokemon: The Pokémon for which to fetch information.
  /// - Returns: A `PokemonInformation` object containing the detailed Pokedex entry for the given Pokémon.
  /// - Throws: An error if the language model request fails.
  func getPokemonInformation(from pokemon: Model.Entity.Pokemon) async throws -> PokemonInformation {
    let response = try await session.respond(
      to: "Give me the Pokedex information for the Pokemon number #\(pokemon.id), with the name \(pokemon.name)",
      generating: PokemonInformation.self
    )
    return response.content
  }
}

#Playground {
  let service = PokedexAssistantService()
  let pokemon = Model.Entity.Pokemon(
    abilities: [.init(name: "Ability")],
    baseExperience: 70,
    forms: [.init(name: "Form")],
    height: 200,
    id: 150,
    name: "MewTwo",
    order: 1,
    species: .init(name: "Species"),
    frontImage: FrontImage(stringURL: "https://pokeapi.co/api/v2/pokemon/3/"),
    stats: [.init(name: "Stat", baseStat: 1, percentStat: 1)],
    weight: 4
  )
  let _ = try await service.getPokemonInformation(from: pokemon)
}
