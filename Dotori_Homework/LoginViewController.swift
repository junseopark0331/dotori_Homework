//
//  ViewController.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/03/27.
//

import UIKit
import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    private let dotori_Image = UIImageView().then{
        $0.image = UIImage(named: "도토리")
    }
    
    private let titleLabel = UILabel().then{
        $0.text = "Dotori"
        $0.textColor = UIColor(rgb: 0x000000)
        $0.font = .boldSystemFont(ofSize: 32)
    }
    
    private let welcomeLabel = UILabel().then{
        $0.text = "더 편한 기숙사 생활을 위해"
        $0.textColor = UIColor(rgb: 0x555555)
        $0.font = .boldSystemFont(ofSize: 16)
    }
    
    private let idTextField = UITextField().then{
        $0.placeholder = "아이디"
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor(rgb: 0x000000).cgColor
        $0.layer.borderWidth = 1
    }
    
    private let passwordTextField = UITextField().then{
        $0.isSecureTextEntry = true
        $0.placeholder = "비밀번호"
        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor(rgb: 0x000000).cgColor
        $0.layer.borderWidth = 1
    }
    
    private let passwordEyeButton = UIButton().then{
        $0.setImage(UIImage(named: "password hidden eye icon"), for: .normal)
        $0.addTarget(self, action: #selector(passwordEyeButtonTapped), for: .touchUpInside)
    }
    
    private let findIDButton = UIButton().then{
        $0.setTitle("아이디 찾기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        $0.addTarget(self, action: #selector(findIdButtonTapped), for: .touchUpInside)
    }
    
    private lazy var loginViewcontrollerView = UIView().then{
        $0.backgroundColor = UIColor(rgb: 0x999999)
    }
    
    private let resetPasswordButton = UIButton().then{
        $0.setTitle("비밀번호 재설정", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(UIColor(rgb: 0x999999), for: .normal)
        $0.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
    }
    
    private let notMemberLabel = UILabel().then{
        $0.text = "아직 회원이 아니신가요?"
        $0.textColor = UIColor(rgb: 0x999999)
        $0.font = .boldSystemFont(ofSize: 12)
    }
    
    private let signinButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        $0.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        $0.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    private let loginButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x6F7AEC)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "로그인"
        
        view.addSubview(dotori_Image)
        view.addSubview(titleLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordEyeButton)
        view.addSubview(findIDButton)
        view.addSubview(loginViewcontrollerView)
        view.addSubview(resetPasswordButton)
        view.addSubview(notMemberLabel)
        view.addSubview(signinButton)
        view.addSubview(loginButton)
        setLayout()
        
    }
    
    func setLayout(){
        self.dotori_Image.snp.makeConstraints{
            $0.height.equalTo(48)
            $0.width.equalTo(48)
            $0.top.equalTo(self.view).offset(121)
            $0.leading.equalTo(self.view).offset(24)
        }
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.view).offset(131)
            $0.leading.equalTo(self.view).offset(80)
        }
        self.welcomeLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(dotori_Image.snp.leading)
        }
        self.idTextField.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(54)
            $0.leading.trailing.equalTo(self.view).inset(24)
            
        }
        self.passwordTextField.snp.makeConstraints{
            $0.height.equalTo(idTextField.snp.height)
            $0.top.equalTo(idTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(self.view).inset(24)
        }
        self.passwordEyeButton.snp.makeConstraints{
            $0.height.width.equalTo(24)
            $0.top.equalTo(passwordTextField.snp.top).offset(14)
            $0.trailing.equalTo(passwordTextField.snp.trailing).inset(12)
        }
        self.findIDButton.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24)
            $0.trailing.equalTo(self.view).inset(137)
        }
        self.loginViewcontrollerView.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(13)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(32)
            $0.leading.equalTo(findIDButton.snp.trailing).offset(16)
        }
        self.resetPasswordButton.snp.makeConstraints{
            $0.top.equalTo(findIDButton.snp.top)
            $0.leading.equalTo(loginViewcontrollerView.snp.trailing).offset(16)
        }
        self.notMemberLabel.snp.makeConstraints{
            $0.bottom.equalTo(self.view).inset(146)
            $0.leading.equalTo(self.view).offset(99)
        }
        self.signinButton.snp.makeConstraints{
            $0.bottom.equalTo(self.view).inset(140)
            $0.leading.equalTo(notMemberLabel.snp.trailing).offset(8)
        }
        self.loginButton.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view).inset(58)
            $0.leading.trailing.equalTo(self.view).inset(24)
        }
    }
    
    @objc func passwordEyeButtonTapped(_ sender: UIButton){
        passwordTextField.isSecureTextEntry.toggle()
        passwordEyeButton.isSelected.toggle()
        let eyeImage = passwordEyeButton.isSelected ? "password shown eye icon" : "password hidden eye icon"
        passwordEyeButton.setImage(UIImage(named: eyeImage), for: .normal)
    }
    
    @objc func loginButtonTapped(_ sender: UIButton){
        let mainVC = MainViewController()
        self.navigationController?.setViewControllers([mainVC], animated: true)
    }
    
    @objc func signupButtonTapped(_ sender: UIButton){
        let vc = SignupViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func findIdButtonTapped(_ sender: UIButton){
        let vc = FindIdViewController()
        self.present(vc, animated: true)
    }
    
    @objc func findPasswordButtonTapped(_ sender: UIButton){
        let vc = FindPasswordViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
   
}


