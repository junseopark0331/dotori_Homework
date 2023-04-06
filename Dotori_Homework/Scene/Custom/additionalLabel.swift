//
//  additionalLabel.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/04/04.
//

import UIKit

public final class AdditonalLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        textColor = UIColor(rgb: 0x555555)
        font = .systemFont(ofSize: 12)
    }
    
}
