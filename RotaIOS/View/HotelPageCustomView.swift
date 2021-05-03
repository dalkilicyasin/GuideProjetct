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
    @IBOutlet weak var mainTextCustomView: MainTextCustomView!
    @IBOutlet weak var mainTextSecondCustomView: MainTextCustomView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    
    
    var menu = DropDown()
    var regionList = ["Russia", "Turkey","Ukrain","Polland"]
    
    var hotelList = ["Xanadu Resort","Otium Family Eco","Seven Seas Hotel","Seven Seas Hotel Life"]
    let secondMenu = DropDown()
    
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
        
        let getMarketRequestModel = GetGuideMarketRequestModel.init(userId: 228)
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .HotelPage, method: .get, parameters: getMarketRequestModel.requestPathString()) { (response : [GetGuideMarketResponseModel] ) in
            
            if response.count > 0 {
                print(response)
            
            }else{
                print("data has not recived")
            }
        }
        
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        
        //searchBar.searchBarStyle = .minimal

        self.secondMenu.dataSource = hotelList
        self.secondMenu.backgroundColor = UIColor.grayColor
        self.secondMenu.separatorColor = UIColor.gray
        self.secondMenu.textColor = .white
        self.secondMenu.anchorView = mainTextSecondCustomView

        self.menu.dataSource = regionList
        self.menu.backgroundColor = UIColor.grayColor
        self.menu.separatorColor = UIColor.gray
        self.menu.textColor = .white
        self.menu.anchorView = mainTextCustomView
 
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedItem))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTouchesRequired = 1
        
        let secondGesture = UITapGestureRecognizer(target: self, action: #selector(didSecondItemTapped))
        secondGesture.numberOfTouchesRequired = 1
        secondGesture.numberOfTouchesRequired = 1
        
        self.mainTextCustomView.addGestureRecognizer(gesture)
        self.mainTextSecondCustomView.addGestureRecognizer(secondGesture)
        
        self.menu.selectionAction = { index, title in
            self.mainTextCustomView.mainLabel.text = title
            
        }
        self.secondMenu.selectionAction = { index, title in
            self.mainTextSecondCustomView.mainLabel.text = title
            
        }
        
        self.mainTextCustomView.headerLAbel.text = "Market"
        self.mainTextSecondCustomView.headerLAbel.text = "Hotel"
        
    }
    
    @objc func didTappedItem() {
        menu.show()
        
    }
    
    @objc func didSecondItemTapped() {
        secondMenu.show()
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
                }
            }
        }
}
}
