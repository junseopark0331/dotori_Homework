//
//  authHeader.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/04/04.
//

import UIKit
import Then
import SnapKit

public final class AuthHeaderView: UIView{
    
    var dotori_Image = UIImageView().then{
        $0.image = UIImage(named: "dotori")
    }

    var titleLabel = UILabel().then{
        $0.text = "Dotori"
        $0.textColor = UIColor(rgb: 0x000000)
        $0.font = .boldSystemFont(ofSize: 32)
    }

    var mainLabel = UILabel().then{
        $0.textColor = UIColor(rgb: 0x555555)
        $0.font = .systemFont(ofSize: 16)
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
        backgroundColor = UIColor(rgb: 0xFFFFFF)
        addSubview(dotori_Image)
        addSubview(titleLabel)
        addSubview(mainLabel)
    }
    
    func setLayout(){
        self.dotori_Image.snp.makeConstraints{
            $0.height.width.equalTo(48)
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalTo(dotori_Image.snp.trailing).offset(8)
        }
        self.mainLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(dotori_Image.snp.leading)
        }
    }
    
}

