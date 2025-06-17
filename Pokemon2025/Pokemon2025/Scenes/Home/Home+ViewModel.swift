//
//  Home+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Foundation

extension UI.Funnel.Home {
  class ViewModel: StaterViewModel {

    // MARK: - Stored Properties

    /// The local state of the view model.
    @Published private(set) var localState: LocalState<Empty, Error> = .idle

    @Published private(set) var pokemons: [PokemonListItem] = []

    // MARK: - Update

    override func update(state: AppState) {
      super.update(state: state)

      pokemons = state.pokemonList.pokemonList?.pokemonItems ?? []
    }

    @MainActor
    func loadOthers() async throws {
      localState = .loading
      do {
        try await UseCase.FetchPokemonList().execute()
        localState = .success(Empty())
      } catch {
        localState = .failure(error)
      }
    }
  }
}
