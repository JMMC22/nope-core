//
//  NopeCore.swift
//  nope-core
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@_exported import nope_analytics
@_exported import nope_notifications
@_exported import nope_persistence

/// Namespace principal de NopeCore
public enum NopeCore {
    public static let version = "1.0.0"

    /// Información del build
    public static var info: String {
        "NopeCore v\(version)"
    }
}
