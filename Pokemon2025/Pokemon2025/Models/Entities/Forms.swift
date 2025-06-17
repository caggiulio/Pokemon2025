//
//  Forms.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/// A model representing a specific form of a Pokémon.
/// This struct encapsulates information about the form, such as its name.
struct Forms: PKMNModel {
  /// The unique name of this Pokémon form.
  let name: String

  // MARK: - Init

  /// Initializes a `Forms` instance from a data source.
  /// - Parameter formsDataSource: The data source containing the form's information.
  init(formsDataSource: FormsDataSource) {
    name = formsDataSource.name
  }
}
