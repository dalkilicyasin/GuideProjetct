//
//  PaxPageCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 21.04.2021.
//

import Foundation

import UIKit

protocol PaxesListDelegate {
    func paxesList(ischosen : Bool)
}

class PaxPageCustomView : UIView {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var touristAddView : TouristAddCustomView?
    var remember = true
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    @IBOutlet weak var touristAddedText: UILabel!
    
    var paxesListDelegate : PaxesListDelegate?
    
    var counter = 0

    var nameList = ["Daria Sharapova","Yasin Dalkilic","Doğan Dalkilic","Memati Baş","Abdüllhey Çoban","Polat Alemdar","Murat Alemdar"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: PaxPageCustomView.self), owner: self, options: nil)
        self.headerView.addCustomContainerView(self)
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        self.topView.layer.borderWidth = 1
        self.topView.layer.borderColor = UIColor.green.cgColor
        self.topView.layer.cornerRadius = 10
        
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PaxPageTableViewCell.nib, forCellReuseIdentifier: PaxPageTableViewCell.identifier)
        
        self.searchBar.delegate = self
        self.filteredData = nameList
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        topView.addGestureRecognizer(tap)
        topView.isUserInteractionEnabled = true

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        if self.remember == true{
            if let topVC = UIApplication.getTopViewController() {
                UIView.animate(withDuration: 0, animations: {
                    self.touristAddView = TouristAddCustomView()
                    self.touristAddView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1200)
                    topVC.view.addSubview(self.touristAddView!)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }
            
            print("true")
        }else{
            print("false")
            self.touristAddView!.removeFromSuperview()
        }
    }
}

extension PaxPageCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilteredTextEmpty == false {
            return self.filteredData.count
        }else{
            return nameList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaxPageTableViewCell.identifier) as! PaxPageTableViewCell
        cell.paxPageCounterDelegate = self
        if isFilteredTextEmpty == false {
            if self.filteredData.count > 0 {
                cell.mainText.text = filteredData[indexPath.row]
            }else{
                self.tableView.reloadData()
            }
        }else{
            if self.nameList.count > 0 {
                cell.mainText.text = nameList[indexPath.row]
            }else{
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
        case 0 :
            self.paxesListDelegate?.paxesList(ischosen: true)
        case 1 :
            self.paxesListDelegate?.paxesList(ischosen: true)
        default :
            print("selected")
            
        }
    }
}

extension PaxPageCustomView : UISearchBarDelegate {
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

extension PaxPageCustomView : PaxPageCounterDelegate {
    func checkboxCounter(checkCounter: Bool) {
        if checkCounter == true {
            self.counter += 1
            print(self.counter)
            self.touristAddedText.text = "\(counter) Tourist Added"
            
        }else if checkCounter == false {
            self.counter -= 1
            print(self.counter)
            self.touristAddedText.text = "\(counter) Tourist Added"
        }
    }
    
}



