//
//  MyShoppingSaleViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import UIKit
import Foundation

class MyShoppingSaleViewController: UIViewController {
    
    @IBOutlet var viewMyShoppinSaleView: MyShoppingSaleView!
    var shopSaleList : [GetShoppingSaleResponseModel] = []
    var beginDate = ""
    var endDate = ""
    let beginDateToolBar = UIToolbar()
    let endDateToolBar = UIToolbar()
    var beginDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return datePicker
    }()
    var endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createBeginDatePicker()
        self.createEndDatePicker()
    }
    func createBeginDatePicker() {
        self.viewMyShoppinSaleView.viewBeginDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(beginDatePickerDonePressed))
        self.beginDateToolBar.setItems([doneButton], animated: true)
        self.beginDateToolBar.sizeToFit()
        self.viewMyShoppinSaleView.viewBeginDate.mainText.inputAccessoryView = beginDateToolBar
        self.viewMyShoppinSaleView.viewBeginDate.mainText.inputView = self.beginDatePicker
        self.beginDatePicker.datePickerMode = .date
    }
    
    func createEndDatePicker() {
        self.viewMyShoppinSaleView.viewEndDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(endDatePickerDonePressed))
        self.endDateToolBar.setItems([doneButton], animated: true)
        self.endDateToolBar.sizeToFit()
        self.viewMyShoppinSaleView.viewEndDate.mainText.inputAccessoryView = endDateToolBar
        self.viewMyShoppinSaleView.viewEndDate.mainText.inputView = self.endDatePicker
        self.self.endDatePicker.datePickerMode = .date
    }
    
    @objc func beginDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        self.viewMyShoppinSaleView.viewBeginDate.mainText.text = "\(formatter.string(from: self.beginDatePicker.date))"
        self.viewMyShoppinSaleView.endEditing(true)
        print(formatter.string(from: self.beginDatePicker.date))
        self.beginDate = formatter.string(from: self.beginDatePicker.date)
    }
    
    @objc func endDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        self.viewMyShoppinSaleView.viewEndDate.mainText.text = "\(formatter.string(from: self.endDatePicker.date))"
        self.viewMyShoppinSaleView.endEditing(true)
        print(formatter.string(from: self.endDatePicker.date))
        self.endDate = formatter.string(from: self.endDatePicker.date)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let myTourSaleRequestModel = GetShoppingSaleRequestModel.init(begindate: self.beginDate, guideId: userDefaultsData.getGuideId(), endDate: self.endDate)
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint:.GetIndShopDetailForMobile , method: .get, parameters: myTourSaleRequestModel.requestPathString()) { (response : [GetShoppingSaleResponseModel]) in
            if response.count > 0 {
                
                self.shopSaleList = response
                self.otiPushViewController(viewController: MyShoppinSaleDetailViewController(shopSalesDetailListInDetailPage: self.shopSaleList), animated: true)
                
            }else {
                let alert = UIAlertController(title: "Error", message: "Data has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
