//
//  Main.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 12/06/25.
//

import SwiftUI

extension Assembler {
  struct Main: Assemblerifiable {
    func view(for destination: MainDestinationLink) -> some View {
      switch destination {
      case .splash:
        UI.Funnel.Splash.View()

      case .home:
        UI.Funnel.Home.View()
      }
    }
  }
}
