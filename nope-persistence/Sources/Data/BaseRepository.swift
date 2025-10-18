//
//  BaseRepository.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

// MARK: - Base Repository

/// Generic base implementation of the Repository protocol
/// Provides common functionality that can be inherited by specific repositories
/// Can be subclassed in your app to create type-specific repositories
open class BaseRepository<Entity: PersistentModel>: Repository {
    /// The ModelContext used for all database operations
    public let context: ModelContext

    /// Initializes the repository with a specific context
    /// - Parameter context: The ModelContext to use for operations
    public init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Enhanced Fetch Methods

    /// Fetches entities with optional filtering and sorting
    /// More convenient than creating a FetchDescriptor manually
    /// - Parameters:
    ///   - predicate: Optional predicate to filter results
    ///   - sortBy: Array of sort descriptors for ordering results
    /// - Returns: Array of matching entities
    /// - Throws: Error if fetch operation fails
    public func fetch(
        predicate: Predicate<Entity>? = nil,
        sortBy: [SortDescriptor<Entity>] = []
    ) throws -> [Entity] {
        let descriptor = FetchDescriptor<Entity>(predicate: predicate, sortBy: sortBy)
        return try context.fetch(descriptor)
    }

    /// Fetches the first entity matching the criteria
    /// Useful when you only need one result
    /// - Parameters:
    ///   - predicate: Optional predicate to filter results
    ///   - sortBy: Array of sort descriptors for ordering
    /// - Returns: First matching entity or nil if none found
    /// - Throws: Error if fetch operation fails
    public func fetchFirst(
        predicate: Predicate<Entity>? = nil,
        sortBy: [SortDescriptor<Entity>] = []
    ) throws -> Entity? {
        var descriptor = FetchDescriptor<Entity>(predicate: predicate, sortBy: sortBy)
        descriptor.fetchLimit = 1 // Optimize by only fetching one result
        return try context.fetch(descriptor).first
    }

    // MARK: - Batch Operations

    /// Deletes all entities matching the predicate
    /// Automatically saves after deletion
    /// - Parameter predicate: Optional predicate to filter which entities to delete (nil deletes all)
    /// - Throws: Error if fetch or save operation fails
    public func deleteAll(where predicate: Predicate<Entity>? = nil) throws {
        let entities = try fetch(predicate: predicate)
        entities.forEach { context.delete($0) }
        try save()
    }

    // MARK: - Utility Methods

    /// Checks if any entity exists matching the predicate
    /// More efficient than fetching all entities just to check existence
    /// - Parameter predicate: The predicate to match against
    /// - Returns: true if at least one entity exists, false otherwise
    /// - Throws: Error if count operation fails
    public func exists(where predicate: Predicate<Entity>) throws -> Bool {
        var descriptor = FetchDescriptor<Entity>(predicate: predicate)
        descriptor.fetchLimit = 1 // Optimize by stopping after finding one
        return try context.fetchCount(descriptor) > 0
    }
}
