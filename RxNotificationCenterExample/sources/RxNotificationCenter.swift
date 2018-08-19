import RxSwift
import RxCocoa
import UserNotifications

class RxNotificationCenter {
    static let shared = RxNotificationCenter()

    let authorizationStatus = PublishRelay<UNAuthorizationStatus>()

    private init() {}

    func updateAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            self?.authorizationStatus.accept(settings.authorizationStatus)
        }
    }
}
