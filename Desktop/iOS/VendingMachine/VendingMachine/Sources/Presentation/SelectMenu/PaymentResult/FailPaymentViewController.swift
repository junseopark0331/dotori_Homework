import UIKit
import SnapKit
import Then

final class FailPaymentViewController: UIViewController {
    
    private let failPaymentView = UIView().then{
        $0.layer.cornerRadius = 55
        $0.clipsToBounds = true
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowColor = UIColor(rgb: 000000).cgColor
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
    }
    
    private let paymentFailImageView = UIImageView().then {
        $0.image = UIImage(named: "Fail")
    }
    
    private let confirmPaymentLabel = UILabel().then{
        $0.text = "결제를 다시 시도해주세요."
        $0.textColor = UIColor(rgb: 0x000000)
        $0.textAlignment = .center
        $0.font = .Vending(size: 40, family: .semiBold)
    }
    
    private let paymentFailLabel = UILabel().then{
        $0.text = "결제 실패"
        $0.textColor = UIColor(rgb: 0xEC4242)
        $0.textAlignment = .center
        $0.font = .Vending(size: 30, family: .semiBold)
    }
    
    private let goToQRCodeScanButton = UIButton().then{
        $0.setTitle("QR코드 화면으로", for: .normal)
        $0.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x4257EC)
        $0.titleLabel?.font = .Vending(size: 40, family: .semiBold)
        $0.layer.cornerRadius = 55
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(failPaymentView)
        view.addSubview(paymentFailImageView)
        view.addSubview(confirmPaymentLabel)
        view.addSubview(paymentFailLabel)
        view.addSubview(goToQRCodeScanButton)

        setLayout()
    }
    
    
    func setLayout(){
        self.failPaymentView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(96)
            $0.height.equalTo(1186)
            $0.leading.trailing.equalToSuperview().inset(86)
        }
        self.paymentFailImageView.snp.makeConstraints{
            $0.top.equalTo(failPaymentView).offset(148)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(250)
        }
        self.confirmPaymentLabel.snp.makeConstraints{
            $0.top.equalTo(paymentFailImageView.snp.bottom).offset(86)
            $0.centerX.equalToSuperview()
        }
        self.paymentFailLabel.snp.makeConstraints{
            $0.top.equalTo(confirmPaymentLabel).offset(76)
            $0.centerX.equalToSuperview()
        }
        self.goToQRCodeScanButton.snp.makeConstraints{
            $0.height.equalTo(117)
            $0.leading.trailing.equalToSuperview().inset(300)
            $0.bottom.equalToSuperview().inset(271)
        }
    }
    
}


