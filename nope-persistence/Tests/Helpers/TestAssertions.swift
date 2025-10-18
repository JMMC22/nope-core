//
//  TestAssertions.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import Foundation
import SwiftData
import Testing

enum TestAssertions {
    /// Asserts that a repository has the expected count
    static func assertCount<T: PersistentModel>(
        _ repository: BaseRepository<T>,
        equals expected: Int,
        sourceLocation: SourceLocation = #_sourceLocation
    ) throws {
        let actual = try repository.count()
        #expect(actual == expected, sourceLocation: sourceLocation)
    }

    /// Asserts that a fetch operation returns empty results
    static func assertEmpty<T: PersistentModel>(
        _ repository: BaseRepository<T>,
        sourceLocation: SourceLocation = #_sourceLocation
    ) throws {
        let results = try repository.fetchAll()
        #expect(results.isEmpty, sourceLocation: sourceLocation)
    }

    /// Asserts that an entity exists in the repository
    static func assertExists<T: PersistentModel>(
        _ repository: BaseRepository<T>,
        where predicate: Predicate<T>,
        sourceLocation: SourceLocation = #_sourceLocation
    ) throws {
        let exists = try repository.exists(where: predicate)
        #expect(exists == true, sourceLocation: sourceLocation)
    }

    /// Asserts that an entity does not exist in the repository
    static func assertNotExists<T: PersistentModel>(
        _ repository: BaseRepository<T>,
        where predicate: Predicate<T>,
        sourceLocation: SourceLocation = #_sourceLocation
    ) throws {
        let exists = try repository.exists(where: predicate)
        #expect(exists == false, sourceLocation: sourceLocation)
    }
}
