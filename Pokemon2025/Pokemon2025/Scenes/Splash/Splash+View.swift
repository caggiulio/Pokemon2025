//
//  Splash+View.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Factory
import SwiftUI

extension UI.Funnel.Splash {
  struct View: SwiftUI.View {

    // MARK: - Stored Properties

    /// The `UI.Funnel.Splash.ViewModel` of the view.
    @StateObject var viewModel = UI.Funnel.Splash.ViewModel()

    // MARK: - View

    var body: some SwiftUI.View {
      MystiqueView(localState: viewModel.localState) { splashModel in
        ZStack {
          Image(splashModel.resource)
            .resizable()
            .frame(width: splashModel.imageSize.width, height: splashModel.imageSize.height)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(.red)
      }
      .onAppear {
        viewModel.didAppear()
      }
    }
  }
}
