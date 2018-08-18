import UIKit
import UserNotifications
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var disableNotificationCoverView: UIView!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "通知設定"
        setupViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RxNotificationCenter.shared.updateAuthorizationStatus()
    }

    private func setupViewController() {
        RxNotificationCenter.shared.authorizationStatus
            .map { status -> Bool in
                switch status {
                case .authorized:
                    return true
                case .denied, .notDetermined:
                    return false
                }
            }
            .bind(to: disableNotificationCoverView.rx.isHidden)
            .disposed(by: disposeBag)
        RxNotificationCenter.shared.updateAuthorizationStatus()
    }

}
