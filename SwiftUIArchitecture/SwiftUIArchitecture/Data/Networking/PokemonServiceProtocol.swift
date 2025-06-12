//
//  NetworkDataSourceProtocol.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation

/// The protocol to defines the list of API calls to implements.
protocol PokemonServiceProtocol {
  func getPokemon(id: String) async throws -> Pokemon
}
