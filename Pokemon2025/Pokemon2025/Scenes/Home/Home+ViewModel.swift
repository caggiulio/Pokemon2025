//
//  Home+ViewModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Foundation

extension UI.Funnel.Home {
  class ViewModel: StaterViewModel {

    // MARK: - Stored Properties

    /// The local state of the view model.
    @Published private(set) var localState: LocalState<Empty, Never> = .idle

    // MARK: - Update

    override func update(state: AppState) {}
  }
}
