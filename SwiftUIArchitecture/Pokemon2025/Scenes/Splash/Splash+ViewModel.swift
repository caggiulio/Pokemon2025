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
    
    // MARK: - DidAppear
    
    /// Called when the view appears.
    @MainActor
    func didAppear() {
      localState = .success(
        SplashModel(
          imageName: "logo",
          imageSize: CGSize(width: 300, height: 300)
        )
      )
      
      Task {
        try await UseCase.GetPokemonByIdentifier().execute()
        self.coordinator.home()
      }
    }
  }
}
