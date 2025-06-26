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

    /// The app coordinator.
    @InjectedObject(\.coordinator) var coordinator: Coordinator

    /// The app assembler.
    @Injected(\.mainAssembler) var mainAssembler: Assembler.Main

    /// The home assembler.
    @Injected(\.homeAssembler) var homeAssembler: Assembler.Home

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
      .fullScreenCover(isPresented: $coordinator.isHomePresented) {
        NavigationStack(path: $coordinator.homePath) {
          mainAssembler.view(for: .home)
            .navigationDestination(for: HomeDestinationLink.self) { destination in
              homeAssembler.view(for: destination)
            }
        }
        .animatedBackground()
      }
    }
  }
}
