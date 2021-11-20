//
//  ZReportLoginView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 7.11.2021.
//
import Foundation
import UIKit

final class ZReportLoginView : UIView {
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var textUserName: UITextField!{
        didSet{
            textUserName.attributedPlaceholder = NSAttributedString(string: "     Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray] )
            textUserName.setLeftView(image: UIImage.init(named: "username")!)
            textUserName.tintColor = .darkGray
            textUserName.isSecureTextEntry = false
        }
    }
    
    @IBOutlet weak var textPassword: UITextField! {
        didSet{
            textPassword.attributedPlaceholder = NSAttributedString(string: "     Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray] )
            textPassword.setLeftView(image: UIImage.init(named: "password")!)
            textPassword.tintColor = .darkGray
            textPassword.isSecureTextEntry = true
        }
    }
    
    override func awakeFromNib() {
        self.textUserName.layer.cornerRadius = 10
        self.textPassword.layer.cornerRadius = 10
        self.viewBottom.layer.cornerRadius = 20.0
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
