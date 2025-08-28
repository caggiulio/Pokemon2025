//
//  HomeList+View.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 03/07/25.
//

import Foundation
import SwiftUI

extension UI.Funnel.Home.View {
  /// A SwiftUI view that displays a grid list of Pokémon items.
  ///
  /// `List` is responsible for rendering a two-column vertical grid of Pokémon, each represented by a cell.
  /// It supports infinite scrolling by triggering an optional closure when the bottom of the list is reached,
  /// and coordinates with the parent view's search state using a binding. Smooth animations and transitions
  /// are enabled using a namespace for matched geometry effects.
  struct List: SwiftUI.View {

    // MARK: - Stored Properties

    /// Binding to the external search state, allowing two-way sync with parent.
    @Binding var isSearchingBinding: Bool

    /// The list of Pokémon items to be displayed or managed in the home list view.
    ///
    /// This published array holds instances of `PokemonListItem`, representing each Pokémon's
    /// summary information (name, image, etc.) for presentation in the UI. Changes to this array
    /// will trigger UI updates in any observing SwiftUI views.
    private var pokemons: [Model.Entity.PokemonListItem] = []

    /// Holds the current list of Pokémon items to be displayed in the UI.
    @StateObject private var viewModel = UI.Funnel.Home.View.List.ViewModel(pokemons: [])

    /// Indicates whether the search interaction is currently active, from the environment.
    @Environment(\.isSearching) private var isSearching

    /// A namespace for matched geometry effects, enabling smooth transitions and animations
    /// between views that share the same matched geometry effect identifier.
    ///
    /// - Note: `@Namespace` provides a unique namespace value for the view hierarchy, which
    ///         is typically used with `.matchedGeometryEffect(id:in:)` to create coordinated
    ///         animations between views.
    @Namespace private var animation

    /// An optional closure that is triggered when the user scrolls to the bottom
    /// of the list. This can be used to perform actions such as loading more items.
    private var bottomIsReached: Interaction?

    // MARK: - Init

    /// Initializes a new instance of the Pokémon List view.
    ///
    /// - Parameters:
    ///   - pokemons: An array of `PokemonListItem` models representing the Pokémon to display in the list.
    ///   - isSearchingBinding: A binding to a Boolean value that indicates whether the search interaction
    ///                         is currently active. This enables two-way synchronization of the search state
    ///                         between this view and its parent view.
    ///   - bottomIsReached: An optional closure that is triggered when the user scrolls to the bottom
    ///                      of the list. This can be used to perform actions such as loading more items.
    init(pokemons: [Model.Entity.PokemonListItem], isSearchingBinding: Binding<Bool>, bottomIsReached: Interaction?) {
      self._isSearchingBinding = isSearchingBinding
      self.bottomIsReached = bottomIsReached
      self.pokemons = pokemons
    }

    // MARK: - View

    var body: some SwiftUI.View {
      ScrollView(.vertical) {
        LazyVGrid(
          columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
          ],
          spacing: .small
        ) {
          ForEach(viewModel.pokemons) { pokemon in
            UI.Funnel.Home.View.List.Cell(pokemon: pokemon, animation: animation) { pokemon in
              mainActorTask {
                try await viewModel.fetchPokemonDetail(for: pokemon, animation: animation)
              }
            }
            .onAppear {
              if pokemon == viewModel.pokemons.last {
                bottomIsReached?()
              }
            }
          }
        }
        .padding(.horizontal, .small)
      }
      .loader(isShowing: viewModel.localState.isLoading)
      .onChange(of: isSearching) { _, newValue in
        isSearchingBinding = newValue
      }
      .onChange(of: pokemons) { _, newValue in
        viewModel.setPokemons(pokemons: newValue)
      }
    }
  }
}
