//
//  UNNotificationRequest+Fixtures.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import UserNotifications

extension UNNotificationRequest {
    static func fixture(
        identifier: String = "test-un-request",
        title: String = "Test Title",
        body: String = "Test Body",
        trigger: UNNotificationTrigger? = nil
    ) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        return UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
    }

    static func timeIntervalFixture(
        identifier: String = "test-time-interval",
        interval: TimeInterval = 60,
        repeats: Bool = false
    ) -> UNNotificationRequest {
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: interval,
            repeats: repeats
        )
        return fixture(identifier: identifier, trigger: trigger)
    }
}
