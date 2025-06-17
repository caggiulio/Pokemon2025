//
//  FormsDataSource.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// Represents the data source for a Pokémon form, typically used for decoding API responses.
struct FormsDataSource: Decodable {
    /// The name of the Pokémon form.
    let name: String
    /// The URL endpoint associated with the Pokémon form.
    let url: String
}
