//
//  HomeSearch+View.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 18/06/25.
//

import SwiftUI

/// A view for controlling and reflecting the search state within the Home funnel.
extension UI.Funnel.Home.View {
  struct Search: SwiftUI.View {

    // MARK: - Stored Properties

    /// Indicates whether the search interaction is currently active, from the environment.
    @Environment(\.isSearching) var isSearching
    /// Binding to the external search state, allowing two-way sync with parent.
    @Binding var isSearchingBinding: Bool

    // MARK: - View

    /// Displays an invisible view that synchronizes the search state with its parent.
    /// Updates `isSearchingBinding` whenever the environment's search state changes.
    var body: some SwiftUI.View {
      ZStack {}
        .onChange(of: isSearching) { _, newValue in
          isSearchingBinding = newValue
        }
    }
  }
}
