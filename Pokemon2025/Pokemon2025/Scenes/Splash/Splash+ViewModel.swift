//
//  Splash+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Factory
import Foundation

extension UI.Funnel.Splash {
  class ViewModel: MystiqueViewModel<SplashModel> {

    /// The coordinator of the app.
    @Injected(\.coordinator) var coordinator: Coordinator

    /// The use case for fetching the Pokémon list, injected for separation of concerns and testability.
    /// This allows the ViewModel to trigger list fetching without direct coupling to implementation details.
    @Injected(\.fetchPokemonListUseCase) private var fetchPokemonListUseCase: FetchPokemonListUseCase

    // MARK: - DidAppear

    /// Called when the view appears.
    @MainActor
    func didAppear() {
      localState = .success(
        SplashModel(
          resource: .pokeball,
          imageSize: CGSize(width: .xxLarge, height: .xxLarge)
        )
      )

      Task {
        try await fetchPokemonListUseCase.execute()
        coordinator.home()
      }
    }
  }
}
