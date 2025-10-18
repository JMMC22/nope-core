//
//  NotificationTrigger.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
import UserNotifications

public enum NotificationTrigger {
    case timeInterval(TimeInterval, repeats: Bool)
    case date(Date, repeats: Bool)
    case calendar(DateComponents, repeats: Bool)
}

extension NotificationTrigger {
    func toUNTrigger() -> UNNotificationTrigger? {
        switch self {
        case .timeInterval(let interval, let repeats):
            return UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
        case .date(let date, let repeats):
            let components = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: date
            )
            return UNCalendarNotificationTrigger(dateMatching: components, repeats: repeats)
        case .calendar(let components, let repeats):
            return UNCalendarNotificationTrigger(dateMatching: components, repeats: repeats)
        }
    }
}
