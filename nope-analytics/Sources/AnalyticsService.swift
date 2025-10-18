//
//  AnalyticsService.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

/// A protocol defining an analytics service that can log actions, events, and screen views.
///
/// Conforming types implement the actual logging behavior for a specific analytics provider,
/// such as Firebase, Mixpanel, or a custom service.
///
/// Example:
/// ```swift
/// struct FirebaseAnalyticsService: AnalyticsService {
///     func logAction(_ action: AnalyticsAction, parameters: [String: Any]?) { /* ... */ }
///     func logEvent(_ name: String, parameters: [String: Any]?) { /* ... */ }
///     func logScreen(_ screen: AnalyticsScreen, parameters: [String: Any]?) { /* ... */ }
/// }
/// ```
public protocol AnalyticsService {
    /// Logs a specific user action.
    ///
    /// - Parameters:
    ///   - action: The action to log, conforming to `AnalyticsAction`.
    ///   - parameters: Optional additional parameters for the action.
    func logAction(_ action: AnalyticsAction, parameters: [String: Any]?)

    /// Logs a custom event.
    ///
    /// - Parameters:
    ///   - name: The name of the event.
    ///   - parameters: Optional additional parameters for the event.
    func logEvent(_ name: String, parameters: [String: Any]?)

    /// Logs a screen view.
    ///
    /// - Parameters:
    ///   - screen: The screen to log, conforming to `AnalyticsScreen`.
    ///   - parameters: Optional additional parameters for the screen view.
    func logScreen(_ screen: AnalyticsScreen, parameters: [String: Any]?)
}
