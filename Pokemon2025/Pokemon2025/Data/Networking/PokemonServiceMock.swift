//
//  PokemonServiceMock.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 17/06/25.
//

import Factory
import Foundation
import RealHTTP

// MARK: - NetworkWorker

struct PokemonServiceMock: PokemonServiceProtocol {

  // MARK: - Functions

  /// Get and transform the `PokemonDataSource` fetched from the network in the `Pokemon` return object.
  func getPokemon(id: String) async throws -> Model.Entity.Pokemon {
    Model.Entity.Pokemon(
      abilities: [.init(name: "Ability")],
      baseExperience: 70,
      forms: [.init(name: "Form")],
      height: 200,
      id: 1,
      name: "Pokemon",
      order: 1,
      species: .init(name: "Species"),
      frontImage: FrontImage(stringURL: "https://pokeapi.co/api/v2/pokemon/3/"),
      stats: [.init(name: "Stat", baseStat: 1, percentStat: 1)],
      weight: 4
    )
  }

  func getPokemonList(next: String?) async throws -> PokemonList {
    PokemonList(
      count: 3,
      next: "",
      pokemonItems: [
        PokemonListItem(
          name: "bulbasaur",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
          id: "1",
          ranking: "1"
        ),
        PokemonListItem(
          name: "ivysaur",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png",
          id: "2",
          ranking: "2"
        ),
        PokemonListItem(
          name: "venusaur",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png",
          id: "3",
          ranking: "3"
        ),
        PokemonListItem(
          name: "charmander",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
          id: "4",
          ranking: "4"
        ),
        PokemonListItem(
          name: "charmeleon",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png",
          id: "5",
          ranking: "5"
        ),
        PokemonListItem(
          name: "charizard",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png",
          id: "6",
          ranking: "6"
        ),
        PokemonListItem(
          name: "squirtle",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png",
          id: "7",
          ranking: "7"
        ),
        PokemonListItem(
          name: "wartortle",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png",
          id: "8",
          ranking: "8"
        ),
        PokemonListItem(
          name: "blastoise",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png",
          id: "9",
          ranking: "9"
        ),
        PokemonListItem(
          name: "caterpie",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10.png",
          id: "10",
          ranking: "10"
        ),
        PokemonListItem(
          name: "metapod",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/11.png",
          id: "11",
          ranking: "11"
        ),
        PokemonListItem(
          name: "butterfree",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/12.png",
          id: "12",
          ranking: "12"
        ),
        PokemonListItem(
          name: "weedle",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/13.png",
          id: "13",
          ranking: "13"
        ),
        PokemonListItem(
          name: "kakuna",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/14.png",
          id: "14",
          ranking: "14"
        ),
        PokemonListItem(
          name: "beedrill",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/15.png",
          id: "15",
          ranking: "15"
        ),
        PokemonListItem(
          name: "pidgey",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/16.png",
          id: "16",
          ranking: "16"
        ),
        PokemonListItem(
          name: "pidgeotto",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/17.png",
          id: "17",
          ranking: "17"
        ),
        PokemonListItem(
          name: "pidgeot",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/18.png",
          id: "18",
          ranking: "18"
        ),
        PokemonListItem(
          name: "rattata",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/19.png",
          id: "19",
          ranking: "19"
        ),
        PokemonListItem(
          name: "raticate",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/20.png",
          id: "20",
          ranking: "20"
        ),
      ]
    )
  }
}
