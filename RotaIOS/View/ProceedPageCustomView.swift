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
    @IBOutlet weak var shopDateMainText: MainTextCustomView!
    @IBOutlet weak var roomMainText: MainTextCustomView!
    @IBOutlet weak var notesMainText: MainTextCustomView!
    @IBOutlet weak var pickUpTimeMainText: MainTextCustomView!
    @IBOutlet weak var sendButton: UIButton!
    
    var paxFilteredList : [String] = []
    
    let datePicker = UIDatePicker()
   let timePicker = UIDatePicker()
    let dateToolBar = UIToolbar()
    let timeToolBar = UIToolbar()
    
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
        
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.borderColor = UIColor.green.cgColor
        self.sendButton.layer.cornerRadius = 10
        
        self.shopDateMainText.headerLAbel.text = "Shop Date"
        self.pickUpTimeMainText.headerLAbel.text = "Pick Up Time"
        self.roomMainText.headerLAbel.text = "Room"
        self.notesMainText.headerLAbel.text = "Notes"
        
        self.shopDateMainText.mainLabel.isHidden = true
        self.shopDateMainText.mainText.isHidden = false
        self.shopDateMainText.imageMainText.isHidden = true
        self.pickUpTimeMainText.mainLabel.isHidden = true
        self.pickUpTimeMainText.mainText.isHidden = false
        self.pickUpTimeMainText.imageMainText.isHidden = true
        self.roomMainText.mainLabel.isHidden = true
        self.roomMainText.mainText.isHidden = false
        self.roomMainText.imageMainText.isHidden = true
        self.notesMainText.mainLabel.isHidden = true
        self.notesMainText.mainText.isHidden = false
        self.notesMainText.imageMainText.isHidden = true
        
        self.createDatePicker()
        self.createTimePicker()
       
        print(self.paxFilteredList)
       
   
    
    }
    

    

    @IBAction func sendButtonClicked(_ sender: Any) {
        
       
     
   /*
        NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetSaveForMobile, requestModel: saveFormMobile ) { (response: GetSaveForMobileRequestList) in
            if response != nil {
                print(response)
            }else{
                let alert = UIAlertController(title: "Errror", message: "Token has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            }
        } */
      
}
    
    func createDatePicker() {
        
        self.shopDateMainText.mainText.textAlignment = .center
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        self.dateToolBar.setItems([doneButton], animated: true)
        self.dateToolBar.sizeToFit()
        self.shopDateMainText.mainText.inputAccessoryView = dateToolBar
        self.shopDateMainText.mainText.inputView = datePicker
        self.datePicker.datePickerMode = .date
    }
    
    
    @objc func datePickerDonePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        
        self.shopDateMainText.mainText.text = formatter.string(from: datePicker.date)
        self.headerView.endEditing(true)
        
        print(formatter.string(from: datePicker.date))
    }
    
    
    func createTimePicker() {
        
        self.pickUpTimeMainText.mainText.textAlignment = .center
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDonePressed))
        self.timeToolBar.setItems([doneButton], animated: true)
        self.timeToolBar.sizeToFit()
        self.pickUpTimeMainText.mainText.inputAccessoryView = timeToolBar
        self.pickUpTimeMainText.mainText.inputView = timePicker
        self.timePicker.datePickerMode = .time
    }
    
    
    @objc func timePickerDonePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "HH:dd a"
        
        self.pickUpTimeMainText.mainText.text = formatter.string(for: timePicker.date)
        self.headerView.endEditing(true)
        print(formatter.string(from: timePicker.date))
    }
}


