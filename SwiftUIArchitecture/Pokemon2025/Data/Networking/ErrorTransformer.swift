//
//  ErrorTransformer.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 15/03/25.
//

import Foundation
import RealHTTP

extension Networking {
  /// The `HTTPValidator` to transform the error in the a custom `Error`.
  class ErrorTransformer: HTTPValidator {
    public func validate(response: HTTPResponse, forRequest request: HTTPRequest) -> HTTPResponseValidatorResult {
      guard response.isError else {
        return .nextValidator
      }
      
      guard let _ = response.data else {
        return .failChain(CustomError.genericError("error"))
      }
      
      switch response.statusCode {
      case HTTPStatusCode(rawValue: 404):
        return .failChain(CustomError.resourceNotFound)
        
      default:
        return .failChain(CustomError.genericError("error"))
      }
    }
  }
}
