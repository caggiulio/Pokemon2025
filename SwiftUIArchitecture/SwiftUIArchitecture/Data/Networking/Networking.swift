//
//  Networking.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 15/03/25.
//

import Foundation
import RealHTTP

struct Networking {
  
  // MARK: - Computed Properties
    
  /// The `HTTPClient` object to performs network calls.
  /// The object is contained in `RealHTTP` framework.
  var client: HTTPClient {
    let stringApiProtocol = "https"
    let stringApiURL = "pokeapi.co/api/v2/"
    guard let baseURL = URL(string: stringApiProtocol + "://" + stringApiURL) else { fatalError("BaseURL not resolved") }
    
    let httpClient = HTTPClient(baseURL: baseURL, configuration: .default)
    httpClient.responseTransformers = [
      LoggerInformation(),
      RetryerSettings()
    ]
    httpClient.validators.append(ErrorTransformer())

    return httpClient
  }
}
