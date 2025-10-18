//
//  NotificationSound.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import UserNotifications

public enum NotificationSound: Equatable {
    case `default`
    case named(String)
    case none
}

extension NotificationSound {
    func toUNSound() -> UNNotificationSound? {
        switch self {
        case .default:
            return .default
        case .named(let name):
            return UNNotificationSound(named: UNNotificationSoundName(rawValue: name))
        case .none:
            return nil
        }
    }
}

extension UNNotificationSound {
    func toDomainSound() -> NotificationSound {
        if self == .default {
            return .default
        }
        return .default
    }
}
