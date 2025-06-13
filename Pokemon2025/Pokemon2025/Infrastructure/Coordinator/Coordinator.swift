//
//  Coordinator.swift
//  HomeBridgeApp
//
//  Created by Nunzio Giulio Caggegi on 02/04/23.
//

import SwiftUI

class Coordinator: ObservableObject {
  /// The `NavigationPath` object.
  @Published var mainPath = NavigationPath()

  /// Pop to root view.
  func popToRoot() {
    mainPath.removeLast(mainPath.count)
  }

  /// Pop to back view.
  func popView() {
    mainPath.removeLast()
  }

  /// Push the `UI.Funnel.Home.View`
  func home() {
    mainPath.append(MainDestinationLink.home)
  }
}
