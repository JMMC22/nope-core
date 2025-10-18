//
//  TestParent.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

@Model
final class TestParent {
    var name: String
    var children: [TestChild]

    init(name: String, children: [TestChild] = []) {
        self.name = name
        self.children = children
    }
}

extension TestParent {
    static func fixture(
        name: String = "Parent",
        childrenCount: Int = 2
    ) -> TestParent {
        let parent = TestParent(name: name)
        let children = (0 ..< childrenCount).map { TestChild(title: "Child \($0)", parent: parent) }
        parent.children = children
        return parent
    }
}
