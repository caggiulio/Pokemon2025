//
//  StaterObservableViewModel.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 08/08/25.
//

import Factory
import SwiftUI

@Observable
@MainActor
open class StaterObservableViewModel: ObservableObject {

  // MARK: - Computed Properties

  /// The app state.
  @ObservationIgnored @Injected(\.stateContainer) private var appState: StateContainer

  // MARK: - Init

  /// Initializes the view model with default values and sets up subscriptions to the local state and app state.
  init() {
    Task { [weak self] in
      guard let self else { return }
      for await state in self.appState.$state.values {
        self.update(state: state)
      }
    }
  }

  /**
  Updates the app state based on the provided input state.
  
  This function is called whenever the app state changes, and it takes a single argument, state, that represents the new state of the app. The function should update the app's internal state based on the input state, which may include changes to data, user interface, or other app components.
  
  This function should be overridden in subclasses to customize the behavior of the app when the state changes.
  
  - Parameters:
    - state: An instance of the AppState struct that represents the new state of the app.
  
  - Throws:
    This function may throw an error if an error occurs during its execution. Subclasses should document the types of errors that this function may throw, and callers should be prepared to handle these errors.
  
  - Usage:
    You can call this function whenever you need to update the app state, typically in response to user input or other events that affect the app's behavior.
  
  - Example:
    Here's an example of how you might use the update function to update the app's internal state based on a change in the user's selection of a color:
  
        let newState = AppState(selectedColor: .red)
        update(state: newState)
  
    Note that this is just an example, and the actual usage of the update function may vary depending on the specific requirements of your app.
  
  - Subclassing:
    Subclasses should override this function to provide custom behavior when the app state changes. The default implementation of this function does nothing.
  */
  open func update(state: AppStateable) {}
}
