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

   
    @IBOutlet weak var roomMainText: MainTextCustomView!
    @IBOutlet weak var notesMainText: MainTextCustomView!
    
    @IBOutlet weak var senfButton: UIButton!
   
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    
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
        
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        self.senfButton.layer.borderWidth = 1
        self.senfButton.layer.borderColor = UIColor.green.cgColor
        self.senfButton.layer.cornerRadius = 10
        
        self.datePicker.backgroundColor = UIColor.mainTextColor
        self.timePicker.backgroundColor = UIColor.mainTextColor
        
        self.roomMainText.headerLAbel.text = "Room"
        self.notesMainText.headerLAbel.text = "Notes"
        
        self.roomMainText.mainLabel.isHidden = true
        self.roomMainText.mainText.isHidden = false
        self.roomMainText.imageMainText.isHidden = true
        self.notesMainText.imageMainText.isHidden = true
        
        self.notesMainText.mainLabel.isHidden = true
        self.notesMainText.mainText.isHidden = false
       
    }
    
    @IBAction func datepickerButton(_ sender: Any) {
        
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "MMM dd, YYYY"
        let pick = dateFormatt.string(from: datePicker.date)
       print(pick)
        
    }
    
    @IBAction func timepickerButton(_ sender: Any) {
        
        let timeFormatt = DateFormatter()
        timeFormatt.dateFormat = "HH:mm:ss"
        let timepick = timeFormatt.string(from: timePicker.date)
       print(timepick)
    }
    

    @IBAction func sendButtonClicked(_ sender: Any) {
            
      
}

    
}


