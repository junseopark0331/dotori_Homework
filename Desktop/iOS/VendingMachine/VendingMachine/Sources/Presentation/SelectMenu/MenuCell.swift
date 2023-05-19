import UIKit
import SnapKit
import Then

protocol MenuCellDelegate: AnyObject {
    func snackDidTap(name: String, price: Int, menuImage: String, menuNumber: Int)
}

final class MenuCell: UICollectionViewCell {
    weak var delegate: MenuCellDelegate?
    
    static var menu: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    var snackImage: String? {didSet {bind() } }
    
    var menuName: String? { didSet { bind() } }
    
    var menuPrice: Int? { didSet { bind() } }
    
    var menuNumber: Int? { didSet { bind() } }
    
    lazy var snackButton = UIButton().then{
        $0.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    lazy var snackImageView = UIImageView().then{
        $0.clipsToBounds = true
    }
    
    lazy var menuTitleLabel = UILabel().then{
        $0.textAlignment = .center
        $0.font = .Vending(size: 26, family: .medium)
        $0.textColor = UIColor(rgb: 0x626CC3)
    }
    
    lazy var priceLabel = UILabel().then{
        $0.textAlignment = .center
        $0.font = .Vending(size: 26, family: .medium)
        $0.textColor = UIColor(rgb: 0x626CC3)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(snackImageView)
        addSubview(snackButton)
        addSubview(menuTitleLabel)
        addSubview(priceLabel)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setLayout() {
        self.snackButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        self.snackImageView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(240)
        }
        
        self.menuTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(priceLabel.snp.top)
        }
        
        self.priceLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    @objc func menuButtonTapped(_ sender: UIButton){
        delegate?.snackDidTap(name: menuName ?? "", price: menuPrice ?? 0, menuImage: snackImage ?? "", menuNumber: menuNumber ?? 0)
    }
    
    private func bind() {
        snackImageView.image = UIImage(named: snackImage!)
        menuTitleLabel.text = menuName
        priceLabel.text = menuPrice?.description
        
    }
    
}
