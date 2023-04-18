import UIKit
import SnapKit
import Then


public final class NextStepButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        backgroundColor = UIColor(rgb: 0xA9A9A9)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal)
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
