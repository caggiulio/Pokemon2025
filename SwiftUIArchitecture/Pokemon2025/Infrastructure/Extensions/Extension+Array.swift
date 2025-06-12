//
//  Extension+Array.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 10/06/23.
//

import Foundation

extension Array where Element: Equatable {
  mutating func remove(_ element: Element) {
    if let index = self.firstIndex(of: element) {
      self.remove(at: index)
    }
  }
  
  func contains(_ element: Element) -> Bool {
    return self.firstIndex(of: element) != nil
  }
}
