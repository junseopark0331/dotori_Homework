import UIKit
import Then
import SnapKit

public final class SecureButtonTextField: UITextField {
    
    var passwordEyeButton = UIButton(type: .custom)
    
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
        
        isSecureTextEntry = true
        setPasswordShownButtonImage()
    }

    func setPasswordShownButtonImage() {
        passwordEyeButton = UIButton.init (primaryAction: UIAction (handler: { [weak self] _ in
            self?.isSecureTextEntry.toggle()
            self?.passwordEyeButton.isSelected.toggle()
        }))

        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.imagePadding = 10
        buttonConfiguration.baseBackgroundColor = .clear

        passwordEyeButton.setImage(
            UIImage(systemName: "eye.fill")?.withTintColor(
                UIColor(rgb: 0x999999),
                renderingMode: .alwaysOriginal
            ),
            for: .normal
        )
        passwordEyeButton.setImage(UIImage(systemName: "eye.slash.fill")?.withTintColor(UIColor(rgb: 0x999999), renderingMode: .alwaysOriginal), for: .selected)
        
        passwordEyeButton.configuration = buttonConfiguration
        passwordEyeButton.isSelected.toggle()
        
        rightView = passwordEyeButton
        rightViewMode = .always

    }
}
