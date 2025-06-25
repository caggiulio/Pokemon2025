//
//  Home+View.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import CachedAsyncImage
import Factory
import SwiftUI

extension UI.Funnel.Home {
  /// The main view displaying a grid of Pokémon with asynchronous image loading,
  /// handling loading states and navigation bar visibility.
  struct View: SwiftUI.View {

    // MARK: - Stored Properties

    /// The `UI.Funnel.Home.ViewModel` managing the state and data for this view.
    @StateObject private var viewModel = UI.Funnel.Home.ViewModel()

    /// A namespace for matched geometry effects, enabling smooth transitions and animations
    /// between views that share the same matched geometry effect identifier.
    ///
    /// - Note: `@Namespace` provides a unique namespace value for the view hierarchy, which
    ///         is typically used with `.matchedGeometryEffect(id:in:)` to create coordinated
    ///         animations between views.
    @Namespace private var animation

    // MARK: - View

    var body: some SwiftUI.View {
      ZStack {
        ScrollView(.vertical) {
          LazyVGrid(
            columns: [
              GridItem(.flexible()),
              GridItem(.flexible()),
            ],
            spacing: .small
          ) {
            ForEach(viewModel.pokemons) {
              pokemonCell(for: $0)
            }
          }
          .padding(.horizontal, .small)
        }

        UI.Funnel.Home.View.Search(isSearchingBinding: $viewModel.isSearching)
          .searchable(text: $viewModel.searchString)
      }
      .navigationTitle(viewModel.navigationTitle)
      .loader(isShowing: viewModel.localState.isLoading)
      .animatedBackground()
    }

    /// Creates a view representing a single Pokémon cell including its image and name.
    /// - Parameter pokemon: The Pokémon item to display in the cell.
    /// - Returns: A SwiftUI view representing the Pokémon cell.
    private func pokemonCell(for pokemon: Model.Entity.PokemonListItem) -> some SwiftUI.View {
      VStack(spacing: .zero) {
        CachedAsyncImage(url: URL(string: pokemon.imageURL)) { image in
          image
            .resizable()
        } placeholder: {
          Image(.pokeball)
            .resizable()
        }
        .frame(width: .xLarge, height: .xLarge)
        .clipped()

        Text(viewModel.name(for: pokemon))
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
      .matchedTransitionSource(id: viewModel.matchedTransitionIdentifier(for: pokemon), in: animation)
      .onAppear {
        if pokemon == viewModel.pokemons.last {
          Task {
            try await viewModel.loadOthers()
          }
        }
      }
      .onTapGesture {
        Task {
          try await viewModel.fetchPokemonDetail(for: pokemon, animation: animation)
        }
      }
    }
  }
}

#Preview("Home") {
  NavigationStack {
    UI.Funnel.Home.View()
      .onAppear {
        Task {
          try await UseCase.FetchPokemonList().execute()
        }
      }
  }
}
