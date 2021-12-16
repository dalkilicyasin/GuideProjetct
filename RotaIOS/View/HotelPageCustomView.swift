//
//  HotelPageCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 21.04.2021.
//

import Foundation
import UIKit
import DropDown

protocol HotelPageDelegate {
    func hotelPage(isChange : Bool )
}

class HotelPageCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewMarketListView: MainTextCustomView!
    @IBOutlet weak var viewHotelListView: MainTextCustomView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewCheckBoxView: CheckBoxView!
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: HotelPageCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.viewMainView.backgroundColor = UIColor.mainViewColor
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
                self.marketMenu.anchorView = self.viewMarketListView.mainLabel
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
                    self.viewCheckBoxView.imageCheck.isHidden = true
                    self.viewCheckBoxView.isCheckRemember = false
                    self.hotelList = filtered
                    for listofArray in self.hotelList {
                        self.tempHotelMenu.append(listofArray.text ?? "")
                    }
                    self.hotelMenu.dataSource = self.tempHotelMenu
                    self.hotelMenu.dataSource.insert("", at: 0)
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.viewHotelListView
                    self.hotelMenu.topOffset = CGPoint(x: 0, y:-(self.hotelMenu.anchorView?.plainView.bounds.height)!)
                }else{
                    self.viewCheckBoxView.imageCheck.isHidden = false
                    self.viewCheckBoxView.isCheckRemember = true
                    for listofArray in self.hotelList {
                        self.tempHotelMenu.append(listofArray.text ?? "")
                    }
                    self.hotelMenu.dataSource = self.tempHotelMenu
                    self.hotelMenu.dataSource.insert("", at: 0)
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.viewHotelListView.mainLabel
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedItem))
        gesture.numberOfTouchesRequired = 1
        self.viewMarketListView.addGestureRecognizer(gesture)
        
        let secondGesture = UITapGestureRecognizer(target: self, action: #selector(didSecondItemTapped))
        secondGesture.numberOfTouchesRequired = 1
        self.viewHotelListView.addGestureRecognizer(secondGesture)
        
        self.marketMenu.topOffset = CGPoint(x: 0, y:-(self.marketMenu.anchorView?.plainView.bounds.height ?? 200))
        self.marketMenu.selectionAction = { index, title in
            if title != self.viewMarketListView.mainLabel.text {
                self.hotelPageDlegate?.hotelPage(isChange: true)
            }
            self.viewMarketListView.mainLabel.text = title
            let filtered = self.marketList.filter{($0.text?.contains(title) ?? false)}
            self.filteredMarketList = filtered
            for listofarray in self.filteredMarketList {
                userDefaultsData.saveMarketId(marketId: listofarray.value ?? 0)
                //   userDefaultsData.saveMarketGroupId(marketId: listofarray.id ?? "") // silinecek
            }
        }
        self.hotelMenu.selectionAction = { index, title in
            if title != self.viewHotelListView.mainLabel.text {
                self.hotelPageDlegate?.hotelPage(isChange: true)
            }
            self.viewHotelListView.mainLabel.text = title
            let filtered = self.hotelList.filter{($0.text?.contains(title) ?? false)}
            self.filteredHotelList = filtered
            for listofArray in self.filteredHotelList {
                userDefaultsData.saveHotelId(hotelId: listofArray.value ?? 0)
                userDefaultsData.saveHotelArea(hotelAreaId: listofArray.area ?? 0)
            }
        }
        self.viewMarketListView.headerLAbel.text = "Market"
        self.viewHotelListView.headerLAbel.text = "Hotel"
        self.viewCheckBoxView.checkBoxViewDelegate = self
        self.viewCheckBoxView.imageCheck.isHidden = false
        print("tarih=\(userDefaultsData.getSaleDate() ?? "")")
    }
    
    @objc func didTappedItem() {
        self.marketMenu.show()
    }
    
    @objc func didSecondItemTapped() {
        self.hotelMenu.show()
        self.hotelMenu.direction = .top
    }
}

extension HotelPageCustomView : UISearchBarDelegate {
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

extension HotelPageCustomView : CheckBoxViewDelegate {
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
                    self.hotelMenu.anchorView = self.viewHotelListView.mainLabel
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
                    self.hotelMenu.anchorView = self.viewHotelListView
                    self.hotelMenu.topOffset = CGPoint(x: 0, y:-(self.hotelMenu.anchorView?.plainView.bounds.height)!)
                }
            }else{
                print("data has not recived")
            }
        }
    }
}




