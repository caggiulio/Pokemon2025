import Foundation
import OSLog

extension Logger {
  /// The bundle identifier of the app.
  static let bundleIdentifier = Bundle.main.bundleIdentifier!

  /// The networking logger.
  static let networking = Logger(subsystem: bundleIdentifier, category: "networking")

  /// The keychain logger.
  static let keychain = Logger(subsystem: bundleIdentifier, category: "keychain")

  /// The simple information logger.
  static let information = Logger(subsystem: bundleIdentifier, category: "information")
}
