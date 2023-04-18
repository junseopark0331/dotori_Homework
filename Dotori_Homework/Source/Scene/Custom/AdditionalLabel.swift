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
