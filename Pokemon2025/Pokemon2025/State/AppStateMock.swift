//
//  AppStatMocke.swift
//

import Foundation

public struct AppStateMock: AppStateable {
  public var pokemonDetail = PokemonDetail(
    selectedPokemon: Model.Entity.Pokemon(
      abilities: [.init(name: "Ability")],
      baseExperience: 70,
      forms: [.init(name: "Form")],
      height: 200,
      id: 1,
      name: "Pokemon",
      order: 1,
      species: .init(name: "Species"),
      frontImage: Model.Entity.FrontImage(
        stringURL:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
      ),
      stats: [.init(name: "Stat", baseStat: 1, percentStat: 1)],
      weight: 4
    )
  )

  public var pokemonList = PokemonListState()

  public mutating func reset() {
    pokemonDetail = PokemonDetail()
    pokemonList = PokemonListState()
  }
}
