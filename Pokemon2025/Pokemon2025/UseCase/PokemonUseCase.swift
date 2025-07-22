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

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    /// Fetches a Pokémon by integer identifier after formatting it for HTTP.
    /// - Parameter identifier: The integer identifier of the Pokémon.
    /// - Throws: Rethrows errors from the Pokémon repository.
    func execute(identifier: Int) async throws {
      let identifier = identifier.httpFormatted()
      let pokemon = try await pokemonRepository.getPokemon(identifier: identifier)
      stateContainer.state.pokemonDetail.selectedPokemon = pokemon
    }

    /// Fetches a Pokémon by its identifier string.
    /// - Parameter identifier: The string identifier of the Pokémon.
    /// - Throws: Rethrows errors from the Pokémon repository.
    func execute(identifier: String) async throws {
      let identifier = identifier.httpFormatted()
      let pokemon = try await pokemonRepository.getPokemon(identifier: identifier)
      stateContainer.state.pokemonDetail.selectedPokemon = pokemon
    }
  }

  /// Fetches the list of Pokémon.
  struct FetchPokemonList {
    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    /// Fetches the Pokémon list from the repository.
    /// - Throws: Rethrows errors from the Pokémon repository.
    func execute() async throws {
      let pokemonList = try await pokemonRepository.fetchPokemonList(
        next: stateContainer.state.pokemonList.pokemonList?.next
      )
      if let pokemonListState = stateContainer.state.pokemonList.pokemonList,
        pokemonListState.pokemonItems.allSatisfy({ pokemon in
          pokemonList.pokemonItems.contains { $0 == pokemon }
        })
      {
        return
      }

      var pokemonItems = stateContainer.state.pokemonList.pokemonList?.pokemonItems ?? []
      pokemonItems += pokemonList.pokemonItems
      let newPokemonList = Model.Entity.PokemonList(
        count: pokemonList.count,
        next: pokemonList.next,
        pokemonItems: pokemonItems
      )

      stateContainer.state.pokemonList.pokemonList = newPokemonList
    }
  }

  /// Use case for retrieving additional information for a Pokémon from the Pokédex assistant.
  struct GetPokedexAssistantInformation {
    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    /// Retrieves additional Pokédex assistant information for a given Pokémon.
    ///
    /// This method queries the repository for extra details about the specified Pokémon,
    /// such as flavor text, descriptions, or other auxiliary data obtained from the Pokédex assistant.
    ///
    /// - Parameter pokemon: The `Pokemon` entity for which additional information is requested.
    /// - Throws: Rethrows errors encountered by the repository during retrieval.
    /// - Note: This operation is asynchronous and may involve network or database access.
    func execute(for pokemon: Model.Entity.Pokemon) async throws {
      let pokedexInformation = try await pokemonRepository.getPokedexInformation(for: pokemon)
      stateContainer.state.pokemonDetail.pokedexInformation = pokedexInformation
    }
  }

  /// Use case for clearing the Pokédex assistant's cached information.
  struct ClearPokedexAssistantInformationCache {
    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    /// Clears the cached Pokédex assistant information.
    ///
    /// This function instructs the repository to remove any locally stored data
    /// related to Pokédex assistant details, ensuring that subsequent queries
    /// will fetch fresh information rather than using potentially outdated cache.
    ///
    /// - Note: This operation is synchronous and does not throw errors.
    func execute() {
      stateContainer.state.pokemonDetail.pokedexInformation = nil
    }
  }

  /// Use case for prewarming the Pokédex assistant service.
  struct PrewarmPokedexAssistant {
    /// The AI Assistant service that returns the Pokédex information.
    @Injected(\.pokedexAssistantService) private var pokedexAssistanService: PokedexAssistantServiceProtocol

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
