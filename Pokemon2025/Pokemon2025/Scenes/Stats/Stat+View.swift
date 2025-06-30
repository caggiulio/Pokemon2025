//
//  Stat+View.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 27/06/25.
//

import SwiftUI

extension UI.Funnel.Details.Stats {
  /// The `View` for the single ability. Contains a `ProgressView`, a title and a value.
  struct Ability: SwiftUI.View {
    // MARK: - Constants

    /// The minimun value for the `Gauge`.
    let minimumGaugeValue: Float = .zero

    /// The maximum value for the `Gauge`.
    let maximumGaugeValue: Float = 120

    // MARK: - Stored Properties

    /// The model for the single `Ability`.
    let model: Model.Entity.Stat

    /// The value of the `ProgressView`. Initially is `.zero` to animate the `View`.
    @State private var progress: Float = .zero

    // MARK: - Init

    /// The `init` of the `View`.
    /// - Parameter model: The model for the single `Ability`.
    init(model: Model.Entity.Stat) {
      self.model = model
    }

    // MARK: - View

    var body: some SwiftUI.View {
      VStack(alignment: .leading) {
        Text(model.name)
          .fontWeight(.bold)
          .font(.title3)

        Gauge(value: progress, in: minimumGaugeValue...maximumGaugeValue) {}
          .animation(.spring(duration: 0.5, bounce: 0.25), value: progress)
          .background {
            Capsule()
              .fill(.shadow(.inner(radius: 1, y: 1)))
              .foregroundStyle(.red.opacity(0.2))
          }
      }
      .tint(.red.opacity(0.9))
      .padding()
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          progress = model.baseStat
        }
      }
    }
  }
}
