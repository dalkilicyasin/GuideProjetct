//
//  MainTextCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 21.04.2021.
//

import Foundation

import UIKit


class MainTextCustomView : UIView {
    
    @IBOutlet weak var mainTextCustomView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageMainText: UIImageView!
    @IBOutlet weak var mainText: UITextField!
    @IBOutlet weak var headerLAbel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: MainTextCustomView.self), owner: self, options: nil)
        self.headerView.addCustomContainerView(self)
        self.contentView.backgroundColor = UIColor.mainTextColor
        self.contentView.layer.cornerRadius = 10
        self.headerView.backgroundColor = UIColor.mainViewColor
        self.mainText.isHidden = true
        self.mainLabel.isHidden = false
    }
    
}