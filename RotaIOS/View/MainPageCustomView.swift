//
//  MainPageCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 16.04.2021.
//


import UIKit

class MainPageCustomView: UIView {
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var imageMainPage: UIImageView!
    @IBOutlet weak var labelMainPage: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: MainPageCustomView.self), owner: self, options: nil)
        viewHeader.addCustomContainerView(self)
        viewHeader.addLine(position: .bottom, color: .gray, width: 0.5)
    }
}
