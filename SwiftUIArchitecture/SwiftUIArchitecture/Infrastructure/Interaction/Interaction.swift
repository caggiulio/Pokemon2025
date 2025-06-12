//
//  Interaction.swift
//

import Foundation

/// Typically used as a user interaction where it takes no parameters.
typealias Interaction = () -> Void

/// A user interaction that needs a parameter for the input.
typealias CustomInteraction<T> = (T) -> Void
