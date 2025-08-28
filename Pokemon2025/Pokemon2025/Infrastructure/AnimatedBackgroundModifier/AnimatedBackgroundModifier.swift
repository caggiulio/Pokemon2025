//
//  AnimatedBackgroundModifier.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 24/06/25.
//

import SwiftUI

/// A view modifier that applies a continuously animated linear gradient background.
/// The gradient animates between two directions using a toggleable state.
///
/// Usage:
/// ```swift
/// .modifier(AnimatedBackgroundModifier(colors: [.red, .orange]))
/// ```
///
/// - Parameters:
///   - colors: The colors used in the animated gradient background.
///             The gradient will interpolate between the first and last color.
struct AnimatedBackgroundModifier: ViewModifier {

  // MARK: - Stored Properties

  /// The colors used in the animated gradient background.
  /// The gradient will interpolate between the first and last color.
  var colors: [Color]

  /// Internal state that controls the toggle effect for the animated gradient.
  /// It alternates between `true` and `false` to produce the animation loop.
  @State private var animateGradient = false

  // MARK: - Body

  func body(content: Content) -> some View {
    content
      .background(
        LinearGradient(
          gradient: Gradient(colors: colors),
          startPoint: UnitPoint(x: animateGradient ? 0.5 : -1, y: animateGradient ? 0.5 : -0.5),
          endPoint: UnitPoint(x: animateGradient ? 2 : 0.5, y: animateGradient ? 1.5 : 0.5)
        )
        .onAppear {
          withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            animateGradient.toggle()
          }
        }
        .ignoresSafeArea()
      )
  }
}

extension View {
  /// Applies an animated linear gradient background that loops continuously.
  func animatedBackground(colors: [Color]? = nil) -> some View {
    self.modifier(AnimatedBackgroundModifier(colors: colors ?? [.red, .orange]))
  }
}
