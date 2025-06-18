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
  func details() {
    homePath.append(HomeDestinationLink.details)
  }
}
