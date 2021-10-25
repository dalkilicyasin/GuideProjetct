//
//  AddStepCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//
import Foundation
import UIKit

protocol SendInfoDelegate {
    func sendInfo(sendinfo : String)
}

class AddStepCustomView : UIView {
    @IBOutlet weak var viewRemoveButton: UIView!
    @IBOutlet weak var viewSlideUP: UIView!
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewContentView: UIView!
    var selectedStepList : [GetSelectListResponseModel] = []
    var sendInfoDelegate : SendInfoDelegate?
    var tempStepList : GetSelectListResponseModel?
    var remember = true
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    var addedNameList : [String] = []
    var infoList : [String] = []
    var firstFavorite = ""
    var addFavoriteList : [String] = []
    var favoriteTouchList : [Bool] = []
    var filteredFavoriteTouchList : [Bool] = []
    var filteredList  : [GetSelectListResponseModel] = []
    var tempFilteredList :[GetSelectListResponseModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: AddStepCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetSelectList, method: .get, parameters: "") { (response : [GetSelectListResponseModel] ) in
            
            if response.count > 0 {
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                self.selectedStepList = response
                for item in self.selectedStepList {
                    self.addedNameList.append(item.text ?? "")
                }
                // düzenleme yapılıyor
                for index in 0...self.selectedStepList.count - 1{
                    self.selectedStepList[index].isTapped = false
                    self.favoriteTouchList.append(self.selectedStepList[index].isTapped  ?? false)
                }
                
                ///
                self.filteredData = self.addedNameList
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
                
            }else{
                print("data has not recived")
            }
        }
        let tappedSlideUp = UITapGestureRecognizer(target: self, action: #selector(slideUpTapped))
        self.viewRemoveButton.roundCorners(.allCorners, radius: 10)
        self.viewSlideUP.addGestureRecognizer(tappedSlideUp)
        self.viewSlideUP.isUserInteractionEnabled = true
        self.viewMainView.backgroundColor = UIColor.mainViewColor
        self.viewContentView.layer.borderWidth = 1
        self.viewContentView.backgroundColor = UIColor.mainViewColor
        self.viewContentView.layer.cornerRadius = 10
        self.searchBar.delegate = self
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.black
        self.tableView.register(AddStepTableViewCell.nib, forCellReuseIdentifier: AddStepTableViewCell.identifier)
        print(userDefaultsData.getFavorite() ?? "")
    }
    
    @objc func slideUpTapped() {
        self.removeFromSuperview()
    }
}

extension AddStepCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilteredTextEmpty == false {
            return self.filteredData.count
        }else{
            return addedNameList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddStepTableViewCell.identifier) as! AddStepTableViewCell
        cell.touchDelegate = self
        if isFilteredTextEmpty == false {
            if self.filteredData.count > 0 {
                cell.labelText.text = filteredData[indexPath.row]
                cell.isTappedFavorite = self.filteredFavoriteTouchList[indexPath.row]
                
            }else{
                self.tableView.reloadData()
            }
        }else{
            if self.addedNameList.count > 0 {
                cell.labelText.text = addedNameList[indexPath.row]
                cell.isTappedFavorite = self.favoriteTouchList[indexPath.row]
            }else{
                self.tableView.reloadData()
            }
        }
        // cell.nameList = self.infoList
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFilteredTextEmpty == false {
            self.infoList.append(self.filteredData[indexPath.row])
        }else {
            self.infoList.append(addedNameList[indexPath.row])
        }
        self.sendInfoDelegate?.sendInfo(sendinfo: self.infoList[0])
        self.removeFromSuperview()
    }
}

extension AddStepCustomView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = []
        self.filteredFavoriteTouchList = []
        self.filteredList = []
        if searchText == ""{
            self.filteredList.insert(self.selectedStepList[0], at: 0)
            self.isFilteredTextEmpty = true
            self.filteredData = self.addedNameList
        }else {
            self.isFilteredTextEmpty = false
            for data in self.addedNameList{
                if data.description.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                }
            }
        }
        if filteredData.count > 0 {
            for index in 0...self.filteredData.count - 1 {
                let filter = self.selectedStepList.filter{($0.text?.contains(self.filteredData[index]) ?? false)}
                if filter.count > 0 {
                    self.filteredList.append(filter[0])
                }
            }
            for index in 0...self.filteredList.count - 1 {
               self.filteredFavoriteTouchList.append(self.filteredList[index].isTapped ?? false)
               let filter = self.tempFilteredList.filter{($0.text?.contains(self.filteredList[index].text ?? "") ?? false)}
                if filter.count > 0 {
                    if let insideIndex = self.filteredList.firstIndex(where: {$0.text == filter[0].text}){
                        self.filteredFavoriteTouchList[insideIndex] = filter[0].isTapped ?? false
                        self.filteredList[insideIndex].isTapped = filter[0].isTapped ?? false
                    }
                }
            }
        }
       if self.filteredFavoriteTouchList.count == self.favoriteTouchList.count {
            self.favoriteTouchList = self.filteredFavoriteTouchList
        }
        self.tableView.reloadData()
    }
}

extension AddStepCustomView : TouchFavoriteDelegate {
    func touchfavoriteTapped(favoriteİsremember: Bool, touch: String) {
        //  self.remember = favoriteİsremember
        //düzenleme yapılıyor
        /*  let filter = selectedStepList.filter{($0.text?.contains(touch) ?? false)}
         for item in filter {
         self.tempStepList?.isTapped = item.isTapped
         }
         self.tempStepList?.isTapped = self.remember */
        self.tempFilteredList = []
        if self.isFilteredTextEmpty != true {
            if let index = self.filteredData.firstIndex(where: {$0 == touch}){
                self.filteredFavoriteTouchList[index] = favoriteİsremember
                self.filteredList[index].isTapped = favoriteİsremember
                self.tempFilteredList = self.filteredList
            }
        }else {
            if let index = self.selectedStepList.firstIndex(where: {$0.text == touch}){
                self.selectedStepList[index].isTapped = favoriteİsremember
                /*  if self.tempStepList?.text != nil {
                 self.selectedStepList.insert(self.tempStepList!, at: index)
                 }*/
                self.favoriteTouchList[index] = favoriteİsremember
            }
        }
        /*  print(self.selectedStepList)
         for item in self.selectedStepList {
         self.addedNameList.append(item.text ?? "")
         self.favoriteTouchList.append(item.isTapped ?? false)
         }*/
        // print(favoriteTouchList)
        self.tableView.reloadData()
        //////////
        if userDefaultsData.getFavorite()?.count ?? 0 > 0{
            self.addFavoriteList = userDefaultsData.getFavorite()
        }
        if favoriteİsremember == true {
            for item in self.addFavoriteList {
                if item == touch {
                    self.firstFavorite = item
                    break
                }
            }
            if self.addFavoriteList == [] || self.firstFavorite != touch {
                self.addFavoriteList.append(touch)
            }
            userDefaultsData.saveFavorite(id: self.addFavoriteList)
        }else {
            if self.firstFavorite == touch {
                self.firstFavorite = ""
            }
            for item in  self.addFavoriteList {
                if item.elementsEqual(touch) {
                    self.addFavoriteList.remove(object: touch)
                    userDefaultsData.saveFavorite(id: self.addFavoriteList)
                    break
                }
            }
        }
        print(self.addFavoriteList)
    }
}

