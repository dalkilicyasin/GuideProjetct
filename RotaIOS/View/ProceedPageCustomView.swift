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
   
    let datePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
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
    
        self.roomMainText.headerLAbel.text = "Room"
        self.notesMainText.headerLAbel.text = "Notes"
        
        self.roomMainText.mainLabel.isHidden = true
        self.roomMainText.mainText.isHidden = false
        self.roomMainText.imageMainText.isHidden = true
        self.notesMainText.imageMainText.isHidden = true
        
        self.notesMainText.mainLabel.isHidden = true
        self.notesMainText.mainText.isHidden = false
       
        self.createDatePicker()
    }
    

    @IBAction func sendButtonClicked(_ sender: Any) {
            
      
}
    
    func createDatePicker() {
        
        self.roomMainText.mainText.textAlignment = .center
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        self.toolBar.setItems([doneButton], animated: true)
        
        self.toolBar.sizeToFit()
        self.roomMainText.mainText.inputAccessoryView = toolBar
        self.roomMainText.mainText.inputView = datePicker
        self.datePicker.datePickerMode = .date
    
        
    }
    
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        
        self.roomMainText.mainText.text = formatter.string(from: datePicker.date)
        self.headerView.endEditing(true)
        
        print(formatter.string(from: datePicker.date))
    }


    
}


