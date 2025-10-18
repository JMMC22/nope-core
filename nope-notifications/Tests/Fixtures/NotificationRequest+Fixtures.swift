//
//  NotificationRequest+Fixtures.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_notifications

extension NotificationRequest {
    static func fixture(
        id: String = "test-notification-id",
        content: NotificationContent = .fixture(),
        trigger: NotificationTrigger? = nil
    ) -> NotificationRequest {
        NotificationRequest(
            id: id,
            content: content,
            trigger: trigger
        )
    }
}
