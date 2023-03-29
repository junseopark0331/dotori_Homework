//
//  SignupViewController.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/03/29.
//

import UIKit
import Then
import SnapKit

final class SignupViewController: UIViewController{
    
    
    private let signupLabel = UILabel().then{
        $0.text = "회원가입"
        $0.textColor = UIColor(rgb: 0x999999)
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "회원가입"
        view.addSubview(signupLabel)
        setLayout()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0x333333)
    }
    
    func setLayout(){
        self.signupLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.view.snp.centerY)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
    }
    
}
