//
//  AnalyticsScreen.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

/// Represents a screen or view that can be tracked in an analytics system.
///
/// Conforming types define a specific screen that can be logged by `AnalyticsManager`
/// or other analytics providers.
///
/// Example:
/// ```swift
/// struct HomeScreen: AnalyticsScreen {
///     let screen = "home_screen"
/// }
/// ```
public protocol AnalyticsScreen: Sendable {
    var screen: String { get }
}
