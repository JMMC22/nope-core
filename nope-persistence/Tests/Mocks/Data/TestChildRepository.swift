//
//  TestChildRepository.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_persistence

import Foundation

final class TestChildRepository: BaseRepository<TestChild> {
    func findByTitle(_ title: String) throws -> TestChild? {
        try fetchFirst(predicate: #Predicate { $0.title == title })
    }

    func findOrphans() throws -> [TestChild] {
        try fetch(predicate: #Predicate { $0.parent == nil })
    }
}
