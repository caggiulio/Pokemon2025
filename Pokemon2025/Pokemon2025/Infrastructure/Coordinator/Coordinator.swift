//
//  Coordinator.swift
//  HomeBridgeApp
//
//  Created by Nunzio Giulio Caggegi on 02/04/23.
//

import SwiftUI

class Coordinator: ObservableObject {
  /// The `NavigationPath` object from the home root.
  @Published var homePath = NavigationPath()

  /// When the home is presented or not.
  @Published var isHomePresented: Bool = false

  /// When the stats is presented or not.
  @Published var isStatsPresented: Bool = false

  /// Pop to root view.
  func popToRoot() {
    homePath.removeLast(homePath.count)
  }

  /// Pop to back view.
  func popView() {
    homePath.removeLast()
  }

  /// Presents the `UI.Funnel.Home.View`.
  func home() {
    isHomePresented.toggle()
  }

  /// Push the details view.
  func details(transitionIdentifier: String, animation: Namespace.ID) {
    homePath.append(HomeDestinationLink.details(transitionIdentifier: transitionIdentifier, animation: animation))
  }

  /// Presents the `UI.Funnel.Details.Stats.View`.
  func stats() {
    isStatsPresented.toggle()
  }
}
