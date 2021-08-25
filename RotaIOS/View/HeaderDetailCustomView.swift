//
//  HeaderDetailCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//

import Foundation

import UIKit

class HeaderDetailCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var labelHeaderDetailView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: HeaderDetailCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.viewMainView.applyGradient(colours: [UIColor(hexString: "#BFD732"), UIColor(hexString: "#3DB54A")])
        
    }
    @IBAction func buttonClicked(_ sender: Any) {
        if let topVC = UIApplication.getTopViewController() {
            topVC.navigationController?.popViewController(animated: true)
        }
    }
}
