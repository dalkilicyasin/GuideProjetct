//
//  ProceedCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 25.04.2021.
//


import Foundation

import UIKit


protocol ProceedPageDelegate {
    func proceedPage(isSuccsess : Bool)
}
class ProceedPageCustomView : UIView {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var shopDateMainText: MainTextCustomView!
    @IBOutlet weak var roomMainText: MainTextCustomView!
    @IBOutlet weak var notesMainText: MainTextCustomView!
    @IBOutlet weak var pickUpTimeMainText: MainTextCustomView!
    @IBOutlet weak var sendButton: UIButton!
    var dateString = ""
    var timeString = ""
    var proceedPageDelegate : ProceedPageDelegate?
    
    var paxFilteredList : [String] = []
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return datePicker
    }()
    var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return timePicker
    }()
    let dateToolBar = UIToolbar()
    let timeToolBar = UIToolbar()
    
    var paxListinProceedPage : [Paxes] = []
    var stepsListinProceedPage : [Steps] = []
    
    var paxListStringType : [String : Any] = [:]
    var stepListStringType : [String : Any] = [:]
    
    var adultCountinProceedPage = 0
    var childCountinProceedPage = 0
    var infantCountinProceedPage = 0
    
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
        self.sendButton.isEnabled = true
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        self.sendButton.backgroundColor = UIColor.greenColor
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
        
        
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        
      print(paxListinProceedPage)
      print(stepsListinProceedPage)
        
        let saveForMobileRequestModel = GetSaveForMobileRequestList.init(iND_CHLMAXAGE: NSNull() , iND_NOTE: self.notesMainText.mainText.text ?? NSNull(), iND_VOUCHER: NSNull(), iND_SHOPDATE: self.dateString , iND_GUIDEREF: userDefaultsData.getGuideId() , iND_MARKETGROUPREF: userDefaultsData.getMarketGruopId() , iND_MARKETREF: userDefaultsData.getMarketId() , iND_AREAREF: userDefaultsData.getHotelArea() , iND_HOTELREF: userDefaultsData.getHotelId() , iND_SHOPPICKUPTIME: self.timeString,  strPaxes: self.paxListinProceedPage.toJSONString(prettyPrint: true) ?? "" , strSteps: self.stepsListinProceedPage.toJSONString(prettyPrint: true) ?? "")
        
        if dateString.isEmpty == false && self.paxListinProceedPage.isEmpty == false && self.stepsListinProceedPage.isEmpty == false {
            NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetSaveForMobile, requestModel: saveForMobileRequestModel ) { (response: GetSaveForMobileResponseList) in
                if response.isSuccesful ?? false{
                    if let topVC = UIApplication.getTopViewController() {
                        let alert = UIAlertController(title: "SUCCESS", message: response.message, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        topVC.present(alert, animated: true, completion: nil)
                    }
               
                    self.sendButton.backgroundColor = UIColor.clear
                    self.sendButton.layer.borderWidth = 1
                    self.sendButton.layer.borderColor = UIColor.green.cgColor
                    self.sendButton.layer.cornerRadius = 10
                    self.sendButton.isEnabled = false
                    self.proceedPageDelegate?.proceedPage(isSuccsess: true)
                    print(response)
                    
                }else{
                    if let topVC = UIApplication.getTopViewController() {
                        let alert = UIAlertController(title: "Errror", message: response.exceptionMessage, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        topVC.present(alert, animated: true, completion: nil)
                        self.proceedPageDelegate?.proceedPage(isSuccsess: false)
                    }
                    
                }
            }
        }else {
            if let topVC = UIApplication.getTopViewController() {
                let alert = UIAlertController(title: "Errror", message: "Please Insert Paxes/Steps/ShopDate", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                topVC.present(alert, animated: true, completion: nil)
                self.proceedPageDelegate?.proceedPage(isSuccsess: false)
            }
            
        }
     
}
    
    func createDatePicker() {
        
        self.shopDateMainText.mainText.textAlignment = .left
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
        
        self.shopDateMainText.mainText.text = "\(formatter.string(from: datePicker.date))"
        self.headerView.endEditing(true)
        
        print(formatter.string(from: datePicker.date))
        
        self.dateString = formatter.string(from: datePicker.date)
    }
    
    
    func createTimePicker() {
        
        self.pickUpTimeMainText.mainText.textAlignment = .left
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
        
        self.pickUpTimeMainText.mainText.text = "\(formatter.string(for: timePicker.date) ?? "12:00")"
        self.headerView.endEditing(true)
        print(formatter.string(from: timePicker.date))
        self.timeString = formatter.string(from: datePicker.date)
    }
}



