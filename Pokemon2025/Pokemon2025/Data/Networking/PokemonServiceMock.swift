//
//  PokemonServiceMock.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 17/06/25.
//

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
      frontImage: Model.Entity.FrontImage(stringURL: "https://pokeapi.co/api/v2/pokemon/3/"),
      stats: [.init(name: "Stat", baseStat: 1, percentStat: 1)],
      weight: 4
    )
  }

  func getPokemonList(next: String?) async throws -> Model.Entity.PokemonList {
    Model.Entity.PokemonList(
      count: 3,
      next: "",
      pokemonItems: [
        Model.Entity.PokemonListItem(
          name: "bulbasaur",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
          id: "1",
          ranking: "1"
        ),
        Model.Entity.PokemonListItem(
          name: "ivysaur",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png",
          id: "2",
          ranking: "2"
        ),
        Model.Entity.PokemonListItem(
          name: "venusaur",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png",
          id: "3",
          ranking: "3"
        ),
        Model.Entity.PokemonListItem(
          name: "charmander",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
          id: "4",
          ranking: "4"
        ),
        Model.Entity.PokemonListItem(
          name: "charmeleon",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png",
          id: "5",
          ranking: "5"
        ),
        Model.Entity.PokemonListItem(
          name: "charizard",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png",
          id: "6",
          ranking: "6"
        ),
        Model.Entity.PokemonListItem(
          name: "squirtle",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png",
          id: "7",
          ranking: "7"
        ),
        Model.Entity.PokemonListItem(
          name: "wartortle",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png",
          id: "8",
          ranking: "8"
        ),
        Model.Entity.PokemonListItem(
          name: "blastoise",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png",
          id: "9",
          ranking: "9"
        ),
        Model.Entity.PokemonListItem(
          name: "caterpie",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10.png",
          id: "10",
          ranking: "10"
        ),
        Model.Entity.PokemonListItem(
          name: "metapod",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/11.png",
          id: "11",
          ranking: "11"
        ),
        Model.Entity.PokemonListItem(
          name: "butterfree",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/12.png",
          id: "12",
          ranking: "12"
        ),
        Model.Entity.PokemonListItem(
          name: "weedle",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/13.png",
          id: "13",
          ranking: "13"
        ),
        Model.Entity.PokemonListItem(
          name: "kakuna",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/14.png",
          id: "14",
          ranking: "14"
        ),
        Model.Entity.PokemonListItem(
          name: "beedrill",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/15.png",
          id: "15",
          ranking: "15"
        ),
        Model.Entity.PokemonListItem(
          name: "pidgey",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/16.png",
          id: "16",
          ranking: "16"
        ),
        Model.Entity.PokemonListItem(
          name: "pidgeotto",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/17.png",
          id: "17",
          ranking: "17"
        ),
        Model.Entity.PokemonListItem(
          name: "pidgeot",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/18.png",
          id: "18",
          ranking: "18"
        ),
        Model.Entity.PokemonListItem(
          name: "rattata",
          imageURL:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/19.png",
          id: "19",
          ranking: "19"
        ),
        Model.Entity.PokemonListItem(
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
