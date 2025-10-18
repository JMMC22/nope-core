//
//  PersistenceContainerTests.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import SwiftData
import Testing

@Suite("Persistence Container", .tags(.persistence, .container))
struct PersistenceContainerTests {
    @Test("Initialize in production mode")
    func initialize_production_mode() throws {
        // GIVEN
        let schema = Schema([TestEntity.self])

        // WHEN
        let container = try PersistenceContainer(for: schema, configuration: .production)

        // THEN
        #expect(container.configuration == .production)
    }

    @Test("Initialize in preview mode")
    func initialize_preview_mode() throws {
        // GIVEN
        let schema = Schema([TestEntity.self])

        // WHEN
        let container = try PersistenceContainer(for: schema, configuration: .preview)

        // THEN
        #expect(container.configuration == .preview)
    }

    @Test("Initialize in testing mode")
    func initialize_testing_mode() throws {
        // GIVEN
        let schema = Schema([TestEntity.self])

        // WHEN
        let container = try PersistenceContainer(for: schema, configuration: .testing)

        // THEN
        #expect(container.configuration == .testing)
    }

    @Test("Initialize with multiple models")
    func initialize_with_multiple_models() throws {
        // GIVEN
        let schema = Schema([TestEntity.self, TestParent.self, TestChild.self])

        // WHEN
        let container = try PersistenceContainer(for: schema, configuration: .testing)

        // THEN
        #expect(container.configuration == .testing)
    }

    @Test("Create background context")
    func create_background_context() throws {
        // GIVEN
        let container = try TestContainerFactory.makeContainer()

        // WHEN
        let backgroundContext = container.backgroundContext()

        // THEN
        #expect(backgroundContext.container === container.modelContainer)
    }

    @Test("Create multiple background contexts")
    func create_multiple_background_contexts() throws {
        // GIVEN
        let container = try TestContainerFactory.makeContainer()

        // WHEN
        let context1 = container.backgroundContext()
        let context2 = container.backgroundContext()

        // THEN
        #expect(context1 !== context2)
    }

    @Test("Testing configuration is in-memory")
    func ing_configuration_is_in_memory() {
        // GIVEN
        let config = PersistenceConfiguration.testing

        // WHEN
        let isInMemory = config.isStoredInMemoryOnly

        // THEN
        #expect(isInMemory == true)
    }

    @Test("Production configuration uses disk storage")
    func production_configuration_uses_disk() {
        // GIVEN
        let config = PersistenceConfiguration.production

        // WHEN
        let isInMemory = config.isStoredInMemoryOnly

        // THEN
        #expect(isInMemory == false)
    }

    @Test("Preview configuration is in-memory")
    func preview_configuration_is_in_memory() {
        // GIVEN
        let config = PersistenceConfiguration.preview

        // WHEN
        let isInMemory = config.isStoredInMemoryOnly

        // THEN
        #expect(isInMemory == true)
    }
}
