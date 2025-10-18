//
//  AnalyticsAction+Fixtures.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_analytics

struct MockAnalyticsAction: AnalyticsAction {
    let action: String
}

extension MockAnalyticsAction {
    static func fixture() -> AnalyticsAction {
        return MockAnalyticsAction(action: "mock_action")
    }
}
