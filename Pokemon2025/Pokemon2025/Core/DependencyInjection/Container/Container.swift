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

  var pokemonService: Factory<PokemonServiceProtocol> {
    self { PokemonService() }
      .scope(.cached)
      .onPreview {
        PokemonServiceMock()
      }
  }

  var mainAssembler: Factory<Assembler.Main> {
    self { Assembler.Main() }
      .scope(.cached)
  }

  var homeAssembler: Factory<Assembler.Home> {
    self { Assembler.Home() }
      .scope(.cached)
  }

  var foundationModelPokedexAssistant: Factory<FoundationModelPokedexAssistant> {
    self { FoundationModelPokedexAssistant() }
      .scope(.cached)
  }

  var pokedexAssistantService: Factory<PokedexAssistantServiceProtocol> {
    self { PokedexAssistantService() }
      .scope(.cached)
      .onPreview {
        PokedexAssistanteServiceMock()
      }
  }

  var appState: Factory<AppStateable> {
    self { AppState() }
      .scope(.cached)
      .onPreview {
        AppStateMock()
      }
  }
}
