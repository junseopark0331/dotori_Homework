import UIKit
import SnapKit
import Then
import Alamofire

final class LoginViewController: UIViewController {
    
    private var id: String?
    private var password: String?
    
    private let authHeaderView = AuthHeaderView().then {
        $0.mainLabel.text = "더 편한 기숙사 생활을 위해"
    }
    
    private let idTextField = CustomTextField().then {
        $0.placeholder = "아이디"
    }
    
    private let passwordTextField = SecureButtonTextField().then {
        $0.placeholder = "비밀번호"
    }
    
    private lazy var loginButton = NextStepButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
    }
    
    private lazy var findIDButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        $0.addTarget(self, action: #selector(findIdButtonTapped), for: .touchUpInside)
    }
    
    private lazy var loginViewcontrollerView = UIView().then {
        $0.backgroundColor = UIColor(rgb: 0x999999)
    }
    
    private lazy var resetPasswordButton = UIButton().then {
        $0.setTitle("비밀번호 재설정", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        $0.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
    }
    
    private let notMemberLabel = UILabel().then {
        $0.text = "아직 회원이 아니신가요?"
        $0.textColor = UIColor(rgb: 0x999999)
        $0.font = .boldSystemFont(ofSize: 12)
    }
    
    private lazy var signinButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        $0.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        $0.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "로그인"
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x333333)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addSubview(authHeaderView)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(findIDButton)
        view.addSubview(loginViewcontrollerView)
        view.addSubview(resetPasswordButton)
        view.addSubview(notMemberLabel)
        view.addSubview(signinButton)
        view.addSubview(loginButton)
        setLayout()
    }
    
    func setLayout() {
        self.authHeaderView.snp.makeConstraints {
            $0.height.equalTo(82)
            $0.width.equalTo(380)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(self.view).inset(24)
        }
        self.idTextField.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(authHeaderView.snp.bottom).offset(54)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.passwordTextField.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(idTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.findIDButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24)
            $0.trailing.equalTo(self.view).inset(137)
        }
        self.loginViewcontrollerView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(13)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(32)
            $0.leading.equalTo(findIDButton.snp.trailing).offset(16)
        }
        self.resetPasswordButton.snp.makeConstraints {
            $0.top.equalTo(findIDButton.snp.top)
            $0.leading.equalTo(loginViewcontrollerView.snp.trailing).offset(16)
        }
        self.notMemberLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.view).inset(146)
            $0.leading.equalTo(self.view).offset(99)
        }
        self.signinButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view).inset(140)
            $0.leading.equalTo(notMemberLabel.snp.trailing).offset(8)
        }
        self.loginButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view).inset(58)
            $0.leading.trailing.equalTo(self.view).inset(24)
        }
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        login()
    }
    
    @objc func signupButtonTapped(_ sender: UIButton) {
        let vc = IdSignupViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func findIdButtonTapped(_ sender: UIButton) {
        let vc = FindIdViewController()
        self.present(vc, animated: true)
    }
    
    @objc func findPasswordButtonTapped(_ sender: UIButton) {
        let vc = FindPasswordViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let id = idTextField.text?.count,
           let password = passwordTextField.text?.count,
           id >= 1 && password >= 1
        {
            loginButton.backgroundColor = UIColor(rgb: 0x6F7AEC)
            loginButton.isEnabled = true
        }
        else{
            loginButton.backgroundColor = UIColor(rgb: 0xA9A9A9)
            loginButton.isEnabled = false
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

extension LoginViewController {
    
    // 서버 통신 코드를 실제로 뷰 컨트롤러에서 호출해서 사용하는 부분입니다.
    func login() {
        
        // 각각의 텍스트 필드의 있는 값을 받아옵니다.
        guard let id = idTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        // 서버 통신 서비스 코드를 싱글톤 변수를 통해서 접근하고 있네요.
        // 호출 후에 받은 응답을 가지고, 적절한 처리를 해주고 있습니다.
        Login.shared.login(
            id: id,
            password: password
        ){ response in
          switch response {

          case .success(let data):
              guard let data = data as? LoginResponse else { return }
              self.successLogin()
          case .requestErr:
              self.failLoginAlert()
          case .pathErr:
              return
          case .serverErr:
              return
          case .networkFail:
              return
          }
        }
    }
    
    func successLogin() {
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func failLoginAlert(){
        let alert = UIAlertController(
            title: "로그인 실패",
            message: "아이디와 비밀번호를 확인해주세요",
            preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(defaultAction)
        
        present(alert, animated: false, completion: nil)
    }
}


