//
//  SwiftUIArchitectureApp.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Factory
import SwiftUI

@main
struct SwiftUIArchitectureApp: App {

  // MARK: - Stored Properties

  /// The app coordinator.
  @InjectedObject(\.coordinator) var coordinator: Coordinator

  /// The responsible of the assemble of the `View` used to assemble a view for navigation.
  @Injected(\.mainAssembler) var mainAssembler: Assembler.Main

  /// The home assembler.
  @Injected(\.homeAssembler) var homeAssembler: Assembler.Home

  var body: some Scene {
    WindowGroup {
      mainAssembler.view(for: .splash)
        .fullScreenCover(isPresented: $coordinator.isHomePresented) {
          NavigationStack(path: $coordinator.homePath) {
            mainAssembler.view(for: .home)
              .animatedBackground()
              .navigationDestination(for: HomeDestinationLink.self) { destination in
                homeAssembler.view(for: destination)
              }
          }
        }
    }
  }
}
