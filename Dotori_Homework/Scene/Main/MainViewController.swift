//
//  MainViewController.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/03/29.
//

import UIKit
import Then
import SnapKit

final class MainViewController: UIViewController{
    
    private let mainLabel = UILabel().then{
        $0.text = "메인"
        $0.textColor = UIColor(rgb: 0x999999)
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "메인"
        view.addSubview(mainLabel)
        setLayout()
    }
    
    func setLayout(){
        self.mainLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
}
