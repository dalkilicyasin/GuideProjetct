//
//  ExcSearchCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 17.11.2021.
//

import Foundation
import UIKit
import DropDown

class ExcSearchCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewTourBeginDate: MainTextCustomView!
    @IBOutlet weak var viewTourEndDate: MainTextCustomView!
    @IBOutlet weak var viewMarketList: MainTextCustomView!
    @IBOutlet weak var viewHotelList: MainTextCustomView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewChecBoxView: CheckBoxView!
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    var marketMenu = DropDown()
    var hotelMenu = DropDown()
    var hotelList : [GetHotelsMobileResponseModel] = []
    var marketList : [GetGuideMarketResponseModel] = []
    var filteredMarketList : [GetGuideMarketResponseModel] = []
    var filteredHotelList : [GetHotelsMobileResponseModel] = []
    var hotelPageDlegate : HotelPageDelegate?
    var tempHotelMenu : [String] = []
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
    let beginDateToolBar = UIToolbar()
    let endDateToolBar = UIToolbar()
    var beginDateString = ""
    var endDateString = ""
    var marketIdStringType = ""
    var hotelIdStringType = ""
    var areaIdStringType = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ExcSearchCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.viewMainView.backgroundColor = UIColor.grayColor
        self.viewTourBeginDate.headerLAbel.text = "Tour Begin Date"
        self.viewTourEndDate.headerLAbel.text = "Tour End Date"
        self.viewMarketList.headerLAbel.text = "Market"
        self.viewHotelList.headerLAbel.text = "Hotels"
        self.viewChecBoxView.imageCheck.isHidden = false
        
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
        self.viewTourBeginDate.mainLabel.isHidden = true
        self.viewTourBeginDate.imageMainText.isHidden = true
        self.viewTourBeginDate.mainText.isHidden = false
        self.viewTourEndDate.mainLabel.isHidden = true
        self.viewTourEndDate.imageMainText.isHidden = true
        self.viewTourEndDate.mainText.isHidden = false
        self.createbeginDatePicker()
        self.createEndDatePicker()
        
        let getMarketRequestModel = GetGuideMarketRequestModel.init(userId: userDefaultsData.getGuideId())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetGuideMarkets, method: .get, parameters: getMarketRequestModel.requestPathString()) { (response : [GetGuideMarketResponseModel] ) in
            if response.count > 0 {
                self.marketList = response
                for listOfArray in self.marketList {
                    self.marketMenu.dataSource.append(listOfArray.text ?? "")
                }
                self.marketMenu.dataSource.insert("", at: 0)
                self.marketMenu.backgroundColor = UIColor.grayColor
                self.marketMenu.separatorColor = UIColor.gray
                self.marketMenu.textColor = .white
                self.marketMenu.anchorView = self.viewMarketList
            }else{
                print("data has not recived")
            }
        }
        
        // Burda bunu çağırmamın sebebi; Güliz, rotam-20 de, eğer rehbere atanmış bir otel yok ise checkbox seçili gelsin ve oteller otomatik listelensin demesinden dolayıdır. Rehbere atanmış otelin olup olmadığını öğrenmek içim  ise guidehotel in 1 olması şartı var.
        
        let getHotelsMobileRequestModel = GetHotelsMobileRequestModel.init(userId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetHotelsMobie, method: .get, parameters: getHotelsMobileRequestModel.requestPathString()) { (response : [GetHotelsMobileResponseModel] ) in
            if response.count > 0 {
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                self.hotelList = response
                self.tempHotelMenu.removeAll()
                let filtered = response.filter({return ($0.guideHotel != 0)})
                print("\(filtered)")
                if response[0].guideHotel != 0 {
                    self.viewChecBoxView.imageCheck.isHidden = true
                    self.viewChecBoxView.isCheckRemember = false
                    self.hotelList = filtered
                    for listofArray in self.hotelList {
                        self.tempHotelMenu.append(listofArray.text ?? "")
                    }
                    self.hotelMenu.dataSource = self.tempHotelMenu
                    self.hotelMenu.dataSource.insert("", at: 0)
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.viewHotelList
                    self.hotelMenu.topOffset = CGPoint(x: 0, y:-(self.hotelMenu.anchorView?.plainView.bounds.height)!)
                }else{
                    self.viewChecBoxView.imageCheck.isHidden = false
                    self.viewChecBoxView.isCheckRemember = true
                    for listofArray in self.hotelList {
                        self.tempHotelMenu.append(listofArray.text ?? "")
                    }
                    self.hotelMenu.dataSource = self.tempHotelMenu
                    self.hotelMenu.dataSource.insert("", at: 0)
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.viewHotelList
                    self.hotelMenu.topOffset = CGPoint(x: 0, y:-(self.hotelMenu.anchorView?.plainView.bounds.height)!)
                }
            }else{
                print("data has not recived")
            }
        }
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
        self.searchBar.delegate = self
        let gestureMarket = UITapGestureRecognizer(target: self, action: #selector(didTapMarketMenu))
        gestureMarket.numberOfTouchesRequired = 1
        let gestureHotel = UITapGestureRecognizer(target: self, action: #selector(didTapHotelMenu))
        gestureHotel.numberOfTouchesRequired = 1
        self.viewMarketList.addGestureRecognizer(gestureMarket)
        self.viewHotelList.addGestureRecognizer(gestureHotel)
        self.marketMenu.topOffset = CGPoint(x: 0, y:-(self.marketMenu.anchorView?.plainView.bounds.height ?? 200))
        
        self.marketMenu.selectionAction = { index, title in
            if title != self.viewMarketList.mainLabel.text {
                self.hotelPageDlegate?.hotelPage(isChange: true)
            }
            self.viewMarketList.mainLabel.text = title
            let filtered = self.marketList.filter{($0.text?.contains(title) ?? false)}
            self.filteredMarketList = filtered
            for listofarray in self.filteredMarketList {
                userDefaultsData.saveMarketId(marketId: listofarray.value ?? 0)
                self.marketIdStringType = String(listofarray.value ?? 0)
                //   userDefaultsData.saveMarketGroupId(marketId: listofarray.id ?? "") // silinecek
            }
        }
        
        self.hotelMenu.selectionAction = { index, title in
            if title != self.viewHotelList.mainLabel.text {
                self.hotelPageDlegate?.hotelPage(isChange: true)
            }
            self.viewHotelList.mainLabel.text = title
            let filtered = self.hotelList.filter{($0.text?.contains(title) ?? false)}
            self.filteredHotelList = filtered
            for listofArray in self.filteredHotelList {
                userDefaultsData.saveHotelId(hotelId: listofArray.value ?? 0)
                userDefaultsData.saveHotelArea(hotelAreaId: listofArray.area ?? 0)
                self.hotelIdStringType = String(listofArray.value ?? 0)
                self.areaIdStringType = String(listofArray.area ?? 0)
            }
        }
        self.viewMarketList.headerLAbel.text = "Market"
        self.viewHotelList.headerLAbel.text = "Hotel"
        self.viewChecBoxView.checkBoxViewDelegate = self
        self.viewChecBoxView.imageCheck.isHidden = false
        print("tarih=\(userDefaultsData.getSaleDate() ?? "")")
    }
    
    @objc func didTapMarketMenu() {
        self.marketMenu.show()
    }
    
    @objc func didTapHotelMenu() {
        self.hotelMenu.show()
        self.hotelMenu.direction = .top
    }
    
    func createbeginDatePicker() {
        self.viewTourBeginDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(beginDatePickerDonePressed))
        self.beginDateToolBar.setItems([doneButton], animated: true)
        self.beginDateToolBar.sizeToFit()
        self.viewTourBeginDate.mainText.inputAccessoryView = self.beginDateToolBar
        self.viewTourBeginDate.mainText.inputView = self.beginDatePicker
        self.beginDatePicker.datePickerMode = .date
    }
    
    @objc func beginDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.beginDatePicker.date))
        self.beginDateString = formatter.string(from: self.beginDatePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        self.viewTourBeginDate.mainText.text = "\(formatter.string(from: self.beginDatePicker.date))"
        self.viewMainView.endEditing(true)
    }
    
    func createEndDatePicker() {
        self.viewTourEndDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(endDatePickerDonePressed))
        self.endDateToolBar.setItems([doneButton], animated: true)
        self.endDateToolBar.sizeToFit()
        self.viewTourEndDate.mainText.inputAccessoryView = self.endDateToolBar
        self.viewTourEndDate.mainText.inputView = self.endDatePicker
        self.endDatePicker.datePickerMode = .date
    }
    
    @objc func endDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.endDatePicker.date))
        self.endDateString = formatter.string(from: endDatePicker.date)
        formatter.dateFormat = "dd-MM-yyyy"
        self.viewTourEndDate.mainText.text = "\(formatter.string(from: self.endDatePicker.date))"
        self.viewMainView.endEditing(true)
    }
}
extension ExcSearchCustomView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = []
        if searchText.elementsEqual(""){
            self.isFilteredTextEmpty = true
            self.hotelMenu.dataSource = self.tempHotelMenu
        }else {
            self.hotelMenu.dataSource = self.tempHotelMenu
            self.isFilteredTextEmpty = false
            for data in self.hotelMenu.dataSource{
                if data.description.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                    self.hotelMenu.dataSource = self.filteredData
                }
            }
        }
    }
}

extension ExcSearchCustomView : CheckBoxViewDelegate {
    func checkBoxTapped(isremember: Bool) {
        let getHotelsMobileRequestModel = GetHotelsMobileRequestModel.init(userId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetHotelsMobie, method: .get, parameters: getHotelsMobileRequestModel.requestPathString()) { (response : [GetHotelsMobileResponseModel] ) in
            if response.count > 0 {
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                self.tempHotelMenu.removeAll()
                if isremember == true{
                    self.hotelList = response
                    for item in self.hotelList {
                        self.tempHotelMenu.append(item.text ?? "")
                    }
                    self.hotelMenu.dataSource = self.tempHotelMenu
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.viewHotelList
                    self.hotelMenu.topOffset = CGPoint(x: 0, y:-(self.hotelMenu.anchorView?.plainView.bounds.height)!)
                }else if isremember == false {
                    let filtered = response.filter({return ($0.guideHotel != 0)})
                    print("\(filtered)")
                    self.hotelList = filtered
                    for item in self.hotelList {
                        self.tempHotelMenu.append(item.text ?? "")
                    }
                    self.hotelMenu.dataSource = self.tempHotelMenu
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.viewHotelList
                    self.hotelMenu.topOffset = CGPoint(x: 0, y:-(self.hotelMenu.anchorView?.plainView.bounds.height)!)
                }
            }else{
                print("data has not recived")
            }
        }
    }
}