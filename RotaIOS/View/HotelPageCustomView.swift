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
    var hotelList : [String] = []
    var regionList : [String] = []
    var marketIdList : [String] = []
    var hotelIdList : [String] = []
    let hotelMenu = DropDown()
  
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
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .HotelPage, method: .get, parameters: getMarketRequestModel.requestPathString()) { (response : [GetGuideMarketResponseModel] ) in
            
            if response.count > 0 {
                print(response)
                
                for listOfArray in response {
                    self.regionList.append(listOfArray.text ?? "default")
                    self.hotelIdList.append(listOfArray.id ?? "")
                    
                }
                
                print(self.hotelIdList)
                
                self.marketMenu.dataSource = self.regionList
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
            print(title)
            let tempIndex : Int
            tempIndex = index+1
            print(tempIndex)
            userDefaultsData.saveMarketId(marketId: String(tempIndex))
        }
        
        self.hotelMenu.selectionAction = { index, title in
            self.hotelMainTextSecondCustomView.mainLabel.text = title
            let tempIndex : Int
            tempIndex = index+1
            print(tempIndex)
            userDefaultsData.saveHotelId(hotelId: String(tempIndex))
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
            self.filteredData = hotelList
            
        }else {
            self.isFilteredTextEmpty = false
            for data in hotelList{
                if data.description.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                    self.hotelMenu.dataSource = filteredData
                    
                }
            }
        }
    }
}

extension HotelPageCustomView : CheckBoxViewDelegate {
    func checkBoxTapped(isremember: Bool) {
        if isremember == true {
            let getHotelsMobileRequestModel = GetHotelsMobileRequestModel.init(userId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
            NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetHotelsMobie, method: .get, parameters: getHotelsMobileRequestModel.requestPathString()) { (response : [GetHotelsMobileResponseModel] ) in
                
                if response.count > 0 {
                    print(response)
                    
                    for listOfArray in response {
                        self.hotelList.append(listOfArray.text ?? "default")
                    }
                    
                    self.hotelMenu.dataSource = self.hotelList
                    self.hotelMenu.backgroundColor = UIColor.grayColor
                    self.hotelMenu.separatorColor = UIColor.gray
                    self.hotelMenu.textColor = .white
                    self.hotelMenu.anchorView = self.hotelMainTextSecondCustomView.mainLabel
                }else{
                    print("data has not recived")
                }
            }
        }else {
            
            self.hotelMenu.dataSource = ["Hotel1"]
            self.hotelMenu.backgroundColor = UIColor.grayColor
            self.hotelMenu.separatorColor = UIColor.gray
            self.hotelMenu.textColor = .white
            self.hotelMenu.anchorView = self.hotelMainTextSecondCustomView
        
        }
    }
    
    
}


