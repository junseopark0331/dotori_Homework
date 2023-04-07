//
//  SignupViewController.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/03/29.
//

import UIKit
import Then
import SnapKit

final class NicknameSignupViewController: UIViewController{
    
    private let authHeaderView = AuthHeaderView().then{
        $0.mainLabel.text = "사용하실 닉네임을 입력해주세요"
    }
    
    private let additionalLabel = AdditonalLabel().then{
        $0.text = "닉네임은 최소 4자에서 최대 20자까지 가능합니다"
    }
    
    private let nicknameTextField = CustomTextField().then{
        $0.placeholder = "닉네임"
    }
    
    private let nextStepButton = NextStepButton().then{
        $0.setTitle("다음", for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        nicknameTextField.delegate = self
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0x333333)
        
        view.addSubview(authHeaderView)
        view.addSubview(additionalLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(nextStepButton)
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = UIColor(rgb: 0x333333)
            self.navigationItem.backBarButtonItem = backBarButtonItem
        setLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "회원가입"
    }
    
    @objc func nextButtonTapped(_ sender: UIButton){
        let vc = FinishSignupViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.nicknameTextField.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.top.equalTo(additionalLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.nextStepButton.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
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

