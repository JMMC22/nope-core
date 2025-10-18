//
//  NotificationContent.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import UserNotifications

public struct NotificationContent {
    public let title: String
    public let body: String
    public let subtitle: String?
    public let badge: Int?
    public let sound: NotificationSound
    public let userInfo: [AnyHashable: Any]

    public init(
        title: String,
        body: String,
        subtitle: String? = nil,
        badge: Int? = nil,
        sound: NotificationSound = .default,
        userInfo: [AnyHashable: Any] = [:]
    ) {
        self.title = title
        self.body = body
        self.subtitle = subtitle
        self.badge = badge
        self.sound = sound
        self.userInfo = userInfo
    }
}
