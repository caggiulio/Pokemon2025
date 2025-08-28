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
      name: "Pikachu",
      order: 1,
      species: .init(name: "Species"),
      frontImage: Model.Entity.FrontImage(
        stringURL:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
      ),
      stats: [.init(name: "Stat", baseStat: 1, percentStat: 1)],
      weight: 4
    ),
    pokedexInformation: Model.Foundation.PokemonInformation(
      description:
        "Pikachu is an Electric type Pokémon introduced in Generation 1. Pikachu has a Gigantamax form available in Pokémon Sword/Shield, with an exclusive G-Max move, G-Max Volt Crash.",
      types: ["Electric"],
      color: "#FFCB05"
    )
  )

  public var pokemonList = PokemonListState()

  public mutating func reset() {
    pokemonDetail = PokemonDetail()
    pokemonList = PokemonListState()
  }
}
