//
//  PokemonRepositoryProtocol.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/12/23.
//

import Foundation

public protocol PokemonRepositoryProtocol {
  func getPokemon(identifier: String) async throws
}
