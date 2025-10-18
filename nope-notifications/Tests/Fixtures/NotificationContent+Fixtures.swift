//
//  NotificationContent+Fixtures.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_notifications

extension NotificationContent {
    static func fixture(
        title: String = "Test Title",
        body: String = "Test Body",
        subtitle: String? = nil,
        badge: Int? = nil,
        sound: NotificationSound = .default,
        userInfo: [AnyHashable: Any] = [:]
    ) -> NotificationContent {
        NotificationContent(
            title: title,
            body: body,
            subtitle: subtitle,
            badge: badge,
            sound: sound,
            userInfo: userInfo
        )
    }
}
