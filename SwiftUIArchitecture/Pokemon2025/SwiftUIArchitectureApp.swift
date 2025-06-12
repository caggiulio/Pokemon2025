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
  @Injected(\.assembler) var assembler: Assembler
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $coordinator.path) {
        assembler.navigateTo(destination: .splash)
          .navigationDestination(for: CoordinatorLink.self) { assembler.navigateTo(destination: $0) }
      }
    }
  }
}
