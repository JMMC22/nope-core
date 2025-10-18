//
//  TestDataBuilder.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import Foundation
import SwiftData

struct TestDataBuilder {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    /// Inserts and saves multiple entities
    @discardableResult
    func insertAndSave<T: PersistentModel>(_ entities: [T]) throws -> Self {
        entities.forEach { context.insert($0) }
        try context.save()
        return self
    }

    /// Creates and inserts test entities with a builder closure
    @discardableResult
    func create<T: PersistentModel>(
        count: Int,
        builder: (Int) -> T
    ) throws -> [T] {
        let entities = (0 ..< count).map(builder)
        try insertAndSave(entities)
        return entities
    }
}
