//
//  ExcProceedCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.12.2021.
//

import Foundation
import UIKit

class ExcProceedCustomView: UIView{
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewTouristView: MainTextCustomView!
    @IBOutlet weak var viewCurrencyType: MainTextCustomView!
    @IBOutlet weak var viewType: MainTextCustomView!
    @IBOutlet weak var viewAmount: MainTextCustomView!
    @IBOutlet weak var viewDiscount: MainTextCustomView!
    @IBOutlet weak var viewNotes: MainTextCustomView!
    @IBOutlet weak var viewPaid: MainTextCustomView!
    @IBOutlet weak var viewBalanced: MainTextCustomView!
    @IBOutlet weak var viewDicountCalculate: MainTextCustomView!
    @IBOutlet weak var viewTotalAmount: MainTextCustomView!
    @IBOutlet weak var viewCurrencyConvert: MainTextCustomView!
    @IBOutlet weak var buttonApplyDiscount: UIButton!
    @IBOutlet weak var buttonAddPayment: UIButton!
    @IBOutlet weak var buttonConvert: UIButton!
    var totalAmount = 0.00
    var balanceAmount = 0.00
    var savedTotalAmount = 0.00
    
override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
}

func commonInit() {
    Bundle.main.loadNibNamed(String(describing: ExcProceedCustomView.self), owner: self, options: nil)
    self.viewMainView.addCustomContainerView(self)
    self.viewMainView.backgroundColor = UIColor.grayColor
    self.viewTouristView.headerLAbel.text = "Tourist"
    self.viewCurrencyType.headerLAbel.text = "CurrencyType"
    self.viewType.headerLAbel.text = "Type"
    self.viewAmount.headerLAbel.text = "Amount"
    self.viewDiscount.headerLAbel.text = "Discount"
    self.viewNotes.headerLAbel.text = "Notes"
    self.viewPaid.headerLAbel.text = "Paid"
    self.viewBalanced.headerLAbel.text = "Balanced"
    self.viewDicountCalculate.headerLAbel.text = "Discount"
    self.viewTotalAmount.headerLAbel.text = "TotalAmount"
    self.viewCurrencyConvert.headerLAbel.text = "Currency"
    self.viewAmount.mainText.isHidden = false
    self.viewAmount.mainLabel.isHidden = true
    self.viewNotes.mainText.isHidden = false
    self.viewNotes.mainLabel.isHidden = true
    self.viewDiscount.mainText.isHidden = false
    self.viewDiscount.mainLabel.isHidden = true
    self.viewPaid.mainLabel.isHidden = true
    self.viewPaid.mainText.isHidden = false
    self.viewBalanced.mainLabel.isHidden = true
    self.viewBalanced.mainText.isHidden = false
    self.viewDicountCalculate.mainLabel.isHidden = true
    self.viewDicountCalculate.mainText.isHidden = false
    self.viewTotalAmount.mainLabel.isHidden = true
    self.viewTotalAmount.mainText.isHidden = false
    self.viewCurrencyConvert.mainLabel.isHidden = true
    self.viewCurrencyConvert.mainText.isHidden = false
    self.viewAmount.imageMainText.isHidden = true
    self.viewNotes.imageMainText.isHidden = true
    self.viewDiscount.imageMainText.isHidden = true
    self.viewPaid.imageMainText.isHidden = true
    self.viewDicountCalculate.imageMainText.isHidden = true
    self.viewTotalAmount.imageMainText.isHidden = true
    self.viewBalanced.imageMainText.isHidden = true
    self.viewCurrencyConvert.imageMainText.isHidden = true
    
    self.buttonApplyDiscount.layer.cornerRadius = 10
    self.buttonApplyDiscount.backgroundColor = UIColor.greenColor
    self.buttonConvert.layer.cornerRadius = 10
    self.buttonConvert.backgroundColor = UIColor.greenColor
    self.buttonAddPayment.layer.cornerRadius = 10
    self.buttonAddPayment.backgroundColor = UIColor.greenColor
    
    
   }
    
    @IBAction func applyDiscountButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func addPaymentButtonTapped(_ sender: Any) {
        
        if let total = Double(self.viewAmount.mainText.text ?? ""){
            self.savedTotalAmount = total
         }
        self.viewPaid.mainText.text = String(self.savedTotalAmount)
        
        if self.savedTotalAmount < 0 {
            self.savedTotalAmount = -self.savedTotalAmount
        }
        
        self.balanceAmount = self.totalAmount - self.savedTotalAmount
        if self.balanceAmount < 0 {
            self.balanceAmount = 0.00
        }
        
        self.viewBalanced.mainText.text = String(self.balanceAmount)
    }
    
    @IBAction func convertButtonTapped(_ sender: Any) {
        
    }
}
