//
//  MockNotificationCenter.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

@testable import nope_notifications

import UserNotifications

final class MockNotificationCenter: NotificationCenterProtocol {
    var authorizationResult: Result<Bool, Error> = .success(true)
    var authorizationStatus: UNAuthorizationStatus = .authorized
    var pendingRequests: [UNNotificationRequest] = []
    var deliveredNotifications: [UNNotification] = []
    var addedRequests: [UNNotificationRequest] = []
    var removedIds: [String] = []
    var didRemoveAll = false

    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
        try authorizationResult.get()
    }

    func notificationSettings() async -> UNNotificationSettings {
        fatalError("notificationSettings() not implemented in mock - not needed for current tests")
    }

    func add(_ request: UNNotificationRequest) async throws {
        addedRequests.append(request)
        pendingRequests.append(request)
    }

    func pendingNotificationRequests() async -> [UNNotificationRequest] {
        pendingRequests
    }

    func removePendingNotificationRequests(withIdentifiers identifiers: [String]) {
        removedIds.append(contentsOf: identifiers)
        pendingRequests.removeAll { identifiers.contains($0.identifier) }
    }

    func removeAllPendingNotificationRequests() {
        didRemoveAll = true
        pendingRequests.removeAll()
    }

    func deliveredNotifications() async -> [UNNotification] {
        deliveredNotifications
    }

    func removeDeliveredNotifications(withIdentifiers identifiers: [String]) {
        // Mock implementation
    }

    func removeAllDeliveredNotifications() {
        deliveredNotifications.removeAll()
    }
}
