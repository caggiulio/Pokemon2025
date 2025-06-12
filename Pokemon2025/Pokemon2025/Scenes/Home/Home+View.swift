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
      VStack {}
        .loader(isShowing: viewModel.localState.isLoading)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
  }
}
