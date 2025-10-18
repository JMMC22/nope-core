//
//  ModelContext+Delete.swift
//  nope-persistence
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import SwiftData

public extension ModelContext {
    /// Deletes multiple entities in a single operation
    /// More convenient than calling delete() in a loop
    /// - Parameter entities: Array of entities to delete
    func delete<T: PersistentModel>(_ entities: [T]) {
        entities.forEach { delete($0) }
    }
}
