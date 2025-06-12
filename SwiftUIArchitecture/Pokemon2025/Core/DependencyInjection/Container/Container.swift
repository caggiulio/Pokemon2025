//
//  DependencyManager.swift
//

import Factory
import Foundation

extension Container {
  var pokemonRepository: Factory<PokemonRepositoryProtocol> {
    self { Repository.Pokemon() }
      .scope(.cached)
  }
  
  var stateContainer: Factory<StateContainer> {
    self { StateContainer() }
      .scope(.cached)
  }
  
  var coordinator: Factory<Coordinator> {
    self { Coordinator() }
      .scope(.cached)
  }
  
  var networking: Factory<Networking> {
    self { Networking() }
      .scope(.cached)
  }
  
  var networkManager: Factory<NetworkManager> {
    self { NetworkManager(pokemonService: PokemonService()) }
      .scope(.cached)
  }
  
  var assembler: Factory<Assembler> {
    self { Assembler() }
      .scope(.cached)
  }
}
