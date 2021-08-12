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
    var myTourStatusView : MyTourStatusView?
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
    let beginDateToolBar = UIToolbar()
    let endDateToolBar = UIToolbar()
    let saleDateToolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint:.TourGetSelectList , method:.get , parameters: "") { (response : [GetTourSelectListResponseModel]) in
            if response.count > 0 {
                self.tourList = response
                for item in self.tourList {
                    self.tourListInTourmenu.append(item.text ?? "")
                }
                self.tourMenu.dataSource = self.tourListInTourmenu
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
        
        self.tourMenu.selectionAction = { index, title in
            self.viewMyTourSales.viewTourSelect.mainLabel.text = title
            
            let filtered = self.tourList.filter{($0.text?.contains(title) ?? false)}
            self.filteredTourList = filtered
            for item in self.filteredTourList {
                self.tourId = "\(item.value ?? 0)" 
                //   userDefaultsData.saveMarketGroupId(marketId: listofarray.id ?? "") // silinecek
            }
        }
        
        let tourMenuGesture = UITapGestureRecognizer(target: self, action: #selector(tappedTour))
        self.viewMyTourSales.viewTourSelect.addGestureRecognizer(tourMenuGesture)
        
        let statusMenuGesture = UITapGestureRecognizer(target: self, action: #selector(tappedStatus))
        self.viewMyTourSales.viewStatusSelect.addGestureRecognizer(statusMenuGesture)
        
        let contentViewGesture = UITapGestureRecognizer(target: self, action: #selector(tappedContentView))
        self.viewMyTourSales.addGestureRecognizer(contentViewGesture)
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
        self.self.saleDatePicker.datePickerMode = .date
    }
    
    @objc func beginDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        self.viewMyTourSales.viewBeginDate.mainText.text = "\(formatter.string(from: self.beginDatePicker.date))"
        self.viewMyTourSales.endEditing(true)
        print(formatter.string(from: self.beginDatePicker.date))
        self.beginDate = formatter.string(from: self.beginDatePicker.date)
    }
    
    @objc func endDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        self.viewMyTourSales.viewEndDate.mainText.text = "\(formatter.string(from: self.endDatePicker.date))"
        self.viewMyTourSales.endEditing(true)
        print(formatter.string(from: self.endDatePicker.date))
        self.endDate = formatter.string(from: self.endDatePicker.date)
    }
    
    @objc func saleDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        self.viewMyTourSales.viewSaleDate.mainText.text = "\(formatter.string(from: self.saleDatePicker.date))"
        self.viewMyTourSales.endEditing(true)
        print(formatter.string(from: self.saleDatePicker.date))
        self.saleDate = formatter.string(from: self.saleDatePicker.date)
    }
    
    @objc func tappedStatus() {
        self.isTappedStatus = !self.isTappedStatus
        if self.isTappedStatus == true {
            UIView.animate(withDuration: 0, animations: { [self] in
                self.myTourStatusView = MyTourStatusView()
                self.viewMyTourSales.addSubview(myTourStatusView!)
                myTourStatusView!.frame = CGRect(x: 30, y: 250, width: UIScreen.main.bounds.size.width - 60, height: self.viewMyTourSales.frame.size.height - 300)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
        }else {
            self.myTourStatusView?.removeFromSuperview()
        }  
    }
    
    @objc func tappedContentView() {
        self.myTourStatusView?.removeFromSuperview()
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
