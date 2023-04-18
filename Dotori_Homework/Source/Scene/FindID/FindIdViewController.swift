import UIKit
import Then
import SnapKit

final class FindIdViewController: UIViewController{
    
    private let findIDLabel = UILabel().then{
        $0.text = "아이디 찾기"
        $0.textColor = UIColor(rgb: 0x999999)
        $0.font = .boldSystemFont(ofSize: 20)
    }
    private let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "closing"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(findIDLabel)
        view.addSubview(closeButton)
        setLayout()
        self.navigationController?.navigationBar.topItem?.title = "X"
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0x333333)
    }
    
    func setLayout(){
        self.findIDLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.view.snp.centerY)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        self.closeButton.snp.makeConstraints{
            $0.height.width.equalTo(28)
            $0.top.leading.equalTo(self.view).offset(32)
        }
    }

    // MARK: - <#title#>
    @objc func closeButtonTapped(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
}

