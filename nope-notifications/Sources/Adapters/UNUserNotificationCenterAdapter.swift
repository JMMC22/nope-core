//
//  UNUserNotificationCenterAdapter.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import UserNotifications

final class UNUserNotificationCenterAdapter: NotificationCenterProtocol {
    private let center: UNUserNotificationCenter

    init(center: UNUserNotificationCenter = .current()) {
        self.center = center
    }

    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
        try await center.requestAuthorization(options: options)
    }

    func notificationSettings() async -> UNNotificationSettings {
        await center.notificationSettings()
    }

    func add(_ request: UNNotificationRequest) async throws {
        try await center.add(request)
    }

    func pendingNotificationRequests() async -> [UNNotificationRequest] {
        await center.pendingNotificationRequests()
    }

    func removePendingNotificationRequests(withIdentifiers identifiers: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    func removeAllPendingNotificationRequests() {
        center.removeAllPendingNotificationRequests()
    }

    func deliveredNotifications() async -> [UNNotification] {
        await center.deliveredNotifications()
    }

    func removeDeliveredNotifications(withIdentifiers identifiers: [String]) {
        center.removeDeliveredNotifications(withIdentifiers: identifiers)
    }

    func removeAllDeliveredNotifications() {
        center.removeAllDeliveredNotifications()
    }
}
