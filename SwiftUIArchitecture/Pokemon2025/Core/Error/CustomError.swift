//
//  CustomError.swift
//
//

import Foundation

/// The custom `Swift.Error` of the app.
public enum CustomError: Swift.Error, Equatable {
  case genericError(String)
  case resourceNotFound
}

// MARK: LocalizedError

extension CustomError: LocalizedError {
  /// The error description of the `Swift.Error`.
  /// We must override `errorDescription` to access `error.localizedDescription`
  public var errorDescription: String? {
    switch self {
    case let .genericError(message):
      return message
    
    case .resourceNotFound:
      return "Resource not found"
    }
  }
}
