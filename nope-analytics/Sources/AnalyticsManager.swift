//
//  AnalyticsManager.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation

/// A thread-safe analytics manager that coordinates multiple analytics providers.
/// Example:
/// AnalyticsManager.shared.configure(providers: [FirebaseProvider(), MixpanelProvider()])
/// AnalyticsManager.shared.logEvent("purchase_completed", parameters: ["amount": 29.99])
public final class AnalyticsManager: AnalyticsService, @unchecked Sendable {
    public static let shared = AnalyticsManager()

    /// Internal lock to ensure thread safety when accessing providers.
    private let lock = NSLock()

    /// Array of analytics service providers to which events will be delegated.
    private var _providers: [AnalyticsService] = []

    public init() {}

    /// Configures the analytics manager with one or more analytics providers.
    ///
    /// - Parameter providers: The list of analytics service providers to register.
    public func configure(providers: [AnalyticsService]) {
        lock.lock() // Lock before modifying the array to prevent concurrent access issues.
        defer { lock.unlock() }
        _providers = providers
    }

    /// Logs a specific user action to all configured analytics providers.
    ///
    /// - Parameters:
    ///   - action: The analytics action to log.
    ///   - parameters: Optional dictionary of additional parameters.
    public func logAction(_ action: any AnalyticsAction, parameters: [String: Any]?) {
        lock.lock() // Lock before modifying the array to prevent concurrent access issues.
        let providers = _providers
        lock.unlock()

        for provider in providers {
            provider.logAction(action, parameters: parameters)
        }
    }

    /// Logs a custom event to all configured analytics providers.
    ///
    /// - Parameters:
    ///   - name: The name of the event.
    ///   - parameters: Optional dictionary of event parameters.
    public func logEvent(_ name: String, parameters: [String: Any]?) {
        lock.lock() // Lock before modifying the array to prevent concurrent access issues.
        let providers = _providers
        lock.unlock()

        for provider in providers {
            provider.logEvent(name, parameters: parameters)
        }
    }

    /// Logs a screen view to all configured analytics providers.
    ///
    /// - Parameters:
    ///   - screen: The screen type or identifier.
    ///   - parameters: Optional dictionary of additional parameters.
    public func logScreen(_ screen: any AnalyticsScreen, parameters: [String: Any]?) {
        lock.lock() // Lock before modifying the array to prevent concurrent access issues.
        let providers = _providers
        lock.unlock()

        for provider in providers {
            provider.logScreen(screen, parameters: parameters)
        }
    }
}
