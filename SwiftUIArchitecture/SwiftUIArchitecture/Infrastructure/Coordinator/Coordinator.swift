//
//  Coordinator.swift
//  HomeBridgeApp
//
//  Created by Nunzio Giulio Caggegi on 02/04/23.
//

import SwiftUI

/// The coordinator class of the app. It's used to push a view in the current navigation stack.
class Coordinator: ObservableObject {
  /// The `NavigationPath` object.
  @Published var path = NavigationPath()
    
  /// Pop to root view.
  func popToRoot() {
    path.removeLast(path.count)
  }
  
  /// Pop to back view.
  func popView() {
    path.removeLast()
  }
  
  /// Push the `UI.Funnel.Home.View`
  func home() {
    path.append(CoordinatorLink.home)
  }
}
