//
//  LoginView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 29.03.2021.
//

import Foundation
import UIKit

final class LoginView : UIView {
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var textUsername: UITextField! {
        didSet{
            textUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray] )
            textUsername.setLeftView(image: UIImage.init(named: "username")!)
            textUsername.tintColor = .darkGray
            textUsername.isSecureTextEntry = false
        }
    }
    @IBOutlet weak var textPassword: UITextField! {
        didSet{
            textPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray] )
            textPassword.setLeftView(image: UIImage.init(named: "password")!)
            textPassword.tintColor = .darkGray
            textPassword.isSecureTextEntry = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBottom.layer.cornerRadius = 10.0
        self.viewTop.applyGradient(colours: [UIColor(hexString: "#BFD732"), UIColor(hexString: "#3DB54A")])
        self.buttonLogin.layer.cornerRadius = 10
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}

extension UITextField {
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
}
