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

    /// Holds the current list of Pokémon items to be displayed in the UI.
    @ObservedObject private var viewModel: UI.Funnel.Home.View.List.ViewModel

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
      let viewModel = UI.Funnel.Home.View.List.ViewModel(pokemons: pokemons)
      self.viewModel = viewModel
      self._isSearchingBinding = isSearchingBinding
      self.bottomIsReached = bottomIsReached
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
              Task {
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
    }
  }
}
