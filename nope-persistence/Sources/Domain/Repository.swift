//
//  Repository.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

// MARK: - Repository Protocol

/// Base protocol for repositories that interact with SwiftData
/// Defines the common CRUD operations for any persistent entity
/// Generic over Entity type that must conform to PersistentModel
public protocol Repository {
    /// The type of entity this repository manages
    associatedtype Entity: PersistentModel

    /// The ModelContext used for database operations
    var context: ModelContext { get }

    /// Inserts a new entity into the context
    /// - Parameter entity: The entity to insert
    func insert(_ entity: Entity)

    /// Deletes an entity from the context
    /// - Parameter entity: The entity to delete
    func delete(_ entity: Entity)

    /// Saves all pending changes to the persistent store
    /// - Throws: Error if save operation fails
    func save() throws

    /// Fetches all entities of this type
    /// - Returns: Array of all entities
    /// - Throws: Error if fetch operation fails
    func fetchAll() throws -> [Entity]

    /// Fetches entities using a custom fetch descriptor
    /// Allows for filtering, sorting, and limiting results
    /// - Parameter descriptor: The fetch descriptor to use
    /// - Returns: Array of matching entities
    /// - Throws: Error if fetch operation fails
    func fetch(with descriptor: FetchDescriptor<Entity>) throws -> [Entity]

    /// Fetches a specific entity by its persistent identifier
    /// - Parameter id: The persistent identifier of the entity
    /// - Returns: The entity if found, nil otherwise
    func fetchByID(_ id: PersistentIdentifier) -> Entity?

    /// Counts the total number of entities
    /// - Returns: The total count
    /// - Throws: Error if count operation fails
    func count() throws -> Int
}

/// Default implementations for Repository protocol
/// These can be overridden by conforming types if needed
public extension Repository {
    /// Default implementation: inserts entity into the context
    func insert(_ entity: Entity) {
        context.insert(entity)
    }

    /// Default implementation: marks entity for deletion
    func delete(_ entity: Entity) {
        context.delete(entity)
    }

    /// Default implementation: saves context if there are changes
    /// Only performs save if context has unsaved changes
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }

    /// Default implementation: fetches all entities without filtering
    func fetchAll() throws -> [Entity] {
        let descriptor = FetchDescriptor<Entity>()
        return try context.fetch(descriptor)
    }

    /// Default implementation: fetches entities using the provided descriptor
    func fetch(with descriptor: FetchDescriptor<Entity>) throws -> [Entity] {
        try context.fetch(descriptor)
    }

    /// Default implementation: retrieves entity by ID from the context
    func fetchByID(_ id: PersistentIdentifier) -> Entity? {
        context.model(for: id) as? Entity
    }

    /// Default implementation: counts all entities
    func count() throws -> Int {
        let descriptor = FetchDescriptor<Entity>()
        return try context.fetchCount(descriptor)
    }
}
