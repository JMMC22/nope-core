//
//  TestEntity.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

@Model
final class TestEntity {
    var identifier: String
    var name: String
    var value: Int
    var isActive: Bool
    var createdAt: Date

    init(
        identifier: String = UUID().uuidString,
        name: String,
        value: Int,
        isActive: Bool = true,
        createdAt: Date = Date()
    ) {
        self.identifier = identifier
        self.name = name
        self.value = value
        self.isActive = isActive
        self.createdAt = createdAt
    }
}

extension TestEntity {
    static func fixture(
        name: String = "Test Entity",
        value: Int = 42,
        isActive: Bool = true
    ) -> TestEntity {
        TestEntity(
            name: name,
            value: value,
            isActive: isActive
        )
    }

    static func fixtures(count: Int) -> [TestEntity] {
        (0 ..< count).map { index in
            TestEntity(
                name: "Entity \(index)",
                value: index * 10,
                isActive: index.isMultiple(of: 2)
            )
        }
    }
}
