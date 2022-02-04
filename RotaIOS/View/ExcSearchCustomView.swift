//
//  ExcSearchCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 17.11.2021.
//

import Foundation
import UIKit
import DropDown
import Alamofire

protocol ExcSearchDelegate {
    func hotelorMarketChange( isChange : Bool)
}

class ExcSearchCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewTourBeginDate: MainTextCustomView!
    @IBOutlet weak var viewTourEndDate: MainTextCustomView!
    @IBOutlet weak var viewMarketList: MainTextCustomView!
    @IBOutlet weak var viewHotelList: MainTextCustomView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewChecBoxView: CheckBoxView!
    @IBOutlet weak var viewPromotionMenu: MainTextCustomView!
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    var marketMenu = DropDown()
    var hotelMenu = DropDown()
    var promotionMenu = DropDown()
    var hotelList : [GetHotelsMobileResponseModel] = []
    var marketList : [GetGuideMarketResponseModel] = []
    var filteredMarketList : [GetGuideMarketResponseModel] = []
    var filteredHotelList : [GetHotelsMobileResponseModel] = []
    var excurSearchDelegate : ExcSearchDelegate?
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
    var promotionid = 0
    var promotionIdStringType = ""
    var promotionList : [GetPromotionResponseModel] = []
    var filteredPromotionList  : [GetPromotionResponseModel] = []
    var tempPromotionMenu : [String] = []
    
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
        self.viewPromotionMenu.headerLAbel.text = "Promotion"
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
        
        // put one week to begin date
        let formatterBeginDate = DateFormatter()
        formatterBeginDate.dateStyle = .medium
        formatterBeginDate.timeStyle = .none
        formatterBeginDate.dateFormat = "MM-dd-yyyy"
        print(formatterBeginDate.string(from: self.beginDatePicker.date))
        self.beginDateString = formatterBeginDate.string(from: self.beginDatePicker.date)
        formatterBeginDate.dateFormat = "dd-MM-yyyy"
        self.viewTourBeginDate.mainText.text = "\(formatterBeginDate.string(from: self.beginDatePicker.date))"
        
        // put one week to end date
        
        let calendar = Calendar.current
        let addOneWeekToCurrentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: Date())
        
        let formatterEndDate = DateFormatter()
        formatterEndDate.dateStyle = .medium
        formatterEndDate.timeStyle = .none
        formatterEndDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatterEndDate.dateFormat = "MM-dd-yyyy"
        print(formatterEndDate.string(from: addOneWeekToCurrentDate!))
        self.endDateString = formatterEndDate.string(from:  addOneWeekToCurrentDate!)
        formatterEndDate.dateFormat = "dd-MM-yyyy"
        self.viewTourEndDate.mainText.text = "\(formatterEndDate.string(from:  addOneWeekToCurrentDate!))"
        ///
        ///
        if Connectivity.isConnectedToInternet {
             print("Connected")
            if userDefaultsData.getTourSalePost()?.count ?? 0 > 0 {
                let alert = UIAlertController.init(title: "Warning", message: "Please send Offline Sales first", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                if let topVC = UIApplication.getTopViewController() {
                    topVC.present(alert, animated: true, completion: nil)
                }
                return
            }
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
            let gesturePromotion = UITapGestureRecognizer(target: self, action: #selector(didTapPromotionMenu))
            gestureHotel.numberOfTouchesRequired = 1
            self.viewMarketList.addGestureRecognizer(gestureMarket)
            self.viewHotelList.addGestureRecognizer(gestureHotel)
            self.viewPromotionMenu.addGestureRecognizer(gesturePromotion)
            
            self.marketMenu.topOffset = CGPoint(x: 0, y:-(self.marketMenu.anchorView?.plainView.bounds.height ?? 200))
            self.marketMenu.selectionAction = { index, title in
                if title != self.viewMarketList.mainLabel.text {
                    self.excurSearchDelegate?.hotelorMarketChange(isChange: true)
                }
                self.viewMarketList.mainLabel.text = title
                let filtered = self.marketList.filter{($0.text?.contains(title) ?? false)}
                self.filteredMarketList = filtered
                for listofarray in self.filteredMarketList {
                    userDefaultsData.saveMarketId(marketId: listofarray.value ?? 0)
                    self.marketIdStringType = String(listofarray.value ?? 0)
                    //   userDefaultsData.saveMarketGroupId(marketId: listofarray.id ?? "") // silinecek
                }
                self.promotionMenuCall()
            }
            
            self.hotelMenu.selectionAction = { index, title in
                if title != self.viewHotelList.mainLabel.text {
                    self.excurSearchDelegate?.hotelorMarketChange(isChange: true)
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
                self.promotionMenuCall()            }
            
            self.viewMarketList.headerLAbel.text = "Market"
            self.viewHotelList.headerLAbel.text = "Hotel"
            self.viewChecBoxView.checkBoxViewDelegate = self
            self.viewChecBoxView.imageCheck.isHidden = false
            print("tarih=\(userDefaultsData.getSaleDate() ?? "")")
        
         } else {
            if let topVC = UIApplication.getTopViewController() {
                let alert = UIAlertController.init(title: "Notice", message: "There Is No Internet Connection", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                topVC.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func promotionMenuCall(){
        let getPromotionRequestModel = GetPromotionRequestModel.init(hotelId: userDefaultsData.getHotelId() , marketId: userDefaultsData.getMarketId(), tourSaleDate: userDefaultsData.getSaleDate() ?? "", tourStartDate: self.beginDateString, tourEndDate: self.endDateString)
        
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetTourSalePromotions, method: .get, parameters: getPromotionRequestModel.requestPathString()) { (response : [GetPromotionResponseModel] ) in
            if response.count > 0 {
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                self.promotionMenu.dataSource = []
                self.promotionList = response
                for listOfArray in self.promotionList {
                    self.promotionMenu.dataSource.append(listOfArray.text ?? "")
                }
                self.promotionMenu.dataSource.insert("", at: 0)
                self.promotionMenu.backgroundColor = UIColor.grayColor
                self.promotionMenu.separatorColor = UIColor.gray
                self.promotionMenu.textColor = .white
                self.promotionMenu.anchorView = self.viewPromotionMenu
                self.promotionMenu.topOffset = CGPoint(x: 0, y:-(self.promotionMenu.anchorView?.plainView.bounds.height)!)
            }else{
                print("data has not recived")
            }
        }
        
        self.promotionMenu.selectionAction = { index, title in
            if title != self.viewPromotionMenu.mainLabel.text {
                self.excurSearchDelegate?.hotelorMarketChange(isChange: true)
            }
            self.viewPromotionMenu.mainLabel.text = title
            let filtered = self.promotionList.filter{($0.text?.contains(title) ?? false)}
            self.filteredPromotionList = filtered
            for listofArray in self.filteredPromotionList {
                userDefaultsData.savePromotionId(promotionId: listofArray.value ?? 0)
                self.promotionid = listofArray.value ?? 0
                self.promotionIdStringType = String(listofArray.value ?? 0)
            }
        }
    }
    
    @objc func didTapMarketMenu() {
        self.marketMenu.show()
    }
    
    @objc func didTapHotelMenu() {
        self.hotelMenu.show()
        self.hotelMenu.direction = .top
    }
    
    @objc func didTapPromotionMenu() {
        self.promotionMenu.show()
        self.promotionMenu.direction = .bottom
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
