//
//  ModelContext+DiscardChanges.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

public extension ModelContext {
    /// Discards all unsaved changes in the context
    /// Resets the context to its last saved state
    func discardChanges() {
        rollback()
    }
}
