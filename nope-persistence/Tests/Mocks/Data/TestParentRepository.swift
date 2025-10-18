//
//  TestParentRepository.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import Foundation

final class TestParentRepository: BaseRepository<TestParent> {
    func findByName(_ name: String) throws -> TestParent? {
        try fetchFirst(predicate: #Predicate { $0.name == name })
    }

    func findWithMinChildren(_ count: Int) throws -> [TestParent] {
        try fetch(predicate: #Predicate { $0.children.count >= count })
    }
}
