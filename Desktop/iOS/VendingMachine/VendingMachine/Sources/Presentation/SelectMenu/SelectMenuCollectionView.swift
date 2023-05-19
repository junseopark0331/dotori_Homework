import UIKit
import SnapKit
import Then

final class SelectSnackViewController: UIViewController {
    
    var menu: [MenuEntity] = [
        MenuEntity(menuImage: "랜덤", menuName: "랜덤1", menuPrice: 1500, menuNumber: 1),
        MenuEntity(menuImage: "랜덤", menuName: "랜덤4", menuPrice: 1500, menuNumber: 4),
        MenuEntity(menuImage: "랜덤", menuName: "랜덤2", menuPrice: 1500, menuNumber: 2),
        MenuEntity(menuImage: "빼빼로", menuName: "빼빼로", menuPrice: 1500, menuNumber: 5),
        MenuEntity(menuImage: "랜덤", menuName: "랜덤3", menuPrice: 1500, menuNumber: 3),
        MenuEntity(menuImage: "웨하스", menuName: "웨하스", menuPrice: 1500, menuNumber: 6)
    ]
    
    private let selectMenuView = UIView().then{
        $0.layer.cornerRadius = 65
        $0.clipsToBounds = true
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowColor = UIColor(rgb: 000000).cgColor
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
    }
    
    private let menuButton = UIButton().then{
        $0.setTitle("메뉴", for: .normal)
        $0.setTitleColor(UIColor(rgb: 0x000000), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0xFFFFFF)
        $0.titleLabel?.font = .Vending(size: 35, family: .medium)
    }
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .white
        return view
    }()
    
    private let flowLayout = UICollectionViewFlowLayout().then{
        $0.itemSize = CGSize(width: 226, height: 355)
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 40
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(selectMenuView)
        view.addSubview(menuButton)
        view.addSubview(collectionView)
        
        let backBarButtonItem = UIBarButtonItem(title: "전 화면으로", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x777777)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.menu)
        self.collectionView.collectionViewLayout = flowLayout
        
        setLayout()
        
    }
    
    func setLayout(){
        self.selectMenuView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(176)
            $0.bottom.equalToSuperview().inset(64)
            $0.leading.trailing.equalToSuperview().inset(86)
        }
        self.menuButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalTo(200)
        }
        self.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(353)
            $0.bottom.equalToSuperview().inset(285)
            $0.leading.equalToSuperview().offset(133)
            $0.trailing.equalToSuperview().inset(133)
        }
    }
    
}

extension SelectSnackViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.menu, for: indexPath)
        
        if let cell = cell as? MenuCell {
            cell.snackImage =  menu[indexPath.item].menuImage
            cell.menuName = menu[indexPath.item].menuName
            cell.menuPrice = menu[indexPath.item].menuPrice
            cell.menuNumber = menu[indexPath.item].menuNumber
            cell.delegate = self
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension SelectSnackViewController: MenuCellDelegate {
    
    func snackDidTap(name: String, price: Int, menuImage: String, menuNumber: Int) {
        let popupViewController = UINavigationController(rootViewController: MyPopupViewController(
            menuName: name,
            menuPrice: price,
            menuImage: menuImage,
            menuNumber: menuNumber
        ))
        
        print(menuNumber)
        
        popupViewController.modalPresentationStyle = .overFullScreen
        self.present(popupViewController, animated: false)
    }
}
