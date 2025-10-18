//
//  PersistenceContainer.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

// MARK: - Persistence Container

/// Manages the SwiftData ModelContainer with different configurations
/// Acts as the central point for database setup and context creation
public final class PersistenceContainer {
    /// The underlying SwiftData container that manages the persistent store
    public let modelContainer: ModelContainer

    /// The configuration used to initialize this container
    public let configuration: PersistenceConfiguration

    /// Initializes the container with the specified models and configuration
    /// - Parameters:
    ///   - schema: The schema containing all model types to be persisted
    ///   - configuration: The storage configuration (defaults to production)
    /// - Throws: Error if the container cannot be created
    public init(
        for schema: Schema,
        configuration: PersistenceConfiguration = .production
    ) throws {
        self.configuration = configuration

        // Create model configuration based on the persistence type
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: configuration.isStoredInMemoryOnly
        )

        // Initialize the container with the schema and configuration
        self.modelContainer = try ModelContainer(
            for: schema,
            configurations: [modelConfiguration]
        )
    }

    /// Returns the main context (must be used on main thread)
    /// Use this for UI-related operations
    @MainActor
    public var mainContext: ModelContext {
        modelContainer.mainContext
    }

    /// Creates a new background context for heavy operations
    /// Safe to use on background threads for data processing
    /// - Returns: A new ModelContext instance
    public func backgroundContext() -> ModelContext {
        ModelContext(modelContainer)
    }
}
