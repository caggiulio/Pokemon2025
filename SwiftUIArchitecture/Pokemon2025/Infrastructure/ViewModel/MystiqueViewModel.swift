//
//  MystiqueViewModel.swift
//
//

import Combine
import Factory
import SwiftUI

open class MystiqueViewModel<Model: CustomModel>: ObservableObject {
  
  // MARK: - Computed Properties
  
  /// The loading state with his related `Model`.
  @Published var localState: LocalState<Model, CustomError> = .idle
  
  /// The last value of the `Model` if exist. This variable is assigned when a `LocalState`
  /// become `.success`.
  @Published private var model: Model?
    
  /// The cancellables set used for store `Combine` values.
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Init
  
  /// Initializes the view model with default values and sets up subscriptions to the local state and app state.
  init() {
    self.$localState
      .sink { [weak self] state in
        guard let newValue = state.value else {
          return
        }
        self?.model = newValue
      }
      .store(in: &cancellables)
  }
  
  // MARK: - Methods
  
  /**
  Cancels all the cancellables stored in the array.

  This function cancels all the cancellable objects that have been added to the cancellables array. It uses the cancel() function of each Cancellable element in the array to stop any ongoing operations or subscriptions.
   
  Usage:
  ```
   viewModel.unsubscribe()
  ```
  - Note: This function does not remove the cancelled elements from the cancellables array.
   
   The unsubscribe() function is a method that cancels all the cancellable objects in the cancellables array. It iterates through each element in the array and calls its cancel() function to stop any ongoing operations or subscriptions.

   It is important to note that this function does not remove the cancelled elements from the cancellables array. If you want to remove the cancelled objects from the array, you will need to do so manually.

   You can call this function on an instance of an object that has an array of cancellable objects, like so: myObject.unsubscribe().
  */
  func unsubscribe() {
    cancellables.forEach { element in
      element.cancel()
    }
  }
}

