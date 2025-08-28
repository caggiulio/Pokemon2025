//
//  Stats.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 27/06/25.
//

import SwiftUI

extension UI.Funnel.Details.Stats {
  struct View: SwiftUI.View {

    // MARK: - Stored Properties

    /// The `UI.Funnel.Details.Stats.ViewModel` managing the state and data for this view.
    @StateObject private var viewModel = UI.Funnel.Details.Stats.ViewModel()

    // MARK: - Body

    var body: some SwiftUI.View {
      ScrollView(.vertical) {
        ForEach(viewModel.stats) {
          UI.Funnel.Details.Stats.Ability(model: $0)
            .scrollTransition { view, phase in
              view
                .scaleEffect(phase.isIdentity ? 1 : 0.85)
            }
        }
      }
      .padding(.small)
    }
  }
}
