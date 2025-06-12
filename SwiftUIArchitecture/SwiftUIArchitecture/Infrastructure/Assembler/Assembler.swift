//
//  Assembler.swift
//

import SwiftUI

/// The responsible to assemble and return the `View`s.
struct Assembler {}

// MARK: - Helpers

extension Assembler {
  /// Solve the navigation basing on `CoordinatorLink`.
  /// - Parameter destination: The `CoordinatorLink`.
  /// - Returns: The related `SwiftUI.View`.
  @MainActor 
  @ViewBuilder
  func navigateTo(destination: CoordinatorLink) -> some View {
    switch destination {
    case .splash:
      UI.Funnel.Splash.View()
      
    case .home:
      UI.Funnel.Home.View()
    }
  }
}


