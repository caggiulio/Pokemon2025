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
}
