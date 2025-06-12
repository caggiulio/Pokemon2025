//
//  LoggerInformation.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 15/03/25.
//


import Foundation
import RealHTTP
import OSLog

extension Networking {
  // This is used to log a HTTP request and his response.
  struct LoggerInformation: HTTPResponseTransform {
    func transform(response: HTTPResponse, ofRequest request: HTTPRequest) throws -> HTTPResponse {
      var stringRequest: String = ""

      stringRequest.append("\n⬆️ ----- START REQUEST ----- ⬆️")
      if let url = request.url {
        stringRequest.append("\n    -- Url: \(url)")
      }
      stringRequest.append("\n    -- Method: \(request.method)")
      if
        let body = try? request.body.asJSONEncodable?.serializeData().data,
        let stringBody = String(data: body, encoding: .utf8) {
        stringRequest.append("\n    -- Body : \(stringBody)")
      }
      if
        let headers = request.client?.headers.asDictionary,
        !headers.isEmpty
      {
        stringRequest.append("\n    -- Headers")
        for (key, value) in headers {
          stringRequest.append("\n        -- \(key): \(value)")
        }
      }
      stringRequest.append("\n⬆️ ----- END REQUEST ----- ⬆️")

      Logger.networking.info("\(stringRequest)")

      var stringResponse: String = ""
      stringResponse.append("\n⬇️ ----- START RESPONSE ----- ⬇️")
      if let response = response.httpResponse {
        stringResponse.append("\n    -- Url: \(response.url?.absoluteString ?? "NO URL")")

        let statusCode = response.statusCode
        if statusCode >= 200, statusCode < 300 {
          stringResponse.append("\n    -- Status Code: ✅ \(statusCode)")
        } else {
          stringResponse.append("\n    -- Status Code: ❌ \(statusCode)")
        }
      } else {
        stringResponse.append("\n    -- Response: NO RESPONSE")
      }
      if let data = response.data {
        if let stringBody = String(data: data, encoding: .utf8) {
          stringResponse.append("\n    -- Body : \(stringBody)")
        } else {
          stringResponse.append("\n    -- Body : NO HTTP BODY")
        }
      } else {
        stringResponse.append("\n    -- data: NO DATA")
      }
      if let error = response.error?.error {
        stringResponse.append("\n    -- Error: 🚨 \(error.localizedDescription)")
      } else {
        stringResponse.append("\n    -- Error: 👌 NO ERROR")
      }
      stringResponse.append("\n⬇️ ----- END RESPONSE ----- ⬇️")
      Logger.networking.info("\(stringResponse)")

      return response
    }
  }

}
