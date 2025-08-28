//
//  Home+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Factory
import SwiftUI

/// Extension providing the ViewModel for the Details funnel in the UI.
extension UI.Funnel.Details {
  /// ViewModel responsible for managing the state and logic of the details view within the funnel.
  class ViewModel: StaterViewModel {

    // MARK: - Constants

    /// The title of the reset Pokedex button.
    let resetPokedexButtonTitle: String = "Reset Pokedex Data"

    // MARK: - Stored Properties

    /// Represents the currently selected Pokémon for the detail view.
    @Published var selectedPokemon: Model.Entity.Pokemon?

    /// Represents the currently selected Pokémon Pokedex information for the detail view.
    @Published var selectedPokemonPokedexInformation: Model.Foundation.PokemonInformation?

    /// Tracks the current loading state for the details view's local operations (such as fetching Pokédex information).
    @Published var localState: LocalState<Empty, Error> = .idle

    /// The use case for fetching additional Pokédex assistant information for a Pokémon, injected for modularity and testability.
    @Injected(\.getPokedexAssistantInformationUseCase) private var getPokedexAssistantInformationUseCase:
      GetPokedexAssistantInformationUseCase

    /// The use case for clearing the Pokédex assistant cache, injected for modularity and testability.
    @Injected(\.clearPokedexAssistantInformationCacheUseCase) private var clearPokedexAssistantInformationCacheUseCase:
      ClearPokedexAssistantInformationCacheUseCase

    /// The use case for prewarming the Pokédex assistant service, injected for modularity and testability.
    @Injected(\.prewarmPokedexAssistantUseCase) private var prewarmPokedexAssistantUseCase:
      PrewarmPokedexAssistantUseCase

    // MARK: - Computed Properties

    /// Returns the name of the selected Pokémon or an empty string if none is selected.
    var name: String {
      selectedPokemon?.name.capitalized ?? ""
    }

    /// Provides the URL string of the selected Pokémon's front image, or an empty string.
    var imageURL: String {
      selectedPokemon?.frontImage.stringURL ?? ""
    }

    /// Returns a human-readable description of the currently selected Pokémon's Pokédex information.
    var readablePokedexInformation: String {
      selectedPokemonPokedexInformation?.description ?? ""
    }

    /// The readable kind of Pokemon.
    var readableKind: String {
      selectedPokemonPokedexInformation?.types.map { $0 }.joined(separator: ", ") ?? ""
    }

    /// Returns the formatted height of the selected Pokémon as a string, or an empty string if no Pokémon is selected.
    var height: String {
      "Height: \(selectedPokemon?.height.formatted() ?? "")"
    }

    /// Returns the formatted weight of the selected Pokémon as a string, or an empty string if no Pokémon is selected.
    var weight: String {
      "Weight: \(selectedPokemon?.weight.formatted() ?? "")"
    }

    /// Returns the formatted base experience of the selected Pokémon as a string, or an empty string if no Pokémon is selected.
    var baseExperience: String {
      "Base XP: \(selectedPokemon?.baseExperience.formatted() ?? "")"
    }

    /// The color of type of Pokemon.
    var colorType: Color {
      guard let selectedPokemonPokedexInformation else {
        return .clear
      }
      return Color(hex: selectedPokemonPokedexInformation.color).opacity(0.8)

    }

    /// The colors of the background when `selectedPokemonPokedexInformation` has a value.
    var backgroundColors: [Color]? {
      guard let _ = selectedPokemonPokedexInformation else {
        return nil
      }

      return [colorType, colorType.opacity(0.4), colorType.opacity(0.2)]
    }

    /// When extra information group is visible or not.
    var isExtraInformationGroupVisible: Bool {
      selectedPokemonPokedexInformation != nil
    }

    // MARK: - Init

    override init() {
      super.init()

      prewarmPokedexAssistant()
    }

    // MARK: - Deinit

    deinit {
      resetPokedexData()
    }

    // MARK: - Update

    /// Updates the ViewModel with the latest application state.
    ///
    /// This method synchronizes the ViewModel's `selectedPokemon` property
    /// with the `selectedPokemon` from the application's `pokemonDetail` state.
    /// It first calls the superclass implementation to perform any required base updates,
    /// then updates the local state to reflect any changes.
    ///
    /// - Parameter state: The latest `AppState` containing updated application data.
    override func update(state: AppStateable) {
      super.update(state: state)

      selectedPokemon = state.pokemonDetail.selectedPokemon
      selectedPokemonPokedexInformation = state.pokemonDetail.pokedexInformation
    }

    // MARK: - Functions

    /// Asynchronously fetches detailed Pokédex information for the currently selected Pokémon.
    ///
    /// This method sets the local state to `.loading` before attempting to retrieve data. If no Pokémon is
    /// currently selected, it sets the state back to `.idle` and returns early. Otherwise, it performs an
    /// asynchronous operation to fetch the Pokédex information using the `GetPokedexAssistantInformation` use case.
    /// Upon successful completion, the local state is updated to `.success`.
    ///
    /// - Throws: Propagates any error thrown by the underlying use case execution.
    ///
    /// - Note: This method should be called when up-to-date Pokédex information is required for the selected Pokémon.
    func getPokedexInformation() async throws {
      localState = .loading
      guard let selectedPokemon else {
        localState = .idle
        return
      }
      do {
        try await getPokedexAssistantInformationUseCase.execute(for: selectedPokemon)
        localState = .success
      } catch {
        localState = .failure(error)
      }
    }

    /// The `Interaction` called when the confirmation is tapped on error view.
    func errorConfirmationTapped() {
      localState = .idle
    }

    /// Resets the Pokédex data cache for the assistant.
    ///
    /// This method invokes the `ClearPokedexAssistantInformationCache` use case to clear any cached
    /// Pokédex information associated with the current assistant, ensuring that future requests
    /// will fetch fresh data. This can be useful for maintaining up-to-date information or resolving data inconsistencies.
    ///
    /// - Note: This operation is typically called during deinitialization or when a complete data refresh is required.
    func resetPokedexData() {
      clearPokedexAssistantInformationCacheUseCase.execute()
    }

    /// Prewarms the Pokedex Assistant to optimize performance for future requests.
    ///
    /// This method triggers the `PrewarmPokedexAssistant` use case, which may perform tasks such as loading
    /// resources or initializing caches asynchronously. Prewarming can help reduce latency and improve the
    /// responsiveness of Pokédex-related features when the user requests information.
    ///
    /// - Note: This method is typically called proactively, before Pokédex details are needed, to ensure a smoother user experience.
    private func prewarmPokedexAssistant() {
      prewarmPokedexAssistantUseCase.execute()
    }
  }
}
