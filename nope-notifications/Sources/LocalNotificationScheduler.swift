//
//  LocalNotificationScheduler.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

public protocol LocalNotificationScheduler {
    func schedule(_ request: NotificationRequest) async throws
    func getPending() async -> [NotificationRequest]
    func cancel(ids: [String]) async
    func cancelAll() async
}

public final class DefaultLocalNotificationScheduler: LocalNotificationScheduler {
    private let notificationCenter: NotificationCenterProtocol

    public init(notificationCenter: NotificationCenterProtocol? = nil) {
        self.notificationCenter = notificationCenter ?? UNUserNotificationCenterAdapter()
    }

    public func schedule(_ request: NotificationRequest) async throws {
        let unRequest = request.toUNNotificationRequest()
        try await notificationCenter.add(unRequest)
    }

    public func getPending() async -> [NotificationRequest] {
        let requests = await notificationCenter.pendingNotificationRequests()
        return requests.compactMap { $0.toDomainRequest() }
    }

    public func cancel(ids: [String]) async {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ids)
    }

    public func cancelAll() async {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
