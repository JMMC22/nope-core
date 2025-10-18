//
//  AnalyticsManagerTests.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_analytics
import Testing

extension Tag {
    @Tag static var analytics: Self
    @Tag static var core: Self
}

@Suite("Analytics Manager", .tags(.analytics, .core))
struct AnalyticsManagerTests {
    @Test("Log action event without parameters")
    func log_action_without_parameters() {
        // GIVEN
        let mockService = MockAnalyticsService()
        let sut = AnalyticsManager()
        sut.configure(providers: [mockService])
        let action = MockAnalyticsAction.fixture()

        // WHEN
        sut.logAction(action, parameters: nil)

        // THEN
        #expect(mockService.loggedActions.count == 1)
        #expect(mockService.loggedActions.first?.0.action == "mock_action")
        #expect(mockService.loggedActions.first?.1 == nil)
    }

    @Test("Log action event with parameters")
    func log_action_with_parameters() {
        // GIVEN
        let mockService = MockAnalyticsService()
        let sut = AnalyticsManager()
        sut.configure(providers: [mockService])
        let action = MockAnalyticsAction.fixture()
        let params = Dictionary.fixture()

        // WHEN
        sut.logAction(action, parameters: params)

        // THEN
        #expect(mockService.loggedActions.count == 1)
        #expect(mockService.loggedActions.first?.0.action == "mock_action")
        #expect(mockService.loggedActions.first?.1?["key1"] as? String == "value1")
        #expect(mockService.loggedActions.first?.1?["key2"] as? Int == 2)
    }

    @Test("Log custom event without parameters")
    func log_event_without_parameters() {
        // GIVEN
        let mockService = MockAnalyticsService()
        let sut = AnalyticsManager()
        sut.configure(providers: [mockService])

        // WHEN
        sut.logEvent("mock_event", parameters: nil)

        // THEN
        #expect(mockService.loggedEvents.count == 1)
        #expect(mockService.loggedEvents.first?.0 == "mock_event")
        #expect(mockService.loggedEvents.first?.1 == nil)
    }

    @Test("Log custom event with parameters")
    func log_event_with_parameters() {
        // GIVEN
        let mockService = MockAnalyticsService()
        let sut = AnalyticsManager()
        sut.configure(providers: [mockService])
        let params = Dictionary.fixture()

        // WHEN
        sut.logEvent("test_event", parameters: params)

        // THEN
        #expect(mockService.loggedEvents.count == 1)
        #expect(mockService.loggedEvents.first?.0 == "test_event")
        #expect(mockService.loggedEvents.first?.1?["key1"] as? String == "value1")
        #expect(mockService.loggedEvents.first?.1?["key2"] as? Int == 2)
    }

    @Test("Log screen view without parameters")
    func log_screen_without_parameters() {
        // GIVEN
        let mockService = MockAnalyticsService()
        let sut = AnalyticsManager()
        sut.configure(providers: [mockService])
        let screen = MockAnalyticsScreen.fixture()

        // WHEN
        sut.logScreen(screen, parameters: nil)

        // THEN
        #expect(mockService.loggedScreens.count == 1)
        #expect(mockService.loggedScreens.first?.0.screen == "mock_screen")
        #expect(mockService.loggedScreens.first?.1 == nil)
    }

    @Test("Log screen view with parameters")
    func log_screen_with_parameters() {
        // GIVEN
        let mockService = MockAnalyticsService()
        let sut = AnalyticsManager()
        sut.configure(providers: [mockService])
        let screen = MockAnalyticsScreen.fixture()
        let params = Dictionary.fixture()

        // WHEN
        sut.logScreen(screen, parameters: params)

        // THEN
        #expect(mockService.loggedScreens.count == 1)
        #expect(mockService.loggedScreens.first?.0.screen == "mock_screen")
        #expect(mockService.loggedScreens.first?.1?["key1"] as? String == "value1")
        #expect(mockService.loggedScreens.first?.1?["key2"] as? Int == 2)
    }

    @Test("Logs to multiple providers")
    func logs_to_multiple_providers() {
        // GIVEN
        let mockAnalyticsProvider1 = MockAnalyticsService()
        let mockAnalyticsProvider2 = MockAnalyticsService()
        let sut = AnalyticsManager()
        sut.configure(providers: [mockAnalyticsProvider1, mockAnalyticsProvider2])

        // WHEN
        sut.logEvent("test_event", parameters: nil)

        // THEN
        #expect(mockAnalyticsProvider1.loggedEvents.count == 1)
        #expect(mockAnalyticsProvider2.loggedEvents.count == 1)
    }
}
