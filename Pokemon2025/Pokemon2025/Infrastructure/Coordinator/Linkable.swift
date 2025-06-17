//
//  Linkable.swift
//  Pokemon2025
//
//  Created by Giulio Caggegi on 12/06/25.
//

/// A protocol that indicates a type can be referenced or associated via a link,
/// typically used as a marker protocol for models that are intended to be hashable
/// and associated with unique identifiers or relationships.
///
/// Conforming types must implement `Hashable`.
protocol Linkable: Hashable {}
