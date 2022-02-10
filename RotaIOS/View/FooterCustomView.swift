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

protocol SaveButtonTappedDelegate {
    func totalPrice(isSaveButtonTapped : Bool?)
}

class FooterCustomView: UIView {
    @IBOutlet weak var buttonGetOfflineData: UIButton!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var printButton: UIButton!
    @IBOutlet weak var buttonAddButton: UIButton!
    @IBOutlet weak var buttonSaveButton: UIButton!
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var viewSendVoucher: UIView!
    var continueButtonTappedDelegate : ContinueButtonTappedDelegate?
    var counter = 0
    var totalPriceIsSaved = false
    var saveButtonTappedDelegate : SaveButtonTappedDelegate?

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
       
        self.buttonAddButton.isHidden = true
        self.buttonAddButton.layer.cornerRadius = 10
        self.buttonAddButton.backgroundColor = UIColor.greenColor
        
        self.buttonSaveButton.isEnabled = true
        self.buttonSaveButton.isHidden = true
        self.buttonSaveButton.layer.cornerRadius = 10
        self.buttonSaveButton.backgroundColor = UIColor.clear
        self.buttonSaveButton.layer.borderWidth = 1
        self.buttonSaveButton.layer.borderColor = UIColor.greenColor.cgColor
        
        self.printButton.layer.borderWidth = 1
        self.printButton.layer.borderColor = UIColor.green.cgColor
        self.printButton.layer.cornerRadius = 10
        self.printButton.backgroundColor = UIColor.clear
        
        self.buttonGetOfflineData.backgroundColor = UIColor.clear
        self.buttonGetOfflineData.layer.borderWidth = 1
        self.buttonGetOfflineData.layer.cornerRadius = 10
        self.buttonGetOfflineData.layer.borderColor = UIColor.green.cgColor
        
        self.labelAmount.isHidden = true
        self.labelAmount.layer.masksToBounds = true
        self.labelAmount.layer.cornerRadius = 10
        self.labelAmount.text = "Amount"
        
        self.viewSendVoucher.layer.cornerRadius = 10
        self.viewSendVoucher.backgroundColor = UIColor.greenColor
        self.viewSendVoucher.isHidden = true
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.saveButtonTappedDelegate?.totalPrice(isSaveButtonTapped: true)
        self.buttonSaveButton.isEnabled = true
        let alert = UIAlertController.init(title: "SUCCESS", message: "Price has ben saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let topVC = UIApplication.getTopViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func countinueButtonClicked(_ sender: Any) {
        if counter == 2 && userDefaultsData.getPaxesList()?.count == 0 {
            return
        }
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




