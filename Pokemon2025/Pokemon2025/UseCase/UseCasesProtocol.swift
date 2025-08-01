//
//  UseCasesProtocol.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 31/07/25.
//

protocol GetPokemonByIdentifierUseCase {
  /// Fetches a Pokémon by integer identifier after formatting it for HTTP.
  /// - Parameter identifier: The integer identifier of the Pokémon.
  /// - Throws: Rethrows errors from the Pokémon repository.
  func execute(identifier: Int) async throws
  /// Fetches a Pokémon by its identifier string.
  /// - Parameter identifier: The string identifier of the Pokémon.
  /// - Throws: Rethrows errors from the Pokémon repository.
  func execute(identifier: String) async throws
}

protocol FetchPokemonListUseCase {
  /// Fetches the Pokémon list from the repository.
  /// - Throws: Rethrows errors from the Pokémon repository.
  func execute() async throws
}

protocol GetPokedexAssistantInformationUseCase {
  /// Retrieves additional Pokédex assistant information for a given Pokémon.
  ///
  /// This method queries the repository for extra details about the specified Pokémon,
  /// such as flavor text, descriptions, or other auxiliary data obtained from the Pokédex assistant.
  ///
  /// - Parameter pokemon: The `Pokemon` entity for which additional information is requested.
  /// - Throws: Rethrows errors encountered by the repository during retrieval.
  /// - Note: This operation is asynchronous and may involve network or database access.
  func execute(for pokemon: Model.Entity.Pokemon) async throws
}

protocol ClearPokedexAssistantInformationCacheUseCase {
  /// Clears the cached Pokédex assistant information.
  ///
  /// This function instructs the repository to remove any locally stored data
  /// related to Pokédex assistant details, ensuring that subsequent queries
  /// will fetch fresh information rather than using potentially outdated cache.
  ///
  /// - Note: This operation is synchronous and does not throw errors.
  func execute()
}

protocol PrewarmPokedexAssistantUseCase {
  /// Executes the prewarming routine for the Pokédex assistant service.
  ///
  /// This method invokes any preparatory methods within the assistant service to
  /// ready internal models or state for faster subsequent use. Intended to be called
  /// as a background operation to minimize user-perceived latency.
  func execute()
}
