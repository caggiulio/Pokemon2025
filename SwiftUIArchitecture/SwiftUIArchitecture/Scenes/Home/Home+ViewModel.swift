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
    @Published private(set) var localState: LocalState<Empty, Never> = .idle
    
    /// The selected Pokemon.
    @Published private var pokemon: Pokemon?
    
    // MARK: - Computed Properties
    
    /// The name of the Pokemon.
    var name: String {
      pokemon?.name.capitalized ?? ""
    }
    
    /// The `URL` of the Pokemon image.
    var imageURL: URL? {
      URL(string: stringImage ?? "") ?? nil
    }
    
    /// The `String` `URL` image of the Pokemon.
    private var stringImage: String? {
      pokemon?.frontImage.stringURL ?? nil
    }
    
    // MARK: - Update
    
    override func update(state: AppState) {
      pokemon = appState.state.pokemonDetail.selectedPokemon
      localState = .success
    }
    
    // MARK: - Functions
    
    /// The user taps on random button.
    @MainActor
    func didTapRandomButton() {
      localState = .loading
      Task {
        try await UseCase.GetPokemonByIdentifier().execute()
      }
    }
  }
}
