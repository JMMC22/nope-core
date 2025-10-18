//
//  PersistenceConfiguration.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

/// Configuration types for the persistence container
/// Determines how and where data is stored
public enum PersistenceConfiguration {
    /// Production mode - data persisted to disk
    case production
    /// Preview mode - data stored in memory only (for SwiftUI previews)
    case preview
    /// Testing mode - data stored in memory only (for unit tests)
    case testing

    /// Determines if data should be stored only in memory
    /// - Returns: true for preview and testing, false for production
    var isStoredInMemoryOnly: Bool {
        switch self {
        case .production:
            return false
        case .preview, .testing:
            return true
        }
    }
}
