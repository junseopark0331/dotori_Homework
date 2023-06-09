import UIKit
import Then
import SnapKit

final class FinishSignupViewController: UIViewController {
    
    var id: String?
    var password: String?
    var nickname: String?
    
    private let finishLabel = UILabel().then {
        $0.text = "완료"
        $0.textColor = UIColor(rgb: 0x000000)
        $0.font = .boldSystemFont(ofSize: 32)
    }

    private let additionalLabel = UILabel().then {
        $0.text = "회원가입이 완료 되었습니다\n로그인을 이어서 진행해주세요!"
        $0.textColor = UIColor(rgb: 0x555555)
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 2
            $0.textAlignment = .center
    }

    private let goToLoginButton = NextStepButton().then {
        $0.setTitle("로그인하러가기", for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(gotoLoginButtonTapped), for: .touchUpInside)
        $0.backgroundColor = UIColor(rgb: 0x6F7AEC)
        $0.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "회원가입"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x333333)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        view.addSubview(finishLabel)
        view.addSubview(additionalLabel)
        view.addSubview(goToLoginButton)
        setLayout()
    }

    func setLayout() {
        self.finishLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(288)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        self.additionalLabel.snp.makeConstraints {
            $0.top.equalTo(finishLabel.snp.bottom).offset(32)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        self.goToLoginButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalTo(self.view).inset(24)
        }
    }

    @objc func gotoLoginButtonTapped(_ sender: UIButton) {
        sendIdPasswordNicknameToServer()
    }
}

extension FinishSignupViewController{
    
    func sendIdPasswordNicknameToServer() {
        
        Signup.signup.requestPOST(nickname: nickname ?? "", id: id ?? "", password: password ?? "") { result in
            switch result {
            case .success(let response):
                self.successToSignin()
            case .requestErr:
                return
            case .pathErr:
                return
            case .serverErr:
                return
            case .networkFail:
                return
            }
        }
    }
    
    func successToSignin(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
