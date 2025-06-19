//
//  HomeDestinationLink 2.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 18/06/25.
//

import SwiftUI

/// The enums that defines the possible destination links of the flow.
enum HomeDestinationLink: Linkable {
  /// The details case.
  case details(transitionIdentifier: String, animation: Namespace.ID)
}
