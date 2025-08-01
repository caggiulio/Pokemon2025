//
//  Details+View.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 18/06/25.
//

import CachedAsyncImage
import Factory
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

    /// A Boolean state indicating whether the detailed Pokédex information is expanded and visible.
    /// When set to `true`, the view displays additional descriptive content for the selected Pokémon.
    /// This property is toggled automatically when new Pokédex data is loaded.
    @State private var isExpanded: Bool = false

    /// The `UI.Funnel.Details.ViewModel` managing the state and data for this view, including image URL and displayed name.
    @StateObject private var viewModel = UI.Funnel.Details.ViewModel()

    /// A reference to the app's navigation coordinator, injected using Factory's property wrapper.
    /// The coordinator is responsible for managing navigation and flow control within the Stats UI,
    /// enabling the ViewModel to trigger navigation actions without tightly coupling to the navigation logic.
    @InjectedObject(\.coordinator) private var coordinator: Coordinator

    // MARK: - Body

    var body: some SwiftUI.View {
      GeometryReader { geometry in
        let imageSize = min(geometry.size.width, geometry.size.height) * 0.6
        ScrollView {
          if !isExpanded {
            normalView(imageSize: imageSize)
          } else {
            expandedView(imageSize: imageSize)
          }

          VStack(spacing: .zero) {
            extraInformation
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .ignoresSafeArea()
        }
        .defaultScrollAnchor(.center, for: .alignment)
        .navigationTransition(.zoom(sourceID: transitionIdentifier, in: animation))
        .animatedBackground(colors: viewModel.backgroundColors)
        .loader(isShowing: viewModel.localState.isLoading)
        .onChange(of: viewModel.readablePokedexInformation) { _, newValue in
          withAnimation(.spring(.bouncy)) {
            isExpanded = !newValue.isEmpty
          }
        }
        .animation(.spring(.bouncy), value: viewModel.isExtraInformationGroupVisible)
        .error(
          isShowing: viewModel.localState.isError,
          error: viewModel.localState.error,
          confirmAction: viewModel.errorConfirmationTapped
        )
        .toolbar {
          toolbar
        }
        .sheet(isPresented: $coordinator.isStatsPresented) {
          UI.Funnel.Details.Stats.View()
            .presentationDetents([.fraction(0.65)])
        }
      }
    }

    // MARK: - Subviews

    /// Returns a SwiftUI view representing the "normal" (collapsed) state of the Details view.
    ///
    /// - Parameter imageSize: The target width and height for the Pokémon image displayed in the view.
    /// - Returns: A SwiftUI view displaying the Pokémon's name and image, styled with a translucent, rounded rectangle background.
    private func normalView(imageSize: CGFloat) -> some SwiftUI.View {
      VStack(spacing: .zero) {
        nameView
          .matchedGeometryEffect(id: "name", in: animation, isSource: true)
          .padding(.top, .xSmall)

        imageView(imageSize: imageSize)

        pokedexInformation
      }
      .background {
        Color.white.opacity(0.5)
          .clipShape(RoundedRectangle(cornerRadius: .medium))
      }
    }

    /// Returns a SwiftUI view representing the "expanded" (collapsed) state of the Details view.
    ///
    /// - Parameter imageSize: The target width and height for the Pokémon image displayed in the view.
    /// - Returns: A SwiftUI view displaying the Pokémon's name and image, styled with a translucent, rounded rectangle background.
    private func expandedView(imageSize: CGFloat) -> some SwiftUI.View {
      GlassEffectContainer(spacing: .medium) {
        VStack(spacing: .small) {
          VStack(spacing: .zero) {
            imageView(imageSize: imageSize)

            pokedexInformation
          }
          .background {
            Color.white.opacity(0.5)
              .clipShape(RoundedRectangle(cornerRadius: .medium))
          }

          nameView
            .matchedGeometryEffect(id: "name", in: animation)

          Text(viewModel.readablePokedexInformation)
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .padding()
            .glassEffect(in: RoundedRectangle(cornerRadius: .medium))
            .offset(y: isExpanded ? -.medium : (-.medium + -.small))
            .frame(height: isExpanded ? nil : .zero)
            .glassEffectTransition(.matchedGeometry)
        }
        .padding(.horizontal, .small)
      }
    }

    /// A computed property that returns a SwiftUI view displaying the Pokémon's name with styled appearance.
    /// This component is used in both the normal and expanded details layouts,
    /// often in conjunction with matched geometry effects for animated transitions.
    private var nameView: some SwiftUI.View {
      Text(viewModel.name)
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .padding()
        .glassEffect()
    }

    /// Returns a SwiftUI view that displays the Pokémon's image using a cached asynchronous image loader.
    /// - Parameter imageSize: The size (width and height) for the image view.
    /// - Returns: A SwiftUI view that displays the Pokémon's image if available, or a Pokéball placeholder otherwise.
    ///
    /// The image is loaded asynchronously from `viewModel.imageURL` and is displayed with a consistent aspect ratio and rounded corners.
    /// If the image URL is unavailable or loading fails, a Pokéball placeholder image is shown instead.
    /// The image view is visually decorated with a translucent white background and rounded rectangle clipping,
    /// and includes a navigation transition effect for animated transitions between views.
    ///
    private func imageView(imageSize: CGFloat) -> some SwiftUI.View {
      CachedAsyncImage(url: URL(string: viewModel.imageURL)) { image in
        image
          .resizable()
          .frame(width: imageSize, height: imageSize)
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        Image(.pokeball)
          .resizable()
          .frame(width: imageSize, height: imageSize)
          .aspectRatio(contentMode: .fit)
      }
    }

    /// A computed property that returns a SwiftUI view displaying Pokédex-specific attributes for the selected Pokémon.
    ///
    /// This view presents the Pokémon's height, weight, and base experience in a vertically-stacked arrangement,
    /// separated by dividers for clarity. All text is styled with a caption font and black foreground color.
    /// The view uses consistent spacing and padding for a compact, readable display of core Pokédex data.
    ///
    /// - Returns: A view showing the height, weight, and base experience with visual separation.
    private var pokedexInformation: some SwiftUI.View {
      VStack(spacing: .xSmall) {
        Group {
          Text(viewModel.height)

          Divider()
            .foregroundStyle(.black)
            .frame(maxWidth: .large)

          Text(viewModel.weight)

          Divider()
            .foregroundStyle(.black)
            .frame(maxWidth: .large)

          Text(viewModel.baseExperience)
        }
        .padding(.bottom, .xSmall)
        .font(.caption)
        .foregroundStyle(.black)
      }
    }

    /// A computed property that returns a SwiftUI view presenting additional details and actions for the selected Pokémon.
    ///
    /// This view displays context-sensitive, supplementary information and action buttons:
    /// - If `viewModel.isExtraInformationGroupVisible` is `true`, it shows:
    ///   - The Pokémon's type or kind information (`viewModel.readableKind`), styled with a glass effect and animated opacity transition.
    ///   - A button to reset Pokédex data (`viewModel.resetPokedexButtonTitle`), which triggers `viewModel.resetPokedexData()`, styled with a glass button style.
    ///   - These elements are grouped and padded at the bottom for visual clarity.
    /// - Below, regardless of state, a "Stats" button (`viewModel.statsButtonTitle`) is presented, which invokes the `coordinator.stats()` action when tapped, also styled with a glass effect.
    ///
    /// The view uses smooth transitions and glass-style presentation for a polished, interactive experience.
    @ViewBuilder
    private var extraInformation: some SwiftUI.View {
      if viewModel.isExtraInformationGroupVisible {
        Group {
          Text(viewModel.readableKind)
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .padding()
            .transition(.opacity)
            .glassEffect(.regular.tint(viewModel.colorType))

          Button(viewModel.resetPokedexButtonTitle) {
            viewModel.resetPokedexData()
          }
          .buttonStyle(.glass)
          .transition(.opacity)
        }
        .padding(.bottom, .xSmall)
      }
    }

    /// A computed toolbar property that provides context-sensitive navigation and action buttons for the Pokémon details view.
    ///
    /// The toolbar contains two items:
    /// - A button to refresh or fetch Pokédex information:
    ///   - Tapping this button launches an asynchronous task to call `viewModel.getPokedexInformation()`.
    ///   - The button icon shows a waveform symbol when not loading, and an ellipsis while loading, with a symbol effect transition for visual feedback.
    /// - A button to present or dismiss the Pokémon stats sheet:
    ///   - Tapping this button triggers the `coordinator.stats()` action, toggling the stats sheet presentation.
    ///   - The button icon switches between a heart text square (when the stats sheet is not presented) and an "x" mark (when it is), also using a symbol effect transition.
    ///
    /// This toolbar integrates seamlessly with the view model and navigation coordinator, providing immediate, animated controls for primary user actions in the details view.
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
      ToolbarItem {
        MainActorButton {
          try await viewModel.getPokedexInformation()
        } label: {
          Image(systemName: !viewModel.localState.isLoading.wrappedValue ? "waveform.circle" : "ellipsis")
        }
        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
      }

      ToolbarItem {
        Button {
          coordinator.stats()
        } label: {
          Image(systemName: !coordinator.isStatsPresented ? "heart.text.square.fill" : "xmark.circle")
        }
        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
      }
    }
  }
}

#Preview("Details") {
  @Previewable @Namespace var namespace

  NavigationStack {
    UI.Funnel.Details.View(transitionIdentifier: "", animation: namespace)
  }
}
