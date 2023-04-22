import UIKit
import Then
import SnapKit

final class IdSignupViewController: UIViewController {
    
    var id: String?
    
    private let authHeaderView = AuthHeaderView().then {
        $0.mainLabel.text = "사용하실 아이디를 입력해주세요"
    }
    
    private let additionalLabel = AdditonalLabel().then {
        $0.text = "아이디는 최소 4자에서 최대 20자까지 가능합니다"
    }
    
    private let idTextField = CustomTextField().then {
        $0.placeholder = "아이디"
    }
    
    private lazy var nextStepButton = NextStepButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        view.backgroundColor = .white
        
        self.title = "회원가입"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x333333)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        view.addSubview(authHeaderView)
        view.addSubview(additionalLabel)
        view.addSubview(idTextField)
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
        self.idTextField.snp.makeConstraints {
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
        sendIdToServer()
    }
    
}

extension IdSignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let count = idTextField.text?.count, count >= 4 && count <= 20 {
            nextStepButton.backgroundColor = UIColor(rgb: 0x6F7AEC)
            nextStepButton.isEnabled = true
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
        guard textField.text!.count < 21 else { return false }
        return true
    }
    
}

extension IdSignupViewController{
    
    func sendIdToServer() {
        
        id = idTextField.text
        
        ValidId.validId.requestPOST(id: id ?? "") { result in
            switch result {
            case .success(let response):
                self.moveToPasswordViewController()
            case .requestErr:
                self.idConditionFailAlert()
            case .pathErr:
                self.sameIdAlert()
            case .serverErr:
                return
            case .networkFail:
                return
            }
        }
    }
    
    func idConditionFailAlert(){
        DispatchQueue.main.async{
            let alert = UIAlertController(
                title: "에러",
                message: "아이디가 조건에 맞지 않습니다",
                preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(defaultAction)
            
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func sameIdAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "아이디 중복",
                message: "아이디가 중복됩니다",
                preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(defaultAction)
            
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func moveToPasswordViewController(){
        DispatchQueue.main.async {
            let vc = PasswordSignupViewController()
            vc.id = self.id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
