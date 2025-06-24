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
          Image(.pokeball)
            .resizable()
            .frame(width: .xLarge, height: .xLarge)
            .phaseAnimator(AnimationPhase.allCases) { view, phase in
              view
                .rotationEffect(
                  phase == .start ? .degrees(.zero) : phase == .middle ? .degrees(40) : .degrees(30)
                )
            } animation: { phase in
              switch phase {
              case .start: .bouncy(duration: 0.5, extraBounce: 0.35)
              case .middle: .spring(duration: 0.3, bounce: 0.25)
              case .end: .smooth(duration: 0.5, extraBounce: 0.85)
              }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
      }
    }
  }
}

extension LoaderModifier {
  enum AnimationPhase: CaseIterable {
    case start, middle, end
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

#Preview("Loader") {
  ZStack {}
    .loader(isShowing: .constant(true))
}
