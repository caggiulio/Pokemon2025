//
//  PokemonUseCase.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Factory
import Foundation

/// Contains use cases related to Pokémon.
extension UseCase {
  /// Retrieves a Pokémon by identifier.
  struct GetPokemonByIdentifier {
    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// Fetches a Pokémon by integer identifier after formatting it for HTTP.
    /// - Parameter identifier: The integer identifier of the Pokémon.
    /// - Throws: Rethrows errors from the Pokémon repository.
    /// - Returns: The Pokémon corresponding to the given identifier.
    func execute(identifier: Int) async throws {
      let identifier = identifier.httpFormatted()
      try await pokemonRepository.getPokemon(identifier: identifier)
    }

    /// Fetches a Pokémon by its identifier string.
    /// - Parameter identifier: The string identifier of the Pokémon.
    /// - Throws: Rethrows errors from the Pokémon repository.
    /// - Returns: The Pokémon corresponding to the given identifier string.
    func execute(identifier: String) async throws {
      try await pokemonRepository.getPokemon(identifier: identifier)
    }

    /// Fetches a random Pokémon in the range 1...150.
    /// - Throws: Rethrows errors from the Pokémon repository.
    /// - Returns: A randomly selected Pokémon.
    func execute() async throws {
      let identifier = Int.random(in: 1...150).formatted()
      try await pokemonRepository.getPokemon(identifier: identifier)
    }
  }

  /// Fetches the list of Pokémon.
  struct FetchPokemonList {
    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// Fetches the Pokémon list from the repository.
    /// - Throws: Rethrows errors from the Pokémon repository.
    func execute() async throws {
      try await pokemonRepository.fetchPokemonList()
    }
  }

  /// Use case for retrieving additional information for a Pokémon from the Pokédex assistant.
  struct GetPokedexAssistantInformation {
    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// Retrieves additional Pokédex assistant information for a given Pokémon.
    ///
    /// This method queries the repository for extra details about the specified Pokémon,
    /// such as flavor text, descriptions, or other auxiliary data obtained from the Pokédex assistant.
    ///
    /// - Parameter pokemon: The `Pokemon` entity for which additional information is requested.
    /// - Throws: Rethrows errors encountered by the repository during retrieval.
    /// - Note: This operation is asynchronous and may involve network or database access.
    func execute(for pokemon: Model.Entity.Pokemon) async throws {
      try await pokemonRepository.getPokedexInformation(for: pokemon)
    }
  }

  /// Use case for clearing the Pokédex assistant's cached information.
  struct ClearPokedexAssistantInformationCache {
    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// Clears the cached Pokédex assistant information.
    ///
    /// This function instructs the repository to remove any locally stored data
    /// related to Pokédex assistant details, ensuring that subsequent queries
    /// will fetch fresh information rather than using potentially outdated cache.
    ///
    /// - Note: This operation is synchronous and does not throw errors.
    func execute() {
      pokemonRepository.clearPokedexInformation()
    }
  }

  /// Use case for prewarming the Pokédex assistant service.
  struct PrewarmPokedexAssistant {
    /// The AI Assistant service that returns the Pokédex information.
    @Injected(\.pokedexAssistanService) private var pokedexAssistanService: PokedexAssistantServiceProtocol

    /// Executes the prewarming routine for the Pokédex assistant service.
    ///
    /// This method invokes any preparatory methods within the assistant service to
    /// ready internal models or state for faster subsequent use. Intended to be called
    /// as a background operation to minimize user-perceived latency.
    func execute() {
      pokedexAssistanService.prewarm()
    }
  }
}
