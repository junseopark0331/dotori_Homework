//
//  FindPasswordViewController.swift
//  Dotori_Homework
//
//  Created by 박준서 on 2023/03/29.
//


import UIKit
import Then
import SnapKit

final class FindPasswordViewController: UIViewController{
    
    private let findPasswordLabel = UILabel().then{
        $0.text = "비밀번호 찾기"
        $0.textColor = UIColor(rgb: 0x999999)
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "closing"), for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(findPasswordLabel)
        view.addSubview(closeButton)
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: 0x000000)
        setLayout()
    }
    
    func setLayout(){
        self.findPasswordLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.view.snp.centerY)
            $0.centerX.equalTo(self.view.snp.centerX)
        }
        self.closeButton.snp.makeConstraints{
            $0.height.width.equalTo(28)
            $0.top.equalTo(self.view).offset(79)
            $0.leading.equalTo(self.view).offset(32)
        }
    }
    @objc func closeButtonTapped(_ sender: UIButton){
        self.presentingViewController?.dismiss(animated: true)
    }
}
