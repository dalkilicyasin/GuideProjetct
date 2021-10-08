//
//  MyShoppingSaleViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import UIKit
import Foundation
import DropDown

class MyShoppingSaleViewController: UIViewController {
    @IBOutlet var viewMyShoppinSaleView: MyShoppingSaleView!
    var hotelListMenu = DropDown()
    var filteredHotelList : [String] = []
    var tempHotelMenu : [String] = []
    var isFilteredTextEmpty = true
    var hotelList : [GetHotelsMobileResponseModel] = []
    var hotelId = 0
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
        let getHotelsMobileRequestModel = GetHotelsMobileRequestModel.init(userId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetHotelsMobie, method: .get, parameters: getHotelsMobileRequestModel.requestPathString()) { (response : [GetHotelsMobileResponseModel] ) in
            if response.count > 0 {
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                self.hotelList = response
                for item in self.hotelList {
                    self.tempHotelMenu.append(item.text ?? "")
                }
                self.hotelListMenu.dataSource = self.tempHotelMenu
                self.hotelListMenu.dataSource.insert("", at: 0)
                self.hotelListMenu.backgroundColor = UIColor.grayColor
                self.hotelListMenu.separatorColor = UIColor.gray
                self.hotelListMenu.textColor = .white
                self.hotelListMenu.anchorView = self.viewMyShoppinSaleView.viewHotelListView
                self.hotelListMenu.topOffset = CGPoint(x: 0, y:-(self.hotelListMenu.anchorView?.plainView.bounds.height)!)
                
            }else{
                print("data has not recived")
            }
        }
        self.hotelListMenu.selectionAction = { index, title in
            self.viewMyShoppinSaleView.viewHotelListView.mainLabel.text = title
            let filteredHotelList = self.hotelList.filter{($0.text?.contains(title) ?? false)}
            for item in filteredHotelList {
                self.hotelId = item.value ?? 0
            }
        }
        
        let hotelListTapgesture = UITapGestureRecognizer(target: self, action: #selector(didTouchHotelListMenu))
        hotelListTapgesture.numberOfTouchesRequired = 1
        self.viewMyShoppinSaleView.viewHotelListView.addGestureRecognizer(hotelListTapgesture)
        self.viewMyShoppinSaleView.searchBar.delegate = self
        self.createBeginDatePicker()
        self.createEndDatePicker()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewMyShoppinSaleView.searchBar.endEditing(true)
    }
    
    @objc func didTouchHotelListMenu() {
        self.hotelListMenu.show()
        self.hotelListMenu.direction = .bottom
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
        print(formatter.string(from: self.beginDatePicker.date))
        self.beginDate = formatter.string(from: self.beginDatePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        self.viewMyShoppinSaleView.viewBeginDate.mainText.text = "\(formatter.string(from: self.beginDatePicker.date))"
        self.viewMyShoppinSaleView.endEditing(true)
       
    }
    
    @objc func endDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.endDatePicker.date))
        self.endDate = formatter.string(from: self.endDatePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        self.viewMyShoppinSaleView.viewEndDate.mainText.text = "\(formatter.string(from: self.endDatePicker.date))"
        self.viewMyShoppinSaleView.endEditing(true)
       
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let myTourSaleRequestModel = GetShoppingSaleRequestModel.init(begindate: self.beginDate, guideId: userDefaultsData.getGuideId(), endDate: self.endDate, hotelId: self.hotelId)
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

extension MyShoppingSaleViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredHotelList = []
        if searchText.elementsEqual(""){
            self.isFilteredTextEmpty = true
            self.hotelListMenu.dataSource = self.tempHotelMenu
            self.hotelListMenu.dataSource.insert("", at: 0)
        }else {
            self.hotelListMenu.dataSource = self.tempHotelMenu
            self.isFilteredTextEmpty = false
            for item in self.hotelListMenu.dataSource{
                if item.description.lowercased().contains(searchText.lowercased()){
                    self.filteredHotelList.append(item)
                    self.hotelListMenu.dataSource = self.filteredHotelList
                    self.hotelListMenu.dataSource.insert("", at: 0)
                }else {
                    self.hotelListMenu.dataSource = self.filteredHotelList
                }
                self.hotelListMenu.dataSource.insert("", at: 0)
            }
        }
    }
}
