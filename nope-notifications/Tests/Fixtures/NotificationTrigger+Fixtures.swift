//
//  NotificationTrigger+Fixtures.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation
@testable import nope_notifications

extension NotificationTrigger {
    static func timeIntervalFixture(
        interval: TimeInterval = 60,
        repeats: Bool = false
    ) -> NotificationTrigger {
        .timeInterval(interval, repeats: repeats)
    }

    static func dateFixture(
        date: Date = Date().addingTimeInterval(3600),
        repeats: Bool = false
    ) -> NotificationTrigger {
        .date(date, repeats: repeats)
    }

    static func calendarFixture(
        hour: Int = 9,
        minute: Int = 0,
        repeats: Bool = true
    ) -> NotificationTrigger {
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        return .calendar(components, repeats: repeats)
    }
}
