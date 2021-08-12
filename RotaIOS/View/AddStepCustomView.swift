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
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var selectList : [GetSelectListResponseModel] = []
    var stepsSelectedNameList : StepsPageCustomView?
    var sendInfoDelegate : SendInfoDelegate?
    var remember = true
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    var addedNameList : [String] = []
    var infoList : [String] = []
    var newFavorite = ""
    
    var addFavoriteList : [String] = []
    
    
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
        self.headerView.addCustomContainerView(self)
        
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetSelectList, method: .get, parameters: "") { (response : [GetSelectListResponseModel] ) in
            
            if response.count > 0 {
                
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                
                self.selectList = response
                
                for listArray in self.selectList {
                    self.addedNameList.append(listArray.text ?? "")
                }
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
        self.headerView.backgroundColor = UIColor.mainViewColor
        self.topView.layer.borderWidth = 1
        self.topView.backgroundColor = UIColor.mainViewColor
        self.topView.layer.cornerRadius = 10
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
            }else{
                self.tableView.reloadData()
            }
        }else{
            if self.addedNameList.count > 0 {
                cell.labelText.text = addedNameList[indexPath.row]
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
        if searchText == ""{
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
        self.tableView.reloadData()
    }
}

extension AddStepCustomView : TouchFavoriteDelegate {
    func touchfavoriteTapped(favoriteİsremember: Bool, touch: String) {
        if userDefaultsData.getFavorite()?.count ?? 0 > 0{
            self.addFavoriteList = userDefaultsData.getFavorite()
        }
        
        if favoriteİsremember == true {
            for item in self.addFavoriteList {
                if item == touch {
                    self.newFavorite = item
                    break
                }
            }
        
            if self.addFavoriteList == [] || self.newFavorite != touch {
                self.addFavoriteList.append(touch)
            }
            userDefaultsData.saveFavorite(id: self.addFavoriteList)
        }else {
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
