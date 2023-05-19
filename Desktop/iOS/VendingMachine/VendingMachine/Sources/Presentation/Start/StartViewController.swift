import UIKit
import SnapKit
import Then

final class StartViewController: UIViewController {
    
    private let backgroundImageView = UIImageView().then{
        $0.image = UIImage(named: "Background.png")
    }
    
    private let mainLabel = UILabel().then{
        $0.text = "GSM\nBlockChain"
        $0.textColor = UIColor(rgb: 0xFFFFFF)
        $0.textAlignment = .left
        $0.numberOfLines = 2
        $0.font = .Vending(size: 110, family: .semiBold)
    }
    
    private lazy var menuButton = UIButton().then{
        $0.setTitle("MENU", for: .normal)
        $0.setTitleColor(UIColor(rgb: 0x171D4E), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0xFFFFFF)
        $0.titleLabel?.font = .Vending(size: 50, family: .medium)
        $0.layer.cornerRadius = 65
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    private let helpButton = UIButton().then{
        $0.setTitle("HELP", for: .normal)
        $0.setTitleColor(UIColor(rgb: 0x171D4E), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0xFFFFFF)
        $0.titleLabel?.font = .Vending(size: 50, family: .medium)
        $0.layer.cornerRadius = 65
        $0.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UINavigationController(rootViewController: StartViewController())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let backBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x777777)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        view.addSubview(backgroundImageView)
        view.addSubview(mainLabel)
        view.addSubview(menuButton)
        view.addSubview(helpButton)
        
        setLayout()
    
    }
    
    func setLayout(){
        self.backgroundImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        self.mainLabel.snp.makeConstraints{
            $0.top.equalTo(self.view).offset(381)
            $0.centerX.equalTo(view.snp.centerX)
        }
        self.menuButton.snp.makeConstraints{
            $0.height.equalTo(130)
            $0.top.equalTo(mainLabel.snp.bottom).offset(162)
            $0.leading.trailing.equalTo(self.view).inset(142)
        }
        self.helpButton.snp.makeConstraints{
            $0.height.equalTo(130)
            $0.top.equalTo(menuButton.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(self.view).inset(142)
        }
    }
    
    @objc func menuButtonTapped(_ sender: UIButton){
        let vc = SelectSnackViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
