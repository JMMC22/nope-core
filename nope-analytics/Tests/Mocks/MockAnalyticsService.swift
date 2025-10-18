//
//  MockAnalyticsService.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_analytics

public final class MockAnalyticsService: AnalyticsService {
    public var loggedActions: [(AnalyticsAction, [String: Any]?)] = []
    public var loggedEvents: [(String, [String: Any]?)] = []
    public var loggedScreens: [(AnalyticsScreen, [String: Any]?)] = []

    public init() {}

    public func logAction(_ action: AnalyticsAction, parameters: [String: Any]?) {
        loggedActions.append((action, parameters))
    }

    public func logEvent(_ name: String, parameters: [String: Any]?) {
        loggedEvents.append((name, parameters))
    }

    public func logScreen(_ screen: AnalyticsScreen, parameters: [String: Any]?) {
        loggedScreens.append((screen, parameters))
    }
}
