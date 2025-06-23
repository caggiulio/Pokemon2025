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

    @State private var isExpanded: Bool = false

    /// The `UI.Funnel.Details.ViewModel` managing the state and data for this view, including image URL and displayed name.
    @StateObject private var viewModel = UI.Funnel.Details.ViewModel()

    // MARK: - Body

    var body: some SwiftUI.View {
      Color.red
        .ignoresSafeArea()
        .overlay {
          ScrollView {
            VStack(spacing: .small) {
              imageView(isBackground: false)

              Button() {
                isExpanded.toggle()
              } label: {
                Image(systemName: !isExpanded ? "arrow.up" : "arrow.down")
                  .padding(.small)
              }
              .glassEffect(.regular.interactive(), in: .circle)
              .padding(.bottom, .small)
              .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
              .foregroundStyle(.black)

              if isExpanded {
                Text(viewModel.name)
                  .font(.title)
                  .fontWeight(.bold)
                  .foregroundStyle(.red)
                  .padding()
                  .transition(.asymmetric(insertion: .scale, removal: .identity))
              }
            }
            .navigationTransition(.zoom(sourceID: transitionIdentifier, in: animation))
            .frame(maxWidth: .infinity)
            .glassEffect(in: RoundedRectangle(cornerRadius: .small))
            .padding(.top, !isExpanded ? .large : .zero)
            .padding(.horizontal, !isExpanded ? .large : .medium)
            .animation(.smooth, value: isExpanded)
          }
        }
    }

    // MARK: - Subviews

    /// Loads and displays an image asynchronously from a URL, or shows a fallback Pokéball image while loading.
    /// - Parameters:
    ///   - url: The URL string for the image.
    ///   - width: The width of the image view.
    ///   - height: The height of the image view.
    ///   - aspect: The content mode for aspect ratio.
    ///   - blur: The blur radius to apply to the image.
    /// - Returns: A SwiftUI view displaying the image or a placeholder.
    private func asyncPokeballImage(
      url: String,
      width: CGFloat,
      height: CGFloat,
      aspect: ContentMode,
      blur: CGFloat
    ) -> some SwiftUI.View {
      AsyncImage(url: URL(string: url)) { image in
        image
          .resizable()
          .aspectRatio(contentMode: aspect)
          .frame(width: width, height: height)
          .clipped()
      } placeholder: {
        Image(.pokeball)
          .resizable()
          .aspectRatio(contentMode: aspect)
          .frame(width: width, height: height)
          .clipped()
      }
      .blur(radius: blur)
    }

    /// Builds the Pokémon image view, displaying either a blurred background or a sharp foreground image.
    /// - Parameter isBackground: Whether to render as a background (blurred) or foreground (sharp) image.
    /// - Returns: A SwiftUI view showing the Pokémon image with the appropriate style.
    @ViewBuilder
    func imageView(isBackground: Bool) -> some SwiftUI.View {
      let blur = isBackground ? 15.0 : .zero
      if isBackground {
        GeometryReader { geometry in
          asyncPokeballImage(
            url: viewModel.imageURL,
            width: geometry.size.width,
            height: geometry.size.height,
            aspect: .fill,
            blur: blur
          )
        }
      } else {
        asyncPokeballImage(
          url: viewModel.imageURL,
          width: .xxLarge,
          height: .xxLarge,
          aspect: .fit,
          blur: blur
        )
      }
    }
  }
}
