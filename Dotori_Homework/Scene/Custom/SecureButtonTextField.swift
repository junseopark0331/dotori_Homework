//
//  textFieldSecureButton.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/04/04.
//

import UIKit
import Then
import SnapKit

public final class SecureButtonTextField: UITextField{
    
    var passwordEyeButton = UIButton().then{
        $0.setImage(UIImage(named: "password hidden eye icon"), for: .normal)
        $0.addTarget(self, action: #selector(passwordEyeButtonTapped), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setLayout()
    }
    
    func setupView(){
        borderStyle = .roundedRect
        layer.cornerRadius = 8
        layer.borderColor = UIColor(rgb: 0x000000).cgColor
        layer.borderWidth = 1
        
        isSecureTextEntry.toggle()
        addSubview(passwordEyeButton)
    }
    
    func setLayout(){
        self.passwordEyeButton.snp.makeConstraints{
            $0.height.equalTo(12)
            $0.width.equalTo(20)
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    @objc func passwordEyeButtonTapped(_ sender: UIButton){
        print("20")
        passwordEyeButton.isSelected.toggle()
        let eyeImage = passwordEyeButton.isSelected ? "password shown eye icon" : "password hidden eye icon"
        passwordEyeButton.setImage(UIImage(named: eyeImage), for: .normal)
    }
    
}

