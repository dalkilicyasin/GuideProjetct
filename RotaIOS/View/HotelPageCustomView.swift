//
//  HotelPageCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 21.04.2021.
//

import Foundation

import UIKit
import DropDown

class HotelPageCustomView : UIView {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var marketMainTextCustomView: MainTextCustomView!
    @IBOutlet weak var hotelMainTextSecondCustomView: MainTextCustomView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    var marketMenu = DropDown()
    var hotelMenu = DropDown()
    var hotelList : [GetHotelsMobileResponseModel] = []
    var marketList : [GetGuideMarketResponseModel] = []
    var filteredMarketList : [GetGuideMarketResponseModel] = []
    var filteredHotelList : [GetHotelsMobileResponseModel] = []
    
    @IBOutlet weak var checkBoxView: CheckBoxView!
    
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
        self.headerView.addCustomContainerView(self)
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        let getMarketRequestModel = GetGuideMarketRequestModel.init(userId: userDefaultsData.getGuideId())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetGuideMarkets, method: .get, parameters: getMarketRequestModel.requestPathString()) { (response : [GetGuideMarketResponseModel] ) in
            
            if response.count > 0 {
                
                self.marketList = response
                
                for listOfArray in self.marketList {
                    self.marketMenu.dataSource.append(listOfArray.text ?? "")
                   
                }
                self.marketMenu.backgroundColor = UIColor.grayColor
                self.marketMenu.separatorColor = UIColor.gray
                self.marketMenu.textColor = .white
                self.marketMenu.anchorView = self.marketMainTextCustomView.mainLabel
                
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
        gesture.numberOfTouchesRequired = 1
        
        let secondGesture = UITapGestureRecognizer(target: self, action: #selector(didSecondItemTapped))
        secondGesture.numberOfTouchesRequired = 1
        secondGesture.numberOfTouchesRequired = 1
        
        self.marketMainTextCustomView.addGestureRecognizer(gesture)
        self.hotelMainTextSecondCustomView.addGestureRecognizer(secondGesture)
        
        self.marketMenu.selectionAction = { index, title in
            self.marketMainTextCustomView.mainLabel.text = title
            let filtered = self.marketList.filter{($0.text?.contains(title) ?? false)}
            self.filteredMarketList = filtered
            for listofarray in self.filteredMarketList {
                userDefaultsData.saveMarketId(marketId: listofarray.value ?? 0)
             //   userDefaultsData.saveMarketGroupId(marketId: listofarray.id ?? "") // silinecek
            }
        }
        
        self.hotelMenu.selectionAction = { index, title in
            self.hotelMainTextSecondCustomView.mainLabel.text = title
            
            let filtered = self.hotelList.filter{($0.text?.contains(title) ?? false)}
            self.filteredHotelList = filtered
            for listofArray in self.filteredHotelList {
                userDefaultsData.saveHotelId(hotelId: listofArray.value ?? 0)
                userDefaultsData.saveHotelArea(hotelAreaId: listofArray.area ?? 0)
            }
            
        }
        
        self.marketMainTextCustomView.headerLAbel.text = "Market"
        self.hotelMainTextSecondCustomView.headerLAbel.text = "Hotel"
        
        self.checkBoxView.checkBoxViewDelegate = self
        
        print("tarih=\(userDefaultsData.getSaleDate() ?? "")")
    }
    
    @objc func didTappedItem() {
        marketMenu.show()
        
    }
    
    @objc func didSecondItemTapped() {
        hotelMenu.show()
    }
}

extension HotelPageCustomView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredData = []
        
        if searchText.elementsEqual(""){
            self.isFilteredTextEmpty = true
            self.hotelMenu.dataSource = self.filteredData
            
            
        }else {
            self.isFilteredTextEmpty = false
            for data in self.hotelMenu.dataSource{
                if data.description.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                    self.hotelMenu.dataSource = filteredData
                    
                }
            }
        }
        for listofhotel in self.hotelList {
            self.hotelMenu.dataSource.append(listofhotel.text ?? "")
        }
    }
    
}

extension HotelPageCustomView : CheckBoxViewDelegate {
    func checkBoxTapped(isremember: Bool) {
        
        let getHotelsMobileRequestModel = GetHotelsMobileRequestModel.init(userId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetHotelsMobie, method: .get, parameters: getHotelsMobileRequestModel.requestPathString()) { (response : [GetHotelsMobileResponseModel] ) in
            
            if response.count > 0 {
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                if isremember {
                    
                    self.hotelList = response
                    for listOfArray in self.hotelList {
                        self.hotelMenu.dataSource.append(listOfArray.text ?? "")
                    }
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.hotelMainTextSecondCustomView.mainLabel
                    
                }else{
                    
                    self.hotelMenu.dataSource.removeAll()
                    let filtered = response.filter({return ($0.guideHotel != 0)})
                    print("\(filtered)")
                    self.hotelList = filtered
                    for listofArray in self.hotelList {
                        self.hotelMenu.dataSource.append(listofArray.text ?? "")
                    }
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.hotelMainTextSecondCustomView
                    
                }
                
            }else{
                print("data has not recived")
            }
        }     
        
    }
}




