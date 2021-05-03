//
//  HeaderCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 20.04.2021.
//

import Foundation

import UIKit

class HeaderCustomView : UIView {
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var labelheader: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: HeaderCustomView.self), owner: self, options: nil)
        headerView.addCustomContainerView(self)
        self.contentView.applyGradient(colours: [UIColor(hexString: "#BFD732"), UIColor(hexString: "#3DB54A")])
        
    }
}
