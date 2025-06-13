//
//  Main.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 12/06/25.
//

import SwiftUI

extension Assembler {
  struct Main: Assemblerifiable {
    /// Solve the navigation basing on `CoordinatorLink`.
    /// - Parameter destination: The `CoordinatorLink`.
    /// - Returns: The related `SwiftUI.View`.
    func navigateTo(destination: MainDestinationLink) -> some View {
      switch destination {
      case .splash:
        UI.Funnel.Splash.View()

      case .home:
        UI.Funnel.Home.View()
      }
    }
  }
}
