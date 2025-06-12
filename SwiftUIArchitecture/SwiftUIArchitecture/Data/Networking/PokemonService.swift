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
  
  /// Get and transform the `PokemonDataSource` fetched from the network in the `Pokemon` return object.
  func getPokemon(id: String) async throws -> Pokemon {
    let request = HTTPRequest {
      $0.path = "/pokemon/\(id)"
      $0.method = .get
    }
    
    return try await request.fetch(networking.client).decode(PokemonDataSource.self).normalizedForApp()
  }
}
