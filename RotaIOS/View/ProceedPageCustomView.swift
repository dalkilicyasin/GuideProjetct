//
//  ProceedCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 25.04.2021.
//


import Foundation

import UIKit



class ProceedPageCustomView : UIView {

    @IBOutlet var headerView: UIView!

    @IBOutlet weak var firstMainTextCustomView: MainTextCustomView!
    @IBOutlet weak var secondMainTextCustomView: MainTextCustomView!
    @IBOutlet weak var thirdMainTextCustomView: MainTextCustomView!
    @IBOutlet weak var fourthMaintextCustomView: MainTextCustomView!
    @IBOutlet weak var senfButton: UIButton!
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ProceedPageCustomView.self), owner: self, options: nil)
        headerView.addCustomContainerView(self)
       // self.contentView.applyGradient(colours: [UIColor(hexString: "#BFD732"), UIColor(hexString: "#3DB54A")])
        
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        self.senfButton.layer.borderWidth = 1
        self.senfButton.layer.borderColor = UIColor.green.cgColor
        self.senfButton.layer.cornerRadius = 10
        
        self.datePicker.backgroundColor = UIColor.black
        self.firstMainTextCustomView.mainLabel.isHidden = true
        self.firstMainTextCustomView.mainText.isHidden = false
        
       
    }
    
    @IBAction func datepickerButton(_ sender: Any) {
        
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "HH:mm:ss"
        let pick = dateFormatt.string(from: datePicker.date)
        
     
        
       print(pick)
        
    }
    


    @IBAction func sendButtonClicked(_ sender: Any) {
            
      
}

    
}


