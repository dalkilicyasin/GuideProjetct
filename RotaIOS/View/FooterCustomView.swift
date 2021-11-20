//
//  FooterCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 20.04.2021.
//

import Foundation

import UIKit

protocol ContinueButtonTappedDelegate {
    func continueButtonTappedDelegate(tapped : Int)
}

class FooterCustomView: UIView {
    @IBOutlet weak var buttonGetOfflineData: UIButton!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var printButton: UIButton!
    var continueButtonTappedDelegate : ContinueButtonTappedDelegate?
    var counter = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: FooterCustomView.self), owner: self, options: nil)
        self.viewHeader.addCustomContainerView(self)
        self.buttonView.layer.cornerRadius = 10
        self.buttonView.backgroundColor = UIColor.greenColor
        
        self.printButton.isHidden = true
        self.printButton.isEnabled = false
        
        self.buttonGetOfflineData.isHidden = true
        self.buttonGetOfflineData.isEnabled = false
       
        self.printButton.layer.borderWidth = 1
        self.printButton.layer.borderColor = UIColor.green.cgColor
        self.printButton.layer.cornerRadius = 10
        self.printButton.backgroundColor = UIColor.clear
        
        self.buttonGetOfflineData.backgroundColor = UIColor.clear
        self.buttonGetOfflineData.layer.borderWidth = 1
        self.buttonGetOfflineData.layer.cornerRadius = 10
        self.buttonGetOfflineData.layer.borderColor = UIColor.green.cgColor
    }
    
    @IBAction func countinueButtonClicked(_ sender: Any) {
        
        self.counter += 1

        if counter == 4 {
            self.counter = 0
        }

        self.continueButtonTappedDelegate?.continueButtonTappedDelegate(tapped: counter)
        print(counter)
    }
    
    func buttonHiding( hidePrintbutton : Bool, hideButton : Bool) {
        self.printButton.isHidden = hidePrintbutton
        self.buttonView.isHidden = hideButton
    }
}




