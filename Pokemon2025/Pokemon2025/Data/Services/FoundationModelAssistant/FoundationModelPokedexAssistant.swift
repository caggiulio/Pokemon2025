//
//  FoundationModelPokedexAssistant.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 23/06/25.
//

import Foundation
import FoundationModels

/// Provides language model assistance for presenting detailed Pokémon information and strategic suggestions based on a Pokémon identifier.
struct FoundationModelPokedexAssistant {

  // MARK: - Stored Properties

  /// The default system language model used for checking availability and session creation.
  private let model = SystemLanguageModel.default

  // MARK: - Computed Properties

  /// Indicates whether the default system language model is available on this device.
  public var isAvailable: Bool {
    return model.isAvailable
  }

  /// Session for interacting with the language model, configured to explain Pokémon and suggest their use cases based on the provided identifier.
  private let session = LanguageModelSession(model: SystemLanguageModel(useCase: .general)) {
    """
    Your job is to assist the user in understand how and when use a Pokemon.
    The user provides you a Pokemon identifier, that is the identifier number of a Pokemon and his name, and you must provides the Pokemon information, exactly like a Pokedex. Moreover, you must provides also the types/categories with which the Pokemon is identified.
    """
  }

  // MARK: - Functions

  /// Returns the language model session configured to explain Pokémon details and suggest use cases based on a provided Pokémon identifier.
  ///
  /// - Returns: A `LanguageModelSession` instance pre-configured with prompts for Pokémon information and strategy suggestions.
  func getSession() -> LanguageModelSession {
    session
  }
}
