//
//  AnalyticsAction.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

/// Represents a user action that can be tracked in an analytics system.
///
/// Conforming types define a specific action that can be logged by `AnalyticsManager`
/// or other analytics providers.
///
/// Example:
/// ```swift
/// struct PurchaseAction: AnalyticsAction {
///     let action = "purchase_completed"
/// }
/// ```
public protocol AnalyticsAction: Sendable {
    var action: String { get }
}
