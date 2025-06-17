//
//  Assemblerifiable.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 12/06/25.
//

import SwiftUI

/// A protocol that defines navigation capabilities for types that can
/// assemble destination views based on a navigation link type.
///
/// Conforming types must specify:
/// - `DestinationView`: The type of view this assembler produces.
/// - `DestinationLink`: A link type used for navigation, which must conform to `Linkable`.
///
/// Conformance requires the implementation of a method to build a destination view
/// for a given navigation link, using SwiftUI's `ViewBuilder`.
@MainActor
protocol Assemblerifiable {
  associatedtype DestinationView: View
  associatedtype DestinationLink: Linkable
  
  /// Produces a destination view for navigation given a `DestinationLink`.
  ///
  /// - Parameter destination: The link that determines which view to assemble.
  /// - Returns: A SwiftUI view appropriate for the provided destination.
  @ViewBuilder
  func navigateTo(destination: DestinationLink) -> DestinationView
}
