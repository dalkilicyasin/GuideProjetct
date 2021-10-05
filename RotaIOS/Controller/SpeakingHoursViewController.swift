//
//  SpeakingHoursViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 14.09.2021.
//

import UIKit
import DropDown

class SpeakingHoursViewController: UIViewController {
    @IBOutlet var viewSpeakingHoursView: SpeakingHoursView!
    var areaList : [AreaSelect] = []
    var areaListMenu = DropDown()
    var areaNameList : [String] = []
    var areaFilteredList : [AreaSelect] = []
    var areaId = ""
    var filteredData : [String] = []
    var isFilteredTextEmpty = true
    var hotelList : [GetHotelSelectListByAreaRefResponseModel] = []
    var hotelListMenu = DropDown()
    var hotelNameList : [String] = []
    var hotelFilteredList : [GetHotelSelectListByAreaRefResponseModel] = []
    var hotelId = 0
    var hotelIdStringType = ""
    var guideList : [GuideGetSelectListResponseModel] = []
    var guideListMenu = DropDown()
    var guideNameList : [String] = []
    var guideFilteredList : [GuideGetSelectListResponseModel] = []
    var guideId = 0
    var currentDate = ""
    var speakingHoursList : [GetSpeakTimeForMobileResponseModel] = []
    let currentDateToolBar = UIToolbar()
    var currentDatePicker: UIDatePicker = {
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
        self.viewSpeakingHoursView.searchHotel.delegate = self
        self.viewSpeakingHoursView.searchGuide.delegate = self
        
        let getAreaListRequestModel = GetGuideInfoRequestModel.init(id: userDefaultsData.getGuideId())
        NetworkManager.sendGetRequest(url: NetworkManager.BASEURL, endPoint:.GetGuideInfo, method: .get, parameters: getAreaListRequestModel.requestPathString()) { (response : GetGuideInfoResponseModel) in
            if response.gDE_ID != nil {
                self.areaList = response.areaSelect ?? self.areaList
                for item in self.areaList {
                    self.areaNameList.append(item.text ?? "")
                }
                self.areaListMenu.dataSource = self.areaNameList
                self.areaListMenu.dataSource.insert("", at: 0)
                self.areaListMenu.backgroundColor = UIColor.grayColor
                self.areaListMenu.separatorColor = UIColor.gray
                self.areaListMenu.textColor = .white
                self.areaListMenu.anchorView = self.viewSpeakingHoursView.viewRegion
                self.areaListMenu.topOffset = CGPoint(x: 0, y:-((self.areaListMenu.anchorView?.plainView.bounds.height)! - 80))
            }else{
                print("arealist data has not recived")
            }
        }
        self.areaListMenu.selectionAction = {index, item in
            self.viewSpeakingHoursView.viewRegion.mainLabel.text = item
            self.areaId = ""
            let filtered = self.areaList.filter{($0.text?.contains(item)) ?? false}
            self.areaFilteredList = filtered
            for item in self.areaFilteredList {
                self.areaId = item.id ?? ""
            }
            if self.areaId != "" {
                let getHotelSelectListRequestModel = GetHotelSelectListByAreaRefRequestModel.init(areaId: self.areaId)
                NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint: .GetHotelSelectListByAreaRef , method: .get, parameters: getHotelSelectListRequestModel.requestPathString()) {(response : [GetHotelSelectListByAreaRefResponseModel]) in
                   if  response.count > 0 {
                    self.hotelList = response
                    for item in self.hotelList {
                        self.hotelNameList.append(item.text ?? "")
                    }
                    self.hotelListMenu.dataSource = self.hotelNameList
                    self.hotelListMenu.dataSource.insert("", at: 0)
                    self.hotelListMenu.backgroundColor = UIColor.grayColor
                    self.hotelListMenu.separatorColor = UIColor.gray
                    self.hotelListMenu.textColor = .white
                    self.hotelListMenu.anchorView = self.viewSpeakingHoursView.viewHotel
                    self.hotelListMenu.topOffset = CGPoint(x: 0, y:-((self.hotelListMenu.anchorView?.plainView.bounds.height)! - 80))
                   }else {
                    print("hotellist data has not recived")
                   }
                }
            }else {
                self.hotelListMenu.dataSource.removeAll()
                self.hotelListMenu.dataSource.insert("", at: 0)
            }
        }
        self.hotelListMenu.selectionAction = { index , item in
            self.viewSpeakingHoursView.viewHotel.mainLabel.text = item
            self.hotelId = 0
            let filtered = self.hotelList.filter{($0.text?.contains(item)) ?? false}
            self.hotelFilteredList = filtered
            for item in self.hotelFilteredList {
                self.hotelId = item.value ?? 0
            }
            if self.hotelId == 0 {
                self.hotelIdStringType = ""
            }else {
                self.hotelIdStringType = String(self.hotelId)
            }
        }
        
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint: .GetGuideSelectList, method:.get, parameters: "") { (response : [GuideGetSelectListResponseModel]) in
            if response.count > 0 {
                self.guideList = response
                for item in self.guideList {
                    self.guideNameList.append(item.text ?? "")
                }
                self.guideListMenu.dataSource = self.guideNameList
                self.guideListMenu.dataSource.insert("", at: 0)
                self.guideListMenu.backgroundColor = UIColor.grayColor
                self.guideListMenu.separatorColor = UIColor.gray
                self.guideListMenu.textColor = .white
                self.guideListMenu.anchorView = self.viewSpeakingHoursView.viewGuide
                self.guideListMenu.topOffset = CGPoint(x: 0, y:-((self.guideListMenu.anchorView?.plainView.bounds.height)! - 80))
            }else{
                print("guidelist data has not recived")
            }
        }
        self.guideListMenu.selectionAction = { index , item in
            self.viewSpeakingHoursView.viewGuide.mainLabel.text = item
            let filtered = self.guideList.filter{($0.text?.contains(item)) ?? false}
            self.guideFilteredList = filtered
            for item in self.guideFilteredList {
                self.guideId = item.value ?? 0
            }
        }
       
        self.createCurrentDatePicker()
        
        let tapGestureArea = UITapGestureRecognizer(target: self, action: #selector(tappedAreaListMenu))
        self.viewSpeakingHoursView.viewRegion.addGestureRecognizer(tapGestureArea)
        
        let tapGestureHotel = UITapGestureRecognizer(target: self, action: #selector(tappedHotelListMenu))
        self.viewSpeakingHoursView.viewHotel.addGestureRecognizer(tapGestureHotel)
        
        let tapGestureGuide = UITapGestureRecognizer(target: self, action: #selector(tappedGuideListMenu))
        self.viewSpeakingHoursView.viewGuide.addGestureRecognizer(tapGestureGuide)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewSpeakingHoursView.searchHotel.endEditing(true)
        self.viewSpeakingHoursView.searchGuide.endEditing(true)
    }
    
    func createCurrentDatePicker() {
        self.viewSpeakingHoursView.viewDate.mainText.textAlignment = .left
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(currentDatePickerDonePressed))
        self.currentDateToolBar.setItems([doneButton], animated: true)
        self.currentDateToolBar.sizeToFit()
        self.viewSpeakingHoursView.viewDate.mainText.inputAccessoryView = self.currentDateToolBar
        self.viewSpeakingHoursView.viewDate.mainText.inputView = self.currentDatePicker
        self.currentDatePicker.datePickerMode = .date
    }
    
    @objc func currentDatePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        print(formatter.string(from: self.currentDatePicker.date))
        self.currentDate = formatter.string(from: self.currentDatePicker.date)
        formatter.dateFormat = "dd-MM-yyy"
        self.viewSpeakingHoursView.viewDate.mainText.text = "\(formatter.string(from: self.currentDatePicker.date))"
        self.viewSpeakingHoursView.endEditing(true)
    }
    
    @objc func tappedAreaListMenu() {
        self.areaListMenu.direction = .top
        self.areaListMenu.show()
    }
    
    @objc func tappedHotelListMenu() {
        self.hotelListMenu.direction = .bottom
        self.hotelListMenu.show()
    }
    
    @objc func tappedGuideListMenu() {
        self.guideListMenu.direction = .bottom
        self.guideListMenu.show()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        let getSpeakTimeRequestModel = GetSpeakTimeForMobileRequestModel.init(HotelId: String(self.hotelIdStringType), date: self.currentDate , guideId: String(self.guideId), areaId: self.areaId)
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint: .GetSpeakTimeForMobile, method: .get, parameters: getSpeakTimeRequestModel.requestPathString()) { (response : [GetSpeakTimeForMobileResponseModel]) in
            if response.count > 0 {
                self.speakingHoursList = response
                self.otiPushViewController(viewController: SpeakingHoursDetailViewController.init(tourDetailListInDetailPage: self.speakingHoursList))
            }else{
                let alert = UIAlertController(title: "Error", message: "Sorry, Cannot find SH", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension SpeakingHoursViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = []
        if self.viewSpeakingHoursView.searchHotel.text?.isEmpty == false {
            if searchText.elementsEqual(""){
                self.isFilteredTextEmpty = true
                self.hotelListMenu.dataSource = self.hotelNameList
                self.hotelListMenu.dataSource.insert("", at: 0)
            }else {
                self.hotelListMenu.dataSource = self.hotelNameList
                self.isFilteredTextEmpty = false
                for data in self.hotelListMenu.dataSource{
                    if data.description.lowercased().contains(searchText.lowercased()){
                        self.filteredData.append(data)
                        self.hotelListMenu.dataSource = self.filteredData
                    }else {
                        self.hotelListMenu.dataSource = self.filteredData
                    }
                }
                self.hotelListMenu.dataSource.insert("", at: 0)
            }
        }else if self.viewSpeakingHoursView.searchGuide.text?.isEmpty == false {
            if searchText.elementsEqual(""){
                self.isFilteredTextEmpty = true
                self.guideListMenu.dataSource = self.guideNameList
                self.guideListMenu.dataSource.insert("", at: 0)
            }else {
                self.guideListMenu.dataSource = self.guideNameList
                self.isFilteredTextEmpty = false
                for data in self.guideListMenu.dataSource{
                    if data.description.lowercased().contains(searchText.lowercased()){
                        self.filteredData.append(data)
                        self.guideListMenu.dataSource = self.filteredData
                    }
                }
                self.guideListMenu.dataSource.insert("", at: 0)
            }
        }
    }
}

