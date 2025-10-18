//
//  TestContainerFactory.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import SwiftData

enum TestContainerFactory {
    /// Creates a test container with in-memory storage
    /// - Parameter schema: The schema to use (default includes all test models)
    /// - Returns: A configured PersistenceContainer for testing
    static func makeContainer(
        schema: Schema = Schema([TestEntity.self, TestParent.self, TestChild.self])
    ) throws -> PersistenceContainer {
        try PersistenceContainer(for: schema, configuration: .testing)
    }

    /// Creates a test container and returns its background context
    /// - Returns: A ModelContext ready for testing
    static func makeContext() throws -> ModelContext {
        let container = try makeContainer()
        return container.backgroundContext()
    }

    /// Creates a test container with a specific model type
    /// - Parameter type: The model type to include in the schema
    /// - Returns: A configured PersistenceContainer
    static func makeContainer<T: PersistentModel>(for type: T.Type) throws -> PersistenceContainer {
        let schema = Schema([type])
        return try PersistenceContainer(for: schema, configuration: .testing)
    }
}
