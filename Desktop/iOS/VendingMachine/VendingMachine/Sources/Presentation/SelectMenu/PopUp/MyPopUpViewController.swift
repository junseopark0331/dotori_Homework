import UIKit
import SnapKit
import Then

final class MyPopupViewController: UIViewController {
    
    private var menuPrice: Int?
    private var menuName: String?
    private var menuImageName: String?
    private var menuNumber: Int
    
    private var menuQuantity = 1
    private var totalPrice: Int?
    
    private lazy var popupView = UIView().then {
        $0.backgroundColor = UIColor(rgb: 0xFFFFFF)
        $0.layer.borderColor = UIColor(rgb: 0x00000).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 55
    }
    
    private lazy var closeSelectedMenuViewButton = UIButton().then{
        $0.setImage(UIImage(named: "X"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private lazy var selectQuantityLabel = UILabel().then {
        $0.text = "수량선택"
        $0.textColor = UIColor(rgb: 0x000000)
        $0.font = .Vending(size: 40, family: .bold)
    }
    
    private lazy var menuImage = UIImageView()
    
    private lazy var menuNameLabel = UILabel().then{
        $0.textAlignment = .center
        $0.textColor = UIColor(rgb: 0x4257EC)
        $0.font = .Vending(size: 40, family: .bold)
    }
    
    private lazy var quantityView = UIView().then{
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowColor = UIColor(rgb: 000000).cgColor
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
    }
    
    private lazy var totalPriceView = UIView().then{
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(rgb: 0x4257EC)
    }
    
    private lazy var totalPriceLabel = UILabel().then{
        $0.textColor = UIColor(rgb: 0xFFFFFF)
        $0.font = .Vending(size: 23, family: .bold)
    }
    
    private lazy var plusButton = UIButton().then{
        $0.setImage(UIImage(named: "Plus"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    private lazy var totalQuantityLabel = UILabel().then{
        $0.text = "1"
        $0.textColor = UIColor(rgb: 0x4257EC)
        $0.font = .Vending(size: 30, family: .medium)
    }
    
    private lazy var minusButton = UIButton().then{
        $0.setImage(UIImage(named: "Minus"), for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    private lazy var paymentButton = UIButton().then{
        $0.setTitle("결제하기", for: .normal)
        $0.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x4257EC)
        $0.titleLabel?.font = .Vending(size: 30, family: .bold)
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.addSubview(self.popupView)
        view.addSubview(paymentButton)
        
        let backBarButtonItem = UIBarButtonItem(title: "전 화면으로", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x777777)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        print(menuImage)
        
        totalPrice = (menuPrice ?? 0) * menuQuantity
        totalPriceLabel.text = "₩ " + String(totalPrice ?? 0)
        menuImage.image = UIImage(named: self.menuImageName ?? "")
        menuNameLabel.text = menuName
        
        setupView()
        setLayout()
    }
    
    func setupView(){
        [self.closeSelectedMenuViewButton,
         self.closeSelectedMenuViewButton,
         self.selectQuantityLabel,
         self.menuImage,
         self.menuNameLabel,
         self.totalPriceView,
         self.totalPriceLabel,
         self.quantityView,
         self.minusButton,
         self.totalQuantityLabel,
         self.plusButton,
         self.paymentButton
        ].forEach(self.popupView.addSubview(_:))
    }
    
    func setLayout(){
        self.popupView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(440)
            $0.leading.trailing.equalToSuperview().inset(204)
            $0.bottom.equalToSuperview().inset(254)
        }
        self.closeSelectedMenuViewButton.snp.makeConstraints{
            $0.height.equalTo(46)
            $0.top.equalToSuperview().offset(42)
            $0.trailing.equalToSuperview().inset(40)
        }
        self.selectQuantityLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(34)
            $0.centerX.equalToSuperview()
        }
        self.menuImage.snp.makeConstraints{
            $0.height.equalTo(237)
            $0.width.equalTo(193)
            $0.top.equalToSuperview().offset(152)
            $0.leading.equalToSuperview().offset(80)
        }
        self.menuNameLabel.snp.makeConstraints{
            $0.top.equalTo(selectQuantityLabel.snp.bottom).offset(108)
            $0.centerX.equalTo(totalQuantityLabel)
        }
        self.totalPriceView.snp.makeConstraints{
            $0.height.equalTo(51)
            $0.top.equalTo(menuImage.snp.bottom)
            $0.leading.equalToSuperview().offset(91)
            $0.trailing.equalToSuperview().inset(372)
        }
        self.totalPriceLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(400)
            $0.centerX.equalTo(totalPriceView)
        }
        self.quantityView.snp.makeConstraints{
            $0.top.equalTo(menuNameLabel.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(289)
            $0.trailing.equalToSuperview().inset(134)
            $0.height.equalTo(60)
        }
        self.minusButton.snp.makeConstraints{
            $0.height.width.equalTo(32)
            $0.top.equalTo(quantityView.snp.top).offset(12)
            $0.leading.equalTo(quantityView.snp.leading).offset(12)
        }
        self.totalQuantityLabel.snp.makeConstraints{
            $0.top.equalTo(quantityView.snp.top).offset(12)
            $0.centerX.equalTo(quantityView)
        }
        self.plusButton.snp.makeConstraints{
            $0.height.width.equalTo(32)
            $0.top.equalTo(quantityView.snp.top).offset(12)
            $0.trailing.equalTo(quantityView.snp.trailing).inset(12)
        }
        self.paymentButton.snp.makeConstraints{
            $0.height.equalTo(80)
            $0.width.equalTo(270)
            $0.bottom.equalToSuperview().inset(82)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func plusButtonTapped(_ sender: UIButton){
        menuQuantity = menuQuantity + 1
        totalQuantityLabel.text = String(menuQuantity)
        totalPrice = (menuPrice ?? 0) * menuQuantity
        totalPriceLabel.text = "₩ " + String(totalPrice!)
       
    }
    
    @objc func minusButtonTapped(_ sender: UIButton){
        if menuQuantity > 0 {
            menuQuantity = menuQuantity - 1
            totalQuantityLabel.text = String(menuQuantity)
            totalPrice = (menuPrice ?? 0) * menuQuantity
            totalPriceLabel.text = "₩ " + String(totalPrice!)
        }
    
    }
    
    @objc func backButtonTapped(_ sender: UIButton){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    init(menuName: String, menuPrice: Int, menuImage: String, menuNumber: Int) {
        self.menuName = menuName
        self.menuPrice = menuPrice
        self.menuImageName = menuImage
        self.menuNumber = menuNumber
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func paymentButtonTapped(_ sender: UIButton){
        let vc = PaymentViewController()
        vc.menuName = self.menuName ?? ""
        vc.totalPrice = self.totalPrice ?? 0
        vc.totalQuantity = self.menuQuantity
        vc.menuNumber = self.menuNumber
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
