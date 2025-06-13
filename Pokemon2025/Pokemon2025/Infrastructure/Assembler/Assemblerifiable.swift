//
//  Assemblerifiable.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 12/06/25.
//

import SwiftUI

@MainActor
protocol Assemblerifiable {
  associatedtype DestinationView: View
  associatedtype DestinationLink: Linkable

  @ViewBuilder
  func navigateTo(destination: DestinationLink) -> DestinationView
}
