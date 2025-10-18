//
//  LocalNotificationSchedulerTests.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_notifications
import Testing
import UserNotifications

@Suite("Local Notification Scheduler", .tags(.notifications, .core))
struct LocalNotificationSchedulerTests {
    @Test("Schedule notification successfully")
    func schedule_notification_successfully() async throws {
        // GIVEN
        let mockCenter = MockNotificationCenter()
        let sut = DefaultLocalNotificationScheduler(notificationCenter: mockCenter)
        let request = NotificationRequest.fixture(
            id: "test-1",
            trigger: .timeIntervalFixture()
        )

        // WHEN
        try await sut.schedule(request)

        // THEN
        #expect(mockCenter.addedRequests.count == 1)
        #expect(mockCenter.addedRequests.first?.identifier == "test-1")
        #expect(mockCenter.addedRequests.first?.content.title == "Test Title")
    }

    @Test("Schedule notification with all content parameters")
    func schedule_notification_with_all_parameters() async throws {
        // GIVEN
        let mockCenter = MockNotificationCenter()
        let sut = DefaultLocalNotificationScheduler(notificationCenter: mockCenter)
        let content = NotificationContent.fixture(
            title: "Custom Title",
            body: "Custom Body",
            subtitle: "Subtitle",
            badge: 5,
            userInfo: .fixture()
        )
        let request = NotificationRequest.fixture(
            id: "test-2",
            content: content
        )

        // WHEN
        try await sut.schedule(request)

        // THEN
        #expect(mockCenter.addedRequests.count == 1)
        #expect(mockCenter.addedRequests.first?.content.subtitle == "Subtitle")
        #expect(mockCenter.addedRequests.first?.content.badge?.intValue == 5)
        #expect(mockCenter.addedRequests.first?.content.userInfo["key1"] as? String == "value1")
    }

    @Test("Get pending notifications")
    func get_pending_notifications() async throws {
        // GIVEN
        let mockCenter = MockNotificationCenter()
        let sut = DefaultLocalNotificationScheduler(notificationCenter: mockCenter)

        mockCenter.pendingRequests = [
            .timeIntervalFixture(identifier: "pending-1"),
        ]

        // WHEN
        let pending = await sut.getPending()

        // THEN
        #expect(pending.count == 1)
        #expect(pending.first?.id == "pending-1")
    }

    @Test("Schedule notification with time interval trigger")
    func schedule_with_time_interval_trigger() async throws {
        // GIVEN
        let mockCenter = MockNotificationCenter()
        let sut = DefaultLocalNotificationScheduler(notificationCenter: mockCenter)
        let request = NotificationRequest.fixture(
            trigger: .timeIntervalFixture(interval: 300, repeats: true)
        )

        // WHEN
        try await sut.schedule(request)

        // THEN
        #expect(mockCenter.addedRequests.count == 1)
        let trigger = mockCenter.addedRequests.first?.trigger as? UNTimeIntervalNotificationTrigger
        #expect(trigger?.timeInterval == 300)
        #expect(trigger?.repeats == true)
    }

    @Test("Schedule notification with calendar trigger")
    func schedule_with_calendar_trigger() async throws {
        // GIVEN
        let mockCenter = MockNotificationCenter()
        let sut = DefaultLocalNotificationScheduler(notificationCenter: mockCenter)
        let request = NotificationRequest.fixture(
            trigger: .calendarFixture(hour: 9, minute: 30)
        )

        // WHEN
        try await sut.schedule(request)

        // THEN
        #expect(mockCenter.addedRequests.count == 1)
        let trigger = mockCenter.addedRequests.first?.trigger as? UNCalendarNotificationTrigger
        #expect(trigger?.dateComponents.hour == 9)
        #expect(trigger?.dateComponents.minute == 30)
    }

    @Test("Cancel specific notifications by IDs")
    func cancel_specific_notifications() async {
        // GIVEN
        let mockCenter = MockNotificationCenter()
        let sut = DefaultLocalNotificationScheduler(notificationCenter: mockCenter)
        let ids = ["notif-1", "notif-2"]

        // WHEN
        await sut.cancel(ids: ids)

        // THEN
        #expect(mockCenter.removedIds.count == 2)
        #expect(mockCenter.removedIds.contains("notif-1"))
        #expect(mockCenter.removedIds.contains("notif-2"))
    }
}
