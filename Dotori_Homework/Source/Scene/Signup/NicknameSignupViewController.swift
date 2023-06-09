import UIKit
import Then
import SnapKit

final class NicknameSignupViewController: UIViewController {
    
    var id: String?
    var password: String?
    var nickname: String?
    
    private let authHeaderView = AuthHeaderView().then {
        $0.mainLabel.text = "사용하실 닉네임을 입력해주세요"
    }

    private let additionalLabel = AdditonalLabel().then {
        $0.text = "닉네임은 최소 4자에서 최대 20자까지 가능합니다"
    }

    private let nicknameTextField = CustomTextField().then {
        $0.placeholder = "닉네임"
    }

    private let nextStepButton = NextStepButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        nicknameTextField.delegate = self
        view.backgroundColor = .white
        
        self.title = "회원가입"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x333333)
        navigationItem.backBarButtonItem = backBarButtonItem

        view.addSubview(authHeaderView)
        view.addSubview(additionalLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(nextStepButton)
 
        setLayout()
        
    }

    func setLayout() {
        self.authHeaderView.snp.makeConstraints {
            $0.height.equalTo(82)
            $0.width.equalTo(380)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(self.view).offset(24)
        }
        self.additionalLabel.snp.makeConstraints {
            $0.top.equalTo(authHeaderView.snp.bottom).offset(28)
            $0.leading.equalTo(authHeaderView.snp.leading)
        }
        self.nicknameTextField.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(additionalLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.nextStepButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        sendNicknameToServer()
    }
    
}

extension NicknameSignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let count = nicknameTextField.text?.count, count >= 4 && count <= 20 {
            nextStepButton.backgroundColor = UIColor(rgb: 0x6F7AEC)
            nextStepButton.isEnabled = true
        } else {
            nextStepButton.backgroundColor = UIColor(rgb: 0xA9A9A9)
            nextStepButton.isEnabled = false
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 21 else { return false }
        return true
    }
}

extension NicknameSignupViewController{
    
    func sendNicknameToServer() {
    
       nickname = nicknameTextField.text
        
        ValidNickname.validNickname.requestPOST(nickname: nickname ?? "") { result in
            switch result {
            case .success(let response):
                self.moveToFinishSignupViewController()
            case .requestErr:
                self.nicknameConditionFailAlert()
            case .pathErr:
                self.sameNicknameAlert()
            case .serverErr:
                return
            case .networkFail:
                return
            }
        }
    }
    
    func moveToFinishSignupViewController(){
        DispatchQueue.main.async {
            let vc = FinishSignupViewController()
            vc.id = self.id
            vc.password = self.password
            vc.nickname = self.nickname
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func nicknameConditionFailAlert(){
        DispatchQueue.main.async{
            let alert = UIAlertController(
                title: "에러",
                message: "닉네임이 조건에 맞지 않습니다",
                preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(defaultAction)
            
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func sameNicknameAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "닉네임 중복",
                message: "닉네임이 중복됩니다",
                preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(defaultAction)
            
            self.present(alert, animated: false, completion: nil)
        }
    }
}
