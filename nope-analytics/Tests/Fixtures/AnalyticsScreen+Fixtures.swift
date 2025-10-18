//
//  AnalyticsScreen+Fixtures.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_analytics

struct MockAnalyticsScreen: AnalyticsScreen {
    let screen: String
}

extension MockAnalyticsScreen {
    static func fixture() -> AnalyticsScreen {
        return MockAnalyticsScreen(screen: "mock_screen")
    }
}
