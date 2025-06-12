//
//  RetryerSettings.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 15/03/25.
//


import Foundation
import RealHTTP

extension Networking {
  struct RetryerSettings: HTTPResponseTransform {
    func transform(response: HTTPResponse, ofRequest request: HTTPRequest) throws -> HTTPResponse {
      request.maxRetries = 1

      return response
    }
  }
}
