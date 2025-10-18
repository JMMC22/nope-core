//
//  NotificationCenterProtocol.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import UserNotifications

/// Protocol wrapper for UNUserNotificationCenter to enable testing
public protocol NotificationCenterProtocol {
    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool
    func notificationSettings() async -> UNNotificationSettings
    func add(_ request: UNNotificationRequest) async throws
    func pendingNotificationRequests() async -> [UNNotificationRequest]
    func removePendingNotificationRequests(withIdentifiers: [String])
    func removeAllPendingNotificationRequests()
    func deliveredNotifications() async -> [UNNotification]
    func removeDeliveredNotifications(withIdentifiers: [String])
    func removeAllDeliveredNotifications()
}
