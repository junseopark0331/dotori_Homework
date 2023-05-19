import UIKit
import SnapKit
import Then

final class FinishPaymentViewController: UIViewController {
    
    private let finishPaymentView = UIView().then{
        $0.layer.cornerRadius = 55
        $0.clipsToBounds = true
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowColor = UIColor(rgb: 000000).cgColor
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
    }
    
    private let paymentCompleteImageView = UIImageView().then {
        $0.image = UIImage(named: "Check")
    }
    
    private let thankyouLabel = UILabel().then{
        $0.text = "이용해주셔서 감사합니다."
        $0.textColor = UIColor(rgb: 0x000000)
        $0.textAlignment = .center
        $0.font = .Vending(size: 40, family: .semiBold)
    }
    
    private let paymentCompleteLabel = UILabel().then{
        $0.text = "결제 완료"
        $0.textColor = UIColor(rgb: 0x13E10F)
        $0.textAlignment = .center
        $0.font = .Vending(size: 30, family: .semiBold)
    }
    
    private let goToMainButton = UIButton().then{
        $0.setTitle("메인으로", for: .normal)
        $0.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x4257EC)
        $0.titleLabel?.font = .Vending(size: 45, family: .semiBold)
        $0.layer.cornerRadius = 55
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(gotoMainButtonTapped), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(finishPaymentView)
        view.addSubview(paymentCompleteImageView)
        view.addSubview(thankyouLabel)
        view.addSubview(paymentCompleteLabel)
        view.addSubview(goToMainButton)

        setLayout()
    }
    
    
    func setLayout(){
        self.finishPaymentView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(96)
            $0.height.equalTo(1186)
            $0.leading.trailing.equalToSuperview().inset(86)
        }
        self.paymentCompleteImageView.snp.makeConstraints{
            $0.top.equalTo(finishPaymentView).offset(148)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(250)
        }
        self.thankyouLabel.snp.makeConstraints{
            $0.top.equalTo(paymentCompleteImageView.snp.bottom).offset(86)
            $0.centerX.equalToSuperview()
        }
        self.paymentCompleteLabel.snp.makeConstraints{
            $0.top.equalTo(thankyouLabel).offset(76)
            $0.centerX.equalToSuperview()
        }
        self.goToMainButton.snp.makeConstraints{
            $0.height.equalTo(117)
            $0.leading.trailing.equalToSuperview().inset(360)
            $0.bottom.equalToSuperview().inset(271)
        }
    }
    
    @objc func gotoMainButtonTapped(_ sender: UIButton){
        let vc = UINavigationController(rootViewController: StartViewController())
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
}

