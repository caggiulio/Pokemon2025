//
//  NetworkWorker.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Factory
import Foundation
import RealHTTP

// MARK: - NetworkWorker

struct PokemonService: PokemonServiceProtocol {

  // MARK: - Stored Properties

  /// The networking object.
  @Injected(\.networking) private var networking: Networking

  // MARK: - Functions

  func getPokemon(id: String) async throws -> Model.Entity.Pokemon {
    let request = HTTPRequest {
      $0.path = "/pokemon/\(id)"
      $0.method = .get
    }

    return try await request.fetch(networking.client).decode(PokemonDataSource.self).normalizedForApp()
  }

  func getPokemonList(next: String?) async throws -> PokemonList {
    let request: HTTPRequest
    guard let next, let nextURL = URL(string: next) else {
      request = HTTPRequest {
        $0.path = "/pokemon"
        $0.method = .get
      }

      return try await executeGetPokemonList(with: request)
    }
    request = try HTTPRequest(nextURL)

    return try await executeGetPokemonList(with: request)
  }

  private func executeGetPokemonList(with request: HTTPRequest) async throws -> PokemonList {
    try await request.fetch(networking.client).decode(PokemonListDataSource.self).normalizedForApp()
  }
}
