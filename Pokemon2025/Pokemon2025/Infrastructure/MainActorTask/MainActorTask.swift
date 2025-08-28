//
//  MainActorTask.swift
//  Pokemon2025
//
//  Created by Nunzio Giulio Caggegi on 01/08/25.
//

import Foundation

/// Executes an asynchronous operation on the main actor inside a new `Task`.
///
/// - Parameter operation: An asynchronous, throwing closure that is executed on the main actor.
/// - Returns: The created `Task`, which can be used to observe or cancel the operation.
/// - Note: This helper ensures that the operation runs on the main actor. The returned task is discardable if observation or cancellation is not needed.
@discardableResult
func mainActorTask(_ operation: @escaping @MainActor @Sendable () async throws -> Void) -> Task<Void, Error> {
  Task { @MainActor in
    try await operation()
  }
}
