//
//  AddStepCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//
import Foundation

import UIKit

class AddStepCustomView : UIView {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    var remember = true
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    
    var nameList = ["Daria Sharapova","Yasin Dalkilic","Emin Yildirimtas","Akif Demirezen","Emre Kalem","Güliz Yildirimtas","Serdar Tural"]
    
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
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        self.topView.layer.borderWidth = 1
        self.topView.backgroundColor = UIColor.mainViewColor
        self.topView.layer.cornerRadius = 10
        
        
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
 
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddStepTableViewCell.nib, forCellReuseIdentifier: AddStepTableViewCell.identifier)
        
        self.searchBar.delegate = self
        self.filteredData = nameList
        

    }

}

extension AddStepCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilteredTextEmpty == false {
            return self.filteredData.count
        }else{
            return nameList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddStepTableViewCell.identifier) as! AddStepTableViewCell
        
        if isFilteredTextEmpty == false {
            if self.filteredData.count > 0 {
                cell.labelText.text = filteredData[indexPath.row]
            }else{
                self.tableView.reloadData()
            }
        }else{
            if self.nameList.count > 0 {
                cell.labelText.text = nameList[indexPath.row]
            }else{
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
    }
       
    
    
}

extension AddStepCustomView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  
        self.filteredData = []
        
        if searchText.elementsEqual(""){
            self.isFilteredTextEmpty = true
            self.filteredData = nameList
        }else {
            self.isFilteredTextEmpty = false
            for data in nameList{
                if data.description.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                }
            }
        }
        self.tableView.reloadData()
        
    }
}
