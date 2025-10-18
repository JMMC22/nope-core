//
//  NotificationRequest.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import UserNotifications

public struct NotificationRequest {
    public let id: String
    public let content: NotificationContent
    public let trigger: NotificationTrigger?

    public init(id: String, content: NotificationContent, trigger: NotificationTrigger? = nil) {
        self.id = id
        self.content = content
        self.trigger = trigger
    }
}

extension NotificationRequest {
    func toUNNotificationRequest() -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = self.content.title
        content.body = self.content.body

        if let subtitle = self.content.subtitle {
            content.subtitle = subtitle
        }

        if let badge = self.content.badge {
            content.badge = NSNumber(value: badge)
        }

        content.sound = self.content.sound.toUNSound()
        content.userInfo = self.content.userInfo

        let trigger = self.trigger?.toUNTrigger()

        return UNNotificationRequest(identifier: id, content: content, trigger: trigger)
    }
}

extension UNNotificationRequest {
    func toDomainRequest() -> NotificationRequest? {
        let content = NotificationContent(
            title: self.content.title,
            body: self.content.body,
            subtitle: self.content.subtitle.isEmpty ? nil : self.content.subtitle,
            badge: self.content.badge?.intValue,
            sound: self.content.sound?.toDomainSound() ?? .default,
            userInfo: self.content.userInfo
        )

        let trigger: NotificationTrigger?
        if let timeTrigger = self.trigger as? UNTimeIntervalNotificationTrigger {
            trigger = .timeInterval(timeTrigger.timeInterval, repeats: timeTrigger.repeats)
        } else if let calendarTrigger = self.trigger as? UNCalendarNotificationTrigger {
            trigger = .calendar(calendarTrigger.dateComponents, repeats: calendarTrigger.repeats)
        } else {
            trigger = nil
        }

        return NotificationRequest(id: identifier, content: content, trigger: trigger)
    }
}
