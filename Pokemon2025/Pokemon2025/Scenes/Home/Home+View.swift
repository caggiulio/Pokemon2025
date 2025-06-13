//
//  Home+View.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import SwiftUI

extension UI.Funnel.Home {
  struct View: SwiftUI.View {

    // MARK: - Stored Properties

    /// The `UI.Funnel.Home.ViewModel` of the view.
    @StateObject var viewModel = UI.Funnel.Home.ViewModel()

    // MARK: - View

    var body: some SwiftUI.View {
      ScrollView(.vertical) {
        LazyVGrid(
          columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
          ]
        ) {
          ForEach(viewModel.pokemons) { pokemon in
            pokemonCell(for: pokemon)
          }
        }
      }
      .padding(.horizontal, .xSmall)
      .loader(isShowing: viewModel.localState.isLoading)
      .navigationBarHidden(true)
    }

    private func pokemonCell(for pokemon: PokemonListItem) -> some SwiftUI.View {
      ZStack {
        VStack(spacing: .zero) {
          AsyncImage(url: URL(string: pokemon.imageURL)) { image in
            image
              .resizable()
              .frame(width: .xLarge, height: .xLarge)
          } placeholder: {
            Image(.pokeball)
              .resizable()
              .frame(width: .xLarge, height: .xLarge)
          }

          Text(pokemon.name)
            .padding(.bottom, .small)
        }
      }
      .frame(width: .xLarge + .large, height: .xLarge + .large, alignment: .center)
      .background {
        Color.red
          .clipShape(RoundedRectangle(cornerRadius: .small))
      }
    }
  }
}
