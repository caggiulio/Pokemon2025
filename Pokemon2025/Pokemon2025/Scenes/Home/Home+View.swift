//
//  Home+View.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import CachedAsyncImage
import SwiftUI

extension UI.Funnel.Home {
  /// The main view displaying a grid of Pokémon with asynchronous image loading,
  /// handling loading states and navigation bar visibility.
  struct View: SwiftUI.View {

    // MARK: - Stored Properties

    /// The `UI.Funnel.Home.ViewModel` managing the state and data for this view.
    @StateObject private var viewModel = UI.Funnel.Home.ViewModel()

    // MARK: - View

    var body: some SwiftUI.View {
      ZStack {
        UI.Funnel.Home.View.List(pokemons: viewModel.pokemons, isSearchingBinding: $viewModel.isSearching) {
          mainActorTask {
            try await viewModel.loadOthers()
          }
        }
        .searchable(text: $viewModel.searchString)
      }
      .safeAreaInset(edge: .bottom) {
        accessoryView
      }
      .animation(.smooth, value: viewModel.isSearching)
      .animation(.smooth, value: viewModel.pokemons.count)
      .navigationTitle(viewModel.navigationTitle)
      .loader(isShowing: viewModel.localState.isLoading)
    }

    // MARK: - Subviews

    /// A computed property that returns an optional accessory view for the Home screen.
    ///
    /// This view is conditionally displayed at the bottom of the screen when
    /// `viewModel.isAccessoryViewVisible` is `true`. It presents a styled and animated
    /// count summary using `viewModel.readableCountNumber`, applies headline font,
    /// custom transitions, a glass effect, and insets. The accessory view occupies
    /// the width of the parent and is inset horizontally and from the bottom.
    @ViewBuilder
    private var accessoryView: some SwiftUI.View {
      if viewModel.isAccessoryViewVisible {
        Text(viewModel.readableCountNumber)
          .font(.headline)
          .transition(.blurReplace)
          .contentTransition(.numericText())
          .frame(maxWidth: .infinity, maxHeight: .large - .xSmall)
          .glassEffect()
          .padding(.horizontal)
          .padding(.bottom, .xSmall)
      }
    }
  }
}

#Preview("Home") {
  NavigationStack {
    UI.Funnel.Home.View()
      .animatedBackground()
      .onAppear {
        Task {
          try await UseCase.FetchPokemonList().execute()
        }
      }
  }
}
