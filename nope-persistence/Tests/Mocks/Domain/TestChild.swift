//
//  TestChild.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

@Model
final class TestChild {
    var title: String
    var parent: TestParent?

    init(title: String, parent: TestParent? = nil) {
        self.title = title
        self.parent = parent
    }
}
