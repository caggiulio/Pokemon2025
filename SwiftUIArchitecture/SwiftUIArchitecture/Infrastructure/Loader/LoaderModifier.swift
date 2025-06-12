//
//  LoaderModifier.swift
//  SwiftUIArchitecture
//
//  Created by Giulio Caggegi on 14/03/25.
//


import Foundation
import SwiftUI

/// A modifier to display the `Loader` view as an overlay.
struct LoaderModifier: ViewModifier {
  
  // MARK: - Stored Properties
  
  /// The `Binding<Bool>` used to show the loader.
  @Binding var isShowing: Bool
  
  // MARK: - Body
  
  /// Adds the `Loader` view as an overlay.
  /// - Parameter content: The content to which the `Loader` view will be added as an overlay.
  /// - Returns: The content with the `Toast` view added as an overlay.
  func body(content: Content) -> some View {
    ZStack {
      content

      if isShowing {
        VStack {
          ProgressView()
          Text("Loading")
            .padding(.top, 64)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
      }
    }
  }
}

public extension View {
  /// Displays the `Loader` view as an overlay.
  /// - Parameter isShowing: The `Binding<Bool>` used to show the loader.
  /// - Returns: A view with the `Loader` view added as an overlay.
  func loader(isShowing: Binding<Bool>) -> some View {
    self.modifier(LoaderModifier(isShowing: isShowing))
  }
}
