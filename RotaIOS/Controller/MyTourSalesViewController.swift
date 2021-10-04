//
//  MyTourSalesViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 5.08.2021.
//

import UIKit
import Foundation
import DropDown

class MyTourSalesViewController: UIViewController {
    @IBOutlet var viewMyTourSales: MyTourSaleView!
    var tourMenu = DropDown()
    var tourList : [GetTourSelectListResponseModel] = []
    var filteredTourList : [GetTourSelectListResponseModel] = []
    var tourListInTourmenu : [String] = []
    var viewMyTourStatusView : MyTourStatusView?
    var viewControllerDetail : MyTourSaleDetailPageViewController?
    var tourDetailList : [GetTourDetailForMobileResponseModel] = []
    var isTappedStatus = false
    var tourId = ""
    var statusId = ""
    var beginDate = ""
    var endDate = ""
    var saleDate = ""
    var saleEndDate = ""
    var voucherNo = ""
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
    var saleDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return datePicker
    }()
    var saleEndDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return datePicker
    }()
    let beginDateToolBar = UIToolbar()
    let endDateToolBar = UIToolbar()
    let saleDateToolBar = UIToolbar()
    let saleEndDateToolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint:.TourGetSelectList , method:.get , parameters: "") { (response : [GetTourSelectListResponseModel]) in
            if response.count > 0 {
                self.tourList = response
                for item in self.tourList {
                    self.tourListInTourmenu.append(item.text ?? "")
                }
                self.tourMenu.dataSource = self.tourListInTourmenu
                self.tourMenu.dataSource.insert("", at: 0)
                self.tourMenu.backgroundColor = UIColor.grayColor
                self.tourMenu.separatorColor = UIColor.gray
                self.tourMenu.textColor = .white
                self.tourMenu.anchorView = self.viewMyTourSales.viewTourSelect
                self.tourMenu.topOffset = CGPoint(x: 0, y:-(self.tourMenu.anchorView?.plainView.bounds.height)!)
            }else {
                print("data has not recived")
            }
        }
        self.createBeginDatePicker()
        self.createEndDatePicker()
        self.createSaleDatePicker()
        self.createSaleEndDatePicker()
        self.tourMenu.selectionAction = { index, title in
            self.viewMyTourSales.viewTourSelect.mainLabel.text = title
            let filtered = self.tourList.filter{($0.text?.contains(title) ?? false)}
            self.filteredTourList = filtered
            for item in self.filteredTourList {
                self.tourId = "\(item.value ?? 0)"
            }
        }
        let tourMenuGesture = UITapGestureRecognizer(target: self, action: #selector(tappedTour))
        self.viewMyTourSales.viewTourSelect.addGestureRecognizer(tourMenuGesture)
        
        let statusMenuGesture = UITapGestureRecognizer(target: self, action: #selector(tappedStatus))
        self.viewMyTourSales.viewStatusSelect.addGestureRecognizer(statusMenuGesture) 
        
        let removeStatusMenuGesture = UITapGestureRecognizer(target: self, action: #selector(tappedViewContentView))
        self.viewMyTourSales.addGestureRecognizer(removeStatusMenuGesture)
    }
    
    func createBeginDatePicker() {
        self.viewMyTourSales.viewBeginDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(beginDatePickerDonePressed))
        self.beginDateToolBar.setItems([doneButton], animated: true)
        self.beginDateToolBar.sizeToFit()
        self.viewMyTourSales.viewBeginDate.mainText.inputAccessoryView = beginDateToolBar
        self.viewMyTourSales.viewBeginDate.mainText.inputView = self.beginDatePicker
        self.beginDatePicker.datePickerMode = .date
    }
    
    func createEndDatePicker() {
        self.viewMyTourSales.viewEndDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(endDatePickerDonePressed))
        self.endDateToolBar.setItems([doneButton], animated: true)
        self.endDateToolBar.sizeToFit()
        self.viewMyTourSales.viewEndDate.mainText.inputAccessoryView = endDateToolBar
        self.viewMyTourSales.viewEndDate.mainText.inputView = self.endDatePicker
        self.self.endDatePicker.datePickerMode = .date
    }
    
    func createSaleDatePicker() {
        self.viewMyTourSales.viewSaleDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(saleDatePickerDonePressed))
        self.saleDateToolBar.setItems([doneButton], animated: true)
        self.saleDateToolBar.sizeToFit()
        self.viewMyTourSales.viewSaleDate.mainText.inputAccessoryView = saleDateToolBar
        self.viewMyTourSales.viewSaleDate.mainText.inputView = self.saleDatePicker
        self.saleDatePicker.datePickerMode = .date
    }
    
    func createSaleEndDatePicker() {
        self.viewMyTourSales.viewSaleEndDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(saleEndDatePickerDonePressed))
        self.saleEndDateToolBar.setItems([doneButton], animated: true)
        self.saleEndDateToolBar.sizeToFit()
        self.viewMyTourSales.viewSaleEndDate.mainText.inputAccessoryView = self.saleEndDateToolBar
        self.viewMyTourSales.viewSaleEndDate.mainText.inputView = self.saleEndDatePicker
        self.saleEndDatePicker.datePickerMode = .date
    }
    
    @objc func beginDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.beginDatePicker.date))
        self.beginDate = formatter.string(from: self.beginDatePicker.date)
        formatter.dateFormat = "dd-MM-yyy"
        self.viewMyTourSales.viewBeginDate.mainText.text = "\(formatter.string(from: self.beginDatePicker.date))"
        self.viewMyTourSales.endEditing(true)
    }
    
    @objc func endDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.endDatePicker.date))
        self.endDate = formatter.string(from: self.endDatePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        self.viewMyTourSales.viewEndDate.mainText.text = "\(formatter.string(from: self.endDatePicker.date))"
        self.viewMyTourSales.endEditing(true)
    }
    
    @objc func saleDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.saleDatePicker.date))
        self.saleDate = formatter.string(from: self.saleDatePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        self.viewMyTourSales.viewSaleDate.mainText.text = "\(formatter.string(from: self.saleDatePicker.date))"
        self.viewMyTourSales.endEditing(true)
    }
    
    @objc func saleEndDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.saleEndDatePicker.date))
        self.saleEndDate = formatter.string(from: self.saleEndDatePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        self.viewMyTourSales.viewSaleEndDate.mainText.text = "\(formatter.string(from: self.saleEndDatePicker.date))"
        self.viewMyTourSales.endEditing(true)
    }
    
    @objc func tappedStatus() {
        self.isTappedStatus = !self.isTappedStatus
        if self.isTappedStatus == true {
            if self.viewMyTourStatusView == nil {
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewMyTourStatusView = MyTourStatusView()
                    self.viewMyTourStatusView?.myTourStatusViewDelegate = self
                    self.viewMyTourSales.viewContentView.addSubview(self.viewMyTourStatusView!)
                    self.viewMyTourStatusView!.frame = CGRect(x: 30, y: 180, width: UIScreen.main.bounds.size.width - 60, height: self.viewMyTourSales.frame.size.height - 350)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }else {
                self.viewMyTourStatusView?.isHidden = false
            }
        }else {
            self.viewMyTourStatusView?.isHidden = true
        }  
    }
    
    @objc func tappedViewContentView() {
        // self.myTourStatusView?.removeFromSuperview()
    }
    
    @objc func tappedTour() {
        self.tourMenu.show()
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let myTourSaleRequestModel = GetTourDetailForMobileRequestModel.init(begindate: self.beginDate, guideId: userDefaultsData.getGuideId(), endDate: self.endDate, saleDate: self.saleDate, voucher: self.voucherNo, tourId: self.tourId, statusId: self.statusId, saleEndDate: self.saleEndDate)
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint:.TourGetTourDetailForMobile , method: .get, parameters: myTourSaleRequestModel.requestPathString()) { (response : [GetTourDetailForMobileResponseModel]) in
            if response.count > 0 {
                self.tourDetailList = response
                self.otiPushViewController(viewController: MyTourSaleDetailPageViewController(tourDetailListInDetailPage: self.tourDetailList), animated: true)
            }else {
                let alert = UIAlertController(title: "Error", message: "Data has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension MyTourSalesViewController : MyTourStatusViewDelegate {
    func myTourStatusSelectedIdList(selectedStatusIdList: [String]) {
        self.statusId = selectedStatusIdList.joined(separator: ",")
    }
}
