//
//  Home+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Foundation

extension UI.Funnel.Details {
  class ViewModel: StaterViewModel {

    // MARK: - Stored Properties

    @Published var selectedPokemon: Pokemon?
    
    // MARK: - Computed Properties
    
    var name: String {
      selectedPokemon?.name ?? ""
    }
    
    var imageURL: URL? {
      URL(string: selectedPokemon?.frontImage.stringURL ?? "")
    }

    // MARK: - Update

    override func update(state: AppState) {
      super.update(state: state)

      selectedPokemon = state.pokemonDetail.selectedPokemon
    }

    // MARK: - Functions

  }
}
