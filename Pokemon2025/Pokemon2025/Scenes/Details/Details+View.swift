//
//  Details+View.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 18/06/25.
//

import SwiftUI

extension UI.Funnel.Details {
  struct View: SwiftUI.View {

    // MARK: - Stored Properties

    /// The `UI.Funnel.Details.ViewModel` managing the state and data for this view.
    @StateObject private var viewModel = UI.Funnel.Details.ViewModel()

    var body: some SwiftUI.View {
      GlassEffectContainer {
        Text("Hello World")
      }
    }
  }
}
