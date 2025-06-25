//
//  Extension+Color.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 25/06/25.
//

import SwiftUI

/// Extension to the `Color` struct to enable initialization from hexadecimal color strings.
/// This provides a convenient way to create colors using hex codes commonly used in design.
extension SwiftUI.Color {
  /// Creates a `Color` instance from a hexadecimal color string.
  ///
  /// Supported formats:
  /// - RGB (12-bit), e.g. "F00" (equivalent to "FF0000")
  /// - RGB (24-bit), e.g. "FF0000"
  /// - ARGB (32-bit), e.g. "FFFF0000" (with alpha channel)
  ///
  /// The initializer trims invalid characters and parses the hex string components into color channels.
  /// If the input is invalid or unsupported, it defaults to an opaque black color.
  ///
  /// - Parameter hex: A string representing a hex color code.
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3:  // RGB (12-bit), each digit is repeated to form the full byte
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6:  // RGB (24-bit), standard RGB without alpha, alpha set to 255 (opaque)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8:  // ARGB (32-bit), with alpha channel at the highest byte
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      // Invalid format defaults to black with zero opacity
      (a, r, g, b) = (1, 1, 1, 0)
    }

    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}
