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
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewShopDateMainTextView: MainTextCustomView!
    @IBOutlet weak var viewRoomMainTextView: MainTextCustomView!
    @IBOutlet weak var viewNotesMainTextView: MainTextCustomView!
    @IBOutlet weak var viewPickUpTimeMainTextView: MainTextCustomView!
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
        self.viewMainView.addCustomContainerView(self)
        self.sendButton.isEnabled = true
        self.viewMainView.backgroundColor = UIColor.mainViewColor
        self.sendButton.backgroundColor = UIColor.greenColor
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.borderColor = UIColor.green.cgColor
        self.sendButton.layer.cornerRadius = 10
        self.viewShopDateMainTextView.headerLAbel.text = "Shop Date"
        self.viewPickUpTimeMainTextView.headerLAbel.text = "Pick Up Time"
        self.viewRoomMainTextView.headerLAbel.text = "Room"
        self.viewNotesMainTextView.headerLAbel.text = "Notes"
        self.viewShopDateMainTextView.mainLabel.isHidden = true
        self.viewShopDateMainTextView.mainText.isHidden = false
        self.viewShopDateMainTextView.imageMainText.isHidden = true
        self.viewPickUpTimeMainTextView.mainLabel.isHidden = true
        self.viewPickUpTimeMainTextView.mainText.isHidden = false
        self.viewPickUpTimeMainTextView.imageMainText.isHidden = true
        self.viewRoomMainTextView.mainLabel.isHidden = true
        self.viewRoomMainTextView.mainText.isHidden = false
        self.viewRoomMainTextView.imageMainText.isHidden = true
        self.viewNotesMainTextView.mainLabel.isHidden = true
        self.viewNotesMainTextView.mainText.isHidden = false
        self.viewNotesMainTextView.imageMainText.isHidden = true
        
        self.createDatePicker()
        self.createTimePicker()
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        print(paxListinProceedPage)
        print(stepsListinProceedPage)
        
        let saveForMobileRequestModel = GetSaveForMobileRequestList.init(iND_CHLMAXAGE: NSNull() , iND_NOTE: self.viewNotesMainTextView.mainText.text ?? NSNull(), iND_VOUCHER: NSNull(), iND_SHOPDATE: self.dateString , iND_GUIDEREF: userDefaultsData.getGuideId() , iND_MARKETGROUPREF: userDefaultsData.getMarketGruopId() , iND_MARKETREF: userDefaultsData.getMarketId() , iND_AREAREF: userDefaultsData.getHotelArea() , iND_HOTELREF: userDefaultsData.getHotelId() , iND_SHOPPICKUPTIME: self.timeString,  strPaxes: self.paxListinProceedPage.toJSONString(prettyPrint: true) ?? "" , strSteps: self.stepsListinProceedPage.toJSONString(prettyPrint: true) ?? "")
        
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
                let alert = UIAlertController(title: "Error", message: "Please Insert Paxes/Steps/ShopDate", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                topVC.present(alert, animated: true, completion: nil)
                self.proceedPageDelegate?.proceedPage(isSuccsess: false)
            }
        }
    }
    
    func createDatePicker() {
        self.viewShopDateMainTextView.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        self.dateToolBar.setItems([doneButton], animated: true)
        self.dateToolBar.sizeToFit()
        self.viewShopDateMainTextView.mainText.inputAccessoryView = dateToolBar
        self.viewShopDateMainTextView.mainText.inputView = datePicker
        self.datePicker.datePickerMode = .date
    }
    
    @objc func datePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        self.viewShopDateMainTextView.mainText.text = "\(formatter.string(from: datePicker.date))"
        self.viewMainView.endEditing(true)
        print(formatter.string(from: datePicker.date))
        self.dateString = formatter.string(from: datePicker.date)
    }
    
    func createTimePicker() {
        self.viewPickUpTimeMainTextView.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDonePressed))
        self.timeToolBar.setItems([doneButton], animated: true)
        self.timeToolBar.sizeToFit()
        self.viewPickUpTimeMainTextView.mainText.inputAccessoryView = timeToolBar
        self.viewPickUpTimeMainTextView.mainText.inputView = timePicker
        self.timePicker.datePickerMode = .time
    }
    
    @objc func timePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "HH:dd a"
        self.viewPickUpTimeMainTextView.mainText.text = "\(formatter.string(for: timePicker.date) ?? "12:00")"
        self.viewMainView.endEditing(true)
        print(formatter.string(from: timePicker.date))
        self.timeString = formatter.string(from: datePicker.date)
    }
}



