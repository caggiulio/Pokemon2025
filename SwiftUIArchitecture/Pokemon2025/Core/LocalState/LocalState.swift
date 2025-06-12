//
//  LocalState.swift
//

import Foundation
import SwiftUI

/// This is the `enum` used to defines the state of the `async` method in the `ViewModel` of the app.
public enum LocalState<Value: Equatable, Error: Swift.Error>: Equatable, Sendable where Value: Sendable {
  case idle
  case loading
  case success(Value)
  case failure(Error)

  public static func == (lhs: LocalState<Value, Error>, rhs: LocalState<Value, Error>) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle), (.loading, .loading):
      return true

    case let (.success(value1), .success(value2)):
      return value1 == value2

    case let (.failure(error1), .failure(error2)):
      return error1.localizedDescription == error2.localizedDescription

    default:
      return false
    }
  }
}

public extension LocalState {
  var value: Value? {
    guard case let .success(value) = self else {
      return nil
    }
    
    return value
  }
  
  var error: Error? {
    guard case let .failure(error) = self else {
      return nil
    }
    
    return error
  }
  
  var isError: Binding<Bool> {
    Binding {
      self.error != nil
    } set: { _ in }
  }
  
  var isLoading: Binding<Bool> {
    Binding {
      self == .loading
    } set: { _ in }
  }
}

extension LocalState where Value == Empty {
  static var success: LocalState {
    .success(Empty())
  }
}
