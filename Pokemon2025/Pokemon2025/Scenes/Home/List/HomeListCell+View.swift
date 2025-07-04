//
//  HomeListCell.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 03/07/25.
//

import CachedAsyncImage
import Foundation
import SwiftUI

extension UI.Funnel.Home.View.List {
  /// A SwiftUI view representing an individual cell in the Pokémon list for the Home screen.
  ///
  /// This cell displays a Pokémon’s image and name, and supports smooth transition animations
  /// and tap interactions. The view uses a view model to manage its state, including Pokémon data,
  /// image loading, and animation namespace for matched geometry effects.
  struct Cell: SwiftUI.View {

    // MARK: - Stored Properties

    /// An observable view model responsible for managing the state and logic for rendering an individual Pokémon cell in the list.
    @StateObject private var viewModel: UI.Funnel.Home.View.List.Cell.ViewModel

    /// An optional interaction handler to be invoked when the cell is tapped; receives the associated Pokémon item as input.
    private var onTapInteraction: CustomInteraction<Model.Entity.PokemonListItem>?

    // MARK: - Init

    /// Initializes a new instance of `Cell` displaying the provided Pokémon list item.
    ///
    /// - Parameters:
    ///   - pokemon: The Pokémon item to be represented by this cell.
    ///   - animation: The namespace ID used for matched geometry effects/animations.
    ///   - onTapInteraction: An optional interaction handler to be invoked when the cell is tapped; receives the associated Pokémon item as input.
    init(
      pokemon: Model.Entity.PokemonListItem,
      animation: Namespace.ID,
      onTapInteraction: CustomInteraction<Model.Entity.PokemonListItem>?
    ) {
      self.onTapInteraction = onTapInteraction
      let viewModel = UI.Funnel.Home.View.List.Cell.ViewModel(pokemon: pokemon, animation: animation)
      _viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - View

    var body: some SwiftUI.View {
      VStack(spacing: .zero) {
        CachedAsyncImage(url: URL(string: viewModel.imageURL)) { image in
          image
            .resizable()
        } placeholder: {
          Image(.pokeball)
            .resizable()
        }
        .frame(width: .xLarge, height: .xLarge)
        .clipped()

        Text(viewModel.name)
          .fontWeight(.bold)
          .fontDesign(.rounded)
          .foregroundStyle(.white)
      }
      .frame(width: .xLarge + .medium, height: .xLarge + .medium)
      .background {
        Color.white.opacity(0.2)
          .clipShape(RoundedRectangle(cornerRadius: .medium))
      }
      .scrollTransition { view, phase in
        view
          .grayscale(phase.isIdentity ? .zero : 0.5)
      }
      .matchedTransitionSource(id: viewModel.matchedTransitionIdentifier, in: viewModel.animation)
      .onTapGesture {
        onTapInteraction?(viewModel.pokemon)
      }
    }
  }
}

#Preview("Cell") {
  @Previewable @Namespace var namespace

  UI.Funnel.Home.View.List.Cell(
    pokemon: Model.Entity.PokemonListItem(
      name: "Bulbasaur",
      imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
      id: "1",
      ranking: "1"
    ),
    animation: namespace,
    onTapInteraction: nil
  )
  .padding(.medium)
  .animatedBackground()
}
