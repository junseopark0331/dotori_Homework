import UIKit

public final class CustomTextField: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        borderStyle = .roundedRect
        layer.cornerRadius = 8
        layer.borderColor = UIColor(rgb: 0x000000).cgColor
        layer.borderWidth = 1
    }
    
}
