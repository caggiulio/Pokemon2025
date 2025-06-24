//
//  ErrorModifier.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 24/06/25.
//

import Foundation
import SwiftUI

/// A modifier to display the `Loader` view as an overlay.
struct ErrorModifier: ViewModifier {

  // MARK: - Stored Properties

  /// The `Binding<Bool>` used to show the loader.
  @Binding var isShowing: Bool

  /// The `Error`.
  var error: Error?

  // MARK: - Body

  /// Adds the error view as an overlay.
  /// - Parameter content: The content to which the error view will be added as an overlay.
  /// - Returns: The content with the error view added as an overlay.
  func body(content: Content) -> some View {
    ZStack {
      content
        .alert("Error", isPresented: $isShowing) {
          Button(role: .confirm, action: { isShowing = false })
        } message: {
          Text(error?.localizedDescription ?? "")
        }

    }
  }
}

public extension View {
  /// Displays the `Error` view as an overlay.
  /// - Parameters:
  ///   - isShowing: The `Binding<Bool>` used to show the loader.
  ///   - error: The `Error`.
  /// - Returns: A view with the alert error view added as an overlay.
  func error(isShowing: Binding<Bool>, error: Error?) -> some View {
    self.modifier(ErrorModifier(isShowing: isShowing, error: error))
  }
}
