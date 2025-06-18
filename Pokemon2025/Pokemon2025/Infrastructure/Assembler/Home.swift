//
//  Home.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 18/06/25.
//

import SwiftUI

extension Assembler {
  struct Home: Assemblerifiable {
    func view(for destination: HomeDestinationLink) -> some View {
      switch destination {
      case .details:
        EmptyView()
      }
    }
  }
}
