//
//  ModelContext+FetchOrCreate.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

public extension ModelContext {
    /// Fetches an existing entity or creates a new one if not found
    /// Common pattern for ensuring an entity exists
    /// - Parameters:
    ///   - type: The type of entity to fetch or create
    ///   - predicate: The predicate to find the existing entity
    ///   - create: Closure that creates a new entity if none is found
    /// - Returns: Either the existing entity or the newly created one
    /// - Throws: Error if fetch operation fails
    func fetchOrCreate<T: PersistentModel>(
        _ type: T.Type,
        where predicate: Predicate<T>,
        create: () -> T
    ) throws -> T {
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.fetchLimit = 1 // Only need to find one

        // Try to fetch existing entity
        if let existing = try fetch(descriptor).first {
            return existing
        }

        // Create and insert new entity if not found
        let new = create()
        insert(new)
        return new
    }
}
