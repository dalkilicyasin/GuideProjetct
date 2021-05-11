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
    
    var touristAddView : TouristAddCustomView?
    var tempTouristAddView : TempTouristAddCustomView?
    var remember = true
    var isFilteredTextEmpty = true
    var filteredData : [String] = []
    var paxesListDelegate : PaxesListDelegate?
    var counter = 0
    var nameList : [String] = []
    var paxesNameList :[GetInHoseListResponseModel] = []
    var filteredPaxesList : [GetInHoseListResponseModel] = []
    var tempNameList : [String] = []
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTouristAdded: UIView!
    @IBOutlet weak var labelTouristAdded: UILabel!
  
    
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
        
        let getInHouseListRequestModel = GetInHouseListRequestModel(hotelId: userDefaultsData.getHotelId(), marketId: userDefaultsData.getMarketId())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetInHouseList, method: .get, parameters: getInHouseListRequestModel.requestPathString()) { (response : [GetInHoseListResponseModel] ) in
            
            if response.count > 0 {
                print(response)
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                
                self.paxesNameList = response
                
                for listofArray in self.paxesNameList {
                    self.nameList.append(listofArray.text ?? "")
                }
                self.filteredData = self.nameList 
                print(self.nameList)
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
              
    
             
            }else{
                print("data has not recived")
            }
        }
        
        self.viewTouristAdded.layer.borderWidth = 1
        self.viewTouristAdded.layer.borderColor = UIColor.green.cgColor
        self.viewTouristAdded.layer.cornerRadius = 10
     
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
    
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
        
        self.searchBar.delegate = self
        
        self.tableView.register(PaxPageTableViewCell.nib, forCellReuseIdentifier: PaxPageTableViewCell.identifier)
       

        //silinecek
      
      /*  let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.viewTouristAdded.addGestureRecognizer(tap)
        self.viewTouristAdded.isUserInteractionEnabled = true*/
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMiracle))
        self.viewTouristAdded.addGestureRecognizer(tap)
        self.viewTouristAdded.isUserInteractionEnabled = true

    }
    
    @objc func showMiracle() {
        if let topVC = UIApplication.getTopViewController() {
            self.tempTouristAddView = TempTouristAddCustomView()
            self.tempTouristAddView?.modalPresentationStyle = .custom
            self.tempTouristAddView?.transitioningDelegate = self
            topVC.present(tempTouristAddView!, animated: true, completion: nil)
            self.tempTouristAddView?.nameListed = self.tempNameList
        }

      }
 
    // silinecek
  /*
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        if self.remember == true{
            if let topVC = UIApplication.getTopViewController() {
                UIView.animate(withDuration: 0, animations: {
                    self.touristAddView = TouristAddCustomView()
                    self.touristAddView?.nameList = self.tempNameList
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
    } */
}

extension PaxPageCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            if isFilteredTextEmpty == false {
              
                 return self.filteredData.count
             }else{
               
                return self.nameList.count
             }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaxPageTableViewCell.identifier) as! PaxPageTableViewCell
        cell.paxPageCounterDelegate = self
        if isFilteredTextEmpty == false {
            if self.filteredData.count > 0 {
                cell.labelPaxNameListCell.text = filteredData[indexPath.row]
            }else{
                self.tableView.reloadData()
            }
        }else{
            if self.nameList.count > 0 {
                cell.labelPaxNameListCell.text = nameList[indexPath.row]
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
    func checkboxCounter(checkCounter: Bool, touristName: String) {
        if checkCounter == true {
            self.counter += 1
            print(self.counter)
            self.labelTouristAdded.text = "\(counter) Tourist Added"
            self.tempNameList.append(touristName)
            let filter = paxesNameList.filter{($0.text?.contains(touristName) ?? false)}
            self.filteredPaxesList = filter
            print(filteredPaxesList)
        }else if checkCounter == false {
            self.counter -= 1
            print(self.counter)
            self.labelTouristAdded.text = "\(counter) Tourist Added"
            var tempIndex = 0
            for item in self.tempNameList {
                if item.elementsEqual(touristName) {
                    self.tempNameList.remove(at: tempIndex)
                    break
                }
                
                tempIndex += 1
            }
        }
    }
    
}

extension PaxPageCustomView : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}




