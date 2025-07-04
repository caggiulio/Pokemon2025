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
          Task {
            try await viewModel.loadOthers()
          }
        }
        .searchable(text: $viewModel.searchString)
      }
      .safeAreaInset(edge: .bottom) {
        if viewModel.isSearching {
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
      .animation(.smooth, value: viewModel.isSearching)
      .animation(.smooth, value: viewModel.pokemons.count)
      .navigationTitle(viewModel.navigationTitle)
      .loader(isShowing: viewModel.localState.isLoading)
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
