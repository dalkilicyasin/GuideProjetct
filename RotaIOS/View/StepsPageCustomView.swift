//
//  StepsPageCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//

//

import Foundation

import UIKit
import DropDown

class StepsPageCustomView : UIView {
    
    @IBOutlet weak var firstMainTextView: MainTextCustomView!
    @IBOutlet weak var secondMainTextView: MainTextCustomView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    var filteredNameList : [GetSelectListResponseModel] = []
    var stepsNameList : [GetSelectListResponseModel] = []

    var remember = true
    var addStepCustomView : AddStepCustomView?
   
    var nameList : [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: StepsPageCustomView.self), owner: self, options: nil)
        headerView.addCustomContainerView(self)
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetSelectList, method: .get, parameters: "") { (response : [GetSelectListResponseModel] ) in
            
            if response.count > 0 {
                print(response)
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                
                self.stepsNameList = response
                
              
             
            }else{
                print("data has not recived")
            }
        }
      
        self.firstMainTextView.headerLAbel.text = "Add Steps"
        
        self.secondMainTextView.headerLAbel.text = "Add from Favorite Steps"
        self.secondMainTextView.mainLabel.text = "Denver Deri - Diğer Otel Mh."
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(StepsPageTableViewCell.nib, forCellReuseIdentifier: StepsPageTableViewCell.identifier)
        
      let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.firstMainTextView.addGestureRecognizer(tap)
        self.firstMainTextView.isUserInteractionEnabled = true
        
        
    }
  
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
       if self.remember == true{
            if let topVC = UIApplication.getTopViewController() {
                UIView.animate(withDuration: 0, animations: {
                    self.addStepCustomView = AddStepCustomView()
                    self.addStepCustomView?.sendInfoDelegate = self
                    
                    self.addStepCustomView!.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height: 896)
                    topVC.view.addSubview(self.addStepCustomView!)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }
        }
        
        
    } 
}

extension StepsPageCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       return self.nameList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: StepsPageTableViewCell.identifier) as! StepsPageTableViewCell
        cell.labelText.text = nameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.nameList.remove(at: indexPath.row)
           self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
           
           
        }
        print(nameList)
        self.filteredNameList.removeAll()
        for updateList in self.nameList {
         let filter = self.stepsNameList.filter{($0.text?.elementsEqual(updateList) ?? false)}
            
            self.filteredNameList.append(filter[0])
           // let filter = paxesNameList.filter{($0.text?.contains(updateList) ?? false)}
        }
        print(self.filteredNameList)
    }

}

extension StepsPageCustomView : SendInfoDelegate {
    func sendInfo(sendinfo: String) {
        self.firstMainTextView.mainLabel.text = sendinfo
        self.nameList.append(sendinfo)
        self.tableView.reloadData()
        self.filteredNameList.removeAll()
        for updateList in self.nameList {
         let filter = self.stepsNameList.filter{($0.text?.elementsEqual(updateList) ?? false)}
            
            self.filteredNameList.append(filter[0])
           // let filter = paxesNameList.filter{($0.text?.contains(updateList) ?? false)}
        }
        
        print(self.filteredNameList)
    }
}










