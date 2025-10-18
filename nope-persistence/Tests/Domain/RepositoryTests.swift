//
//  RepositoryTests.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import Foundation
import Testing

@Suite("Repository", .tags(.persistence, .repository))
struct RepositoryTests {
    @Test("Insert single entity")
    func insert_single_entity() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entity = TestEntity.fixture()

        // WHEN
        repository.insert(entity)
        try repository.save()

        // THEN
        try TestAssertions.assertCount(repository, equals: 1)
    }

    @Test("Insert multiple entities")
    func insert_multiple_entities() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entities = TestEntity.fixtures(count: 5)

        // WHEN
        entities.forEach { repository.insert($0) }
        try repository.save()

        // THEN
        try TestAssertions.assertCount(repository, equals: 5)
    }

    @Test("Insert without save doesn't persist")
    func insert_without_save() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entity = TestEntity.fixture()

        // WHEN
        repository.insert(entity)

        // THEN
        #expect(context.hasChanges == true)
    }

    // MARK: - Fetch Tests

    @Test("Fetch all entities")
    func fetch_all_entities() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entities = TestEntity.fixtures(count: 3)
        try TestDataBuilder(context: context).insertAndSave(entities)

        // WHEN
        let fetched = try repository.fetchAll()

        // THEN
        #expect(fetched.count == 3)
    }

    @Test("Fetch with predicate")
    func fetch_with_predicate() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entities = TestEntity.fixtures(count: 6)
        try TestDataBuilder(context: context).insertAndSave(entities)

        // WHEN
        let activeEntities = try repository.findActive()

        // THEN
        #expect(activeEntities.count == 3)
        #expect(activeEntities.allSatisfy { $0.isActive })
    }

    @Test("Fetch first entity")
    func fetch_first_entity() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let targetIdentifier = "unique-id-123"
        let entity = TestEntity(identifier: targetIdentifier, name: "Target", value: 100)
        try TestDataBuilder(context: context).insertAndSave([entity])

        // WHEN
        let found = try repository.findByIdentifier(targetIdentifier)

        // THEN
        #expect(found != nil)
        #expect(found?.identifier == targetIdentifier)
        #expect(found?.name == "Target")
    }

    @Test("Fetch non-existent entity returns nil")
    func fetch_nonexistent_entity() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)

        // WHEN
        let found = try repository.findByIdentifier("non-existent")

        // THEN
        #expect(found == nil)
    }

    @Test("Fetch with sorting")
    func fetch_with_sorting() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entities = TestEntity.fixtures(count: 5)
        try TestDataBuilder(context: context).insertAndSave(entities)

        // WHEN
        let sorted = try repository.findByMinValue(-1)

        // THEN
        #expect(sorted.count == 5)
        #expect(sorted.first?.value == 40)
        #expect(sorted.last?.value == 0)
    }

    @Test("Delete single entity")
    func delete_single_entity() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entity = TestEntity.fixture()
        try TestDataBuilder(context: context).insertAndSave([entity])

        // WHEN
        repository.delete(entity)
        try repository.save()

        // THEN
        try TestAssertions.assertEmpty(repository)
    }

    @Test("Delete with predicate")
    func delete_with_predicate() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entities = TestEntity.fixtures(count: 6)
        try TestDataBuilder(context: context).insertAndSave(entities)

        // WHEN - Delete all inactive entities
        try repository.deleteAll(where: #Predicate { $0.isActive == false })

        // THEN - Only active entities remain
        let remaining = try repository.fetchAll()
        #expect(remaining.count == 3)
        #expect(remaining.allSatisfy { $0.isActive })
    }

    @Test("Delete all entities")
    func delete_all_entities() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entities = TestEntity.fixtures(count: 5)
        try TestDataBuilder(context: context).insertAndSave(entities)

        // WHEN
        try repository.deleteAll()

        // THEN
        try TestAssertions.assertEmpty(repository)
    }

    @Test("Update entity")
    func update_entity() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entity = TestEntity.fixture(name: "Original")
        try TestDataBuilder(context: context).insertAndSave([entity])

        // WHEN
        entity.name = "Updated"
        try repository.save()

        // THEN
        let fetched = try repository.fetchAll().first
        #expect(fetched?.name == "Updated")
    }

    @Test("Toggle entity status")
    func toggle_entity_status() throws {
        // GIVEN
        let context = try TestContainerFactory.makeContext()
        let repository = TestEntityRepository(context: context)
        let entity = TestEntity.fixture(isActive: true)
        try TestDataBuilder(context: context).insertAndSave([entity])

        // WHEN
        try repository.toggleActive(entity)

        // THEN
        #expect(entity.isActive == false)
    }
}
