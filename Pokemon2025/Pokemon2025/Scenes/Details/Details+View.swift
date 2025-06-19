//
//  Details+View.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 18/06/25.
//

import SwiftUI

/// Extension to provide the Details funnel views.
extension UI.Funnel.Details {
  /// A SwiftUI View that displays detailed information for a selected item (e.g., a Pokémon), including its image and name.
  struct View: SwiftUI.View {

    // MARK: - Stored Properties

    /// The identifier used for navigation transitions, typically unique to each item.
    var transitionIdentifier: String

    /// The namespace for animation transitions.
    var animation: Namespace.ID

    /// The `UI.Funnel.Details.ViewModel` managing the state and data for this view, including image URL and displayed name.
    @StateObject private var viewModel = UI.Funnel.Details.ViewModel()

    // MARK: - Body

    var body: some SwiftUI.View {
      ZStack {
        imageView(isBackground: true)

        ScrollView {
          VStack(spacing: .small) {
            imageView(isBackground: false)
              .padding(.large)

            Text(viewModel.name)
              .font(.title)
              .fontWeight(.bold)
              .foregroundStyle(.red)
              .padding()
          }
          .padding(.horizontal, -.small)
          .glassEffect(in: RoundedRectangle(cornerRadius: .small))
        }
      }
      .navigationTransition(.zoom(sourceID: transitionIdentifier, in: animation))
    }

    // MARK: - Subviews

    /// Returns an image view for the detailed item.
    /// - Parameter isBackground: If true, the image is displayed in the background (larger, blurred). If false, the image is foregrounded (normal size, sharp).
    /// - Returns: A SwiftUI view displaying the appropriate image (remote image or placeholder).
    func imageView(isBackground: Bool) -> some SwiftUI.View {
      let size = isBackground ? (.xxLarge * 2) : .xxLarge
      let blur = isBackground ? 15.0 : .zero

      return AsyncImage(url: URL(string: viewModel.imageURL)) { image in
        image
          .resizable()
          .frame(width: size, height: size)
      } placeholder: {
        Image(.pokeball)
          .resizable()
          .frame(width: size, height: size)
      }
      .blur(radius: blur)
    }
  }
}
