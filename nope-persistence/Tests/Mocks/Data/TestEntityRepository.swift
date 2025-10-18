//
//  TestEntityRepository.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import Foundation
import SwiftData

final class TestEntityRepository: BaseRepository<TestEntity> {
    func findByIdentifier(_ identifier: String) throws -> TestEntity? {
        try fetchFirst(predicate: #Predicate { $0.identifier == identifier })
    }

    func findActive() throws -> [TestEntity] {
        try fetch(predicate: #Predicate { $0.isActive == true })
    }

    func findInactive() throws -> [TestEntity] {
        try fetch(predicate: #Predicate { $0.isActive == false })
    }

    func findByMinValue(_ minValue: Int) throws -> [TestEntity] {
        try fetch(
            predicate: #Predicate { $0.value > minValue },
            sortBy: [SortDescriptor(\.value, order: .reverse)]
        )
    }

    func findByNameContaining(_ text: String) throws -> [TestEntity] {
        try fetch(predicate: #Predicate { $0.name.contains(text) })
    }

    func toggleActive(_ entity: TestEntity) throws {
        entity.isActive.toggle()
        try save()
    }
}
