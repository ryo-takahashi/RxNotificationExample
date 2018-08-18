import UIKit
import RxSwift
import RxCocoa

class DisableNotificationCoverView: UIView {

    @IBOutlet weak var openNotificationSettingButton: UIButton!

    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func awakeFromNib() {
        openNotificationSettingButton.rx.tap
            .subscribe(onNext: { [weak self] in
                if let url = URL(string: UIApplicationOpenSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            })
            .disposed(by: disposeBag)
    }

    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib.init(nibName: "DisableNotificationCoverView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(view)
    }
}
