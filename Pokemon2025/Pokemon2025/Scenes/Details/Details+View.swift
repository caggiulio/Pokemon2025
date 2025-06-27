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
        VStack(alignment: .center, spacing: .small) {
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

          GlassEffectContainer(spacing: .medium) {
            VStack(spacing: .small) {
              Text(viewModel.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .padding()
                .glassEffect()

              Text(viewModel.readablePokedexInformation)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .padding()
                .glassEffect(in: RoundedRectangle(cornerRadius: .medium))
                .offset(y: isExpanded ? -.medium : (-.medium + -.small))
                .frame(height: isExpanded ? nil : .zero)
                .glassEffectTransition(.matchedGeometry)
            }
            .padding(.horizontal, .small)
          }

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

          Button(viewModel.statsButtonTitle) {
            coordinator.stats()
          }
          .buttonStyle(.glass)
        }
        .navigationTransition(.zoom(sourceID: transitionIdentifier, in: animation))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
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
            .presentationDetents([.medium])
        }
      }
    }

    // MARK: - Subviews

    /// A toolbar content builder that provides a refresh button for fetching Pokédex information.
    ///
    /// This toolbar contains a single button, represented by a waveform circle system image.
    /// When tapped, it asynchronously invokes the `getPokedexInformation()` method on the view model to update or fetch
    /// the latest Pokédex information for the displayed Pokémon. The button is placed as a toolbar item within the view.
    ///
    /// - Note: The button's action is performed within a Swift concurrency `Task`, allowing it to call the async method.
    /// - Returns: The toolbar content for the view, including the Pokédex refresh button.
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
      ToolbarItem {
        Button {
          Task {
            try await viewModel.getPokedexInformation()
          }
        } label: {
          Image(systemName: !viewModel.localState.isLoading.wrappedValue ? "waveform.circle" : "ellipsis")
        }
        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp)))
      }
    }
  }
}

#Preview("Details") {
  @Previewable @Namespace var namespace

  UI.Funnel.Details.View(transitionIdentifier: "", animation: namespace)
}
