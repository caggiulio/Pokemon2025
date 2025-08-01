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
  struct GetPokemonByIdentifier: GetPokemonByIdentifierUseCase {

    // MARK: - Stored Properties

    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    // MARK: - Protocol

    func execute(identifier: Int) async throws {
      let identifier = identifier.httpFormatted()
      let pokemon = try await pokemonRepository.getPokemon(identifier: identifier)
      stateContainer.state.pokemonDetail.selectedPokemon = pokemon
    }

    func execute(identifier: String) async throws {
      let identifier = identifier.httpFormatted()
      let pokemon = try await pokemonRepository.getPokemon(identifier: identifier)
      stateContainer.state.pokemonDetail.selectedPokemon = pokemon
    }
  }

  /// Fetches the list of Pokémon.
  struct FetchPokemonList: FetchPokemonListUseCase {

    // MARK: - Stored Properties

    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    // MARK: - Protocol

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
  struct GetPokedexAssistantInformation: GetPokedexAssistantInformationUseCase {

    // MARK: - Stored Properties

    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    // MARK: - Protocol

    func execute(for pokemon: Model.Entity.Pokemon) async throws {
      let pokedexInformation = try await pokemonRepository.getPokedexInformation(for: pokemon)
      stateContainer.state.pokemonDetail.pokedexInformation = pokedexInformation
    }
  }

  /// Use case for clearing the Pokédex assistant's cached information.
  struct ClearPokedexAssistantInformationCache: ClearPokedexAssistantInformationCacheUseCase {

    // MARK: - Stored Properties

    /// The Pokémon repository dependency.
    @Injected(\.pokemonRepository) private var pokemonRepository: PokemonRepositoryProtocol

    /// The `AppState`.
    @Injected(\.stateContainer) private var stateContainer: StateContainer

    // MARK: - Protocol

    func execute() {
      stateContainer.state.pokemonDetail.pokedexInformation = nil
    }
  }

  /// Use case for prewarming the Pokédex assistant service.
  struct PrewarmPokedexAssistant: PrewarmPokedexAssistantUseCase {

    // MARK: - Stored Properties

    /// The AI Assistant service that returns the Pokédex information.
    @Injected(\.pokedexAssistantService) private var pokedexAssistanService: PokedexAssistantServiceProtocol

    // MARK: - Protocol

    func execute() {
      pokedexAssistanService.prewarm()
    }
  }
}
