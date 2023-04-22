import UIKit
import Then
import SnapKit

final class PasswordSignupViewController: UIViewController {
    
    var id: String?
    var password: String?
    
    
    private let authHeaderView = AuthHeaderView().then {
        $0.mainLabel.text = "사용하실 비밀번호를 입력해주세요"
    }
    
    private let additionalLabel = AdditonalLabel().then {
        $0.text = "비밀번호는 최소 8자에서 최대 40자까지 가능합니다"
    }
    
    private let passwordTextField = SecureButtonTextField().then {
        $0.placeholder = "비밀번호"
    }
    
    private let passwordAgainTextField = SecureButtonTextField().then {
        $0.placeholder = "비밀번호 재입력"
    }
    
    private let nextStepButton = NextStepButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        
        self.title = "회원가입"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x333333)
        navigationItem.backBarButtonItem = backBarButtonItem

        
        view.addSubview(authHeaderView)
        view.addSubview(additionalLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordAgainTextField)
        view.addSubview(nextStepButton)
        
        setLayout()
        
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        let vc = NicknameSignupViewController()
        vc.id = self.id
        vc.password = self.password
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.passwordTextField.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(additionalLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.passwordAgainTextField.snp.makeConstraints {
            $0.height.equalTo(passwordTextField.snp.height)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.nextStepButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

extension PasswordSignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let passwordCount = passwordTextField.text?.count,
            let passwordAgainCount = passwordAgainTextField.text?.count,
            passwordCount >= 8 && passwordCount <= 40 && passwordAgainCount >= 8 && passwordAgainCount <= 40{
            if passwordTextField.text == passwordAgainTextField.text{
                nextStepButton.backgroundColor = UIColor(rgb: 0x6F7AEC)
                nextStepButton.isEnabled = true
                
                password = passwordTextField.text
            }
        }
        else{
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
        guard textField.text!.count < 41 else { return false }
        return true
    }
}


