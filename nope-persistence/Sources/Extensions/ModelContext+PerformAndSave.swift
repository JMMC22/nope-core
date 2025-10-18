//
//  ModelContext+PerformAndSave.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

public extension ModelContext {
    /// Executes a block and automatically saves if successful
    /// Simplifies the pattern of perform + save
    /// - Parameter block: The operation to perform
    /// - Throws: Error from either the block or save operation
    func performAndSave(_ block: () throws -> Void) throws {
        try block()
        if hasChanges {
            try save()
        }
    }
}
