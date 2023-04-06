//
//  SignupViewController.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/03/29.
//

import UIKit
import Then
import SnapKit

final class PasswordSignupViewController: UIViewController{
    
    private let authHeaderView = AuthHeaderView().then{
        $0.mainLabel.text = "사용하실 비밀번호를 입력해주세요"
    }
    
    private let additionalLabel = AdditonalLabel().then{
        $0.text = "비밀번호는 최소 8자에서 최대 40자까지 가능합니다"
    }
    
    private let passwordTextField = SecureButtonTextField().then{
        $0.placeholder = "비밀번호"
    }
    
    private let passwordAgainTextField = SecureButtonTextField().then{
        $0.placeholder = "비밀번호 재입력"
    }
    
    private let nextStepButton = NextStepButton().then{
        $0.setTitle("다음", for: .normal)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0x333333)
        
        view.addSubview(authHeaderView)
        view.addSubview(additionalLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordAgainTextField)
        view.addSubview(nextStepButton)
        setLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "회원가입"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    func setLayout(){
        self.authHeaderView.snp.makeConstraints{
            $0.height.equalTo(82)
            $0.width.equalTo(380)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(self.view).offset(24)
        }
        self.additionalLabel.snp.makeConstraints{
            $0.top.equalTo(authHeaderView.snp.bottom).offset(28)
            $0.leading.equalTo(authHeaderView.snp.leading)
        }
        self.passwordTextField.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.top.equalTo(additionalLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.passwordAgainTextField.snp.makeConstraints{
            $0.height.equalTo(passwordTextField.snp.height)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(28)
            $0.leading.equalTo(passwordTextField)
            $0.trailing.equalTo(passwordTextField)
        }
        self.nextStepButton.snp.makeConstraints{
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let count = passwordTextField.text?.count, count >= 8 && count <= 40 {
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
        
        guard textField.text!.count < 41 else { return false }
        return true
    }
}

