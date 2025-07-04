//
//  HomeListCell+ViewModel.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 03/07/25.
//

import Foundation
import SwiftUI

extension UI.Funnel.Home.View.List.Cell {
  /// A view model for an individual Pokémon cell in the home list.
  class ViewModel: ObservableObject {

    // MARK: - Stored Properties

    /// The Pokémon item associated with this cell.
    private(set) var pokemon: Model.Entity.PokemonListItem

    /// The matched geometry effect namespace used for coordinating view animations.
    private(set) var animation: Namespace.ID

    // MARK: - Computed Properties

    /// Returns the capitalized name of the given Pokémon.
    ///
    /// - Parameter pokemon: The `PokemonListItem` whose name should be formatted.
    /// - Returns: The capitalized name of the Pokémon as a `String`.
    var name: String {
      pokemon.name.capitalized
    }

    /// Returns a unique transition identifier for the given Pokémon item,
    /// used to match transitions in navigation or animation contexts.
    ///
    /// The identifier is constructed by combining the prefix "pokemon#" with
    /// the Pokémon's unique identifier, ensuring that each Pokémon can be
    /// distinctly referenced during view transitions.
    ///
    /// - Parameter pokemon: The `PokemonListItem` for which to generate the transition identifier.
    /// - Returns: A hashable value representing the unique transition identifier for the Pokémon.
    var matchedTransitionIdentifier: String {
      "pokemon#\(pokemon.id)"
    }

    /// Returns the image URL string for the Pokémon associated with this cell.
    ///
    /// This value is typically a fully qualified URL string pointing to the Pokémon's official artwork
    /// or sprite, which can be used to asynchronously load and display images in the interface.
    ///
    /// - Returns: A `String` representing the Pokémon's image URL.
    var imageURL: String {
      pokemon.imageURL
    }

    // MARK: - Init

    /// Initializes a new instance of the view model with the specified Pokémon and animation namespace.
    ///
    /// - Parameters:
    ///   - pokemon: The `PokemonListItem` model representing the Pokémon associated with this cell.
    ///   - animation: The matched geometry effect namespace used to coordinate view animations for this cell.
    init(pokemon: Model.Entity.PokemonListItem, animation: Namespace.ID) {
      self.animation = animation
      self.pokemon = pokemon
    }
  }
}
