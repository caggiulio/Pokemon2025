//
//  Home+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Combine
import Factory
import Foundation
import SwiftUI

/// Extension containing the ViewModel for the Home UI funnel,
/// managing state and data interactions for the Home view.
extension UI.Funnel.Home {
  /// ViewModel responsible for handling the UI state and business logic
  /// for the Home screen in the app's funnel architecture.
  class ViewModel: StaterViewModel {

    // MARK: - Stored Properties

    /// A string representing the user's current input in the search field.
    /// Used to filter and search for Pokémon within the Home view.
    @Published var searchString: String = ""

    /// A Boolean value indicating whether the user is actively performing a search.
    /// Used to control the display of search-related UI elements and logic in the Home view.
    @Published var isSearching: Bool = false

    /// The navigation bar title displayed at the top of the Home screen.
    /// Used to indicate the primary content or context of the current view.
    private(set) var navigationTitle = "Pokémon"

    /// Holds the current list of Pokémon items to be displayed in the UI.
    @Published private(set) var pokemons: [Model.Entity.PokemonListItem] = []

    /// Represents the current local state of the ViewModel,
    /// including loading, success, and failure states used to update the UI.
    @Published private(set) var localState: LocalState<Empty, Error> = .idle

    /// A reference to the app's navigation coordinator, injected using Factory's property wrapper.
    /// The coordinator is responsible for managing navigation and flow control within the Home UI,
    /// enabling the ViewModel to trigger navigation actions without tightly coupling to the navigation logic.
    @Injected(\.coordinator) private var coordinator: Coordinator

    /// Holds the full unfiltered list of Pokémon items.
    private var allPokemons: [Model.Entity.PokemonListItem] = []

    /// A set used to store Combine's `AnyCancellable` instances.
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init

    /// Initializes a new instance of the Home ViewModel.
    ///
    /// Sets up observation on the `searchString` property using Combine to automatically
    /// apply filters to the Pokémon list whenever the search string changes. Also ensures
    /// proper memory management by storing the subscription in the `cancellables` set.
    override init() {
      super.init()

      $searchString
        .sink { [weak self] _ in
          guard let self else { return }
          filters()
        }
        .store(in: &cancellables)
    }

    // MARK: - Update

    /// Updates the ViewModel state based on the given `AppState`.
    /// This method is called whenever the global app state changes,
    /// refreshing the local list of Pokémon accordingly.
    override func update(state: AppState) {
      super.update(state: state)

      let items = state.pokemonList.pokemonList?.pokemonItems ?? []
      allPokemons = items
      pokemons = items
    }

    // MARK: - Functions

    /// Asynchronously loads additional data for the Home view.
    /// Sets the local state to `.loading` during the fetch,
    /// updates to `.success` on completion, or `.failure` if an error occurs.
    /// Errors thrown during the fetch are handled and reflected in the local state.
    @MainActor
    func loadOthers() async throws {
      guard !isSearching else {
        return
      }
      localState = .loading
      do {
        try await UseCase.FetchPokemonList().execute()
        localState = .success
      } catch {
        localState = .failure(error)
      }
    }

    /// Filters the list of Pokémon based on the current search state and search string.
    ///
    /// If a search is active (`isSearching` is `true`) and the search string is not empty,
    /// this method updates the displayed Pokémon list (`pokemons`) to only include those
    /// whose names contain the search string, using a localized case-insensitive comparison.
    /// If there is no active search or the search string is empty, the full list of Pokémon
    /// (`allPokemons`) is shown.
    ///
    /// This method is typically called automatically when the search string changes,
    /// ensuring the UI always reflects the user's current search query.
    private func filters() {
      if isSearching && !searchString.isEmpty {
        pokemons = allPokemons.filter {
          $0.name.lowercased().localizedCaseInsensitiveContains(searchString)
        }
      } else {
        pokemons = allPokemons
      }
    }
  }
}
