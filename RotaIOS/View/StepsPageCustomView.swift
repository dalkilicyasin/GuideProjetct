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

protocol StepsPageListDelegate {
    func stepsPageList( listofsteps : [Steps], isChange : Bool )
}

class StepsPageCustomView : UIView {
    @IBOutlet weak var viewStepListView: MainTextCustomView!
    @IBOutlet weak var viewAddedFavoriteListView: MainTextCustomView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewMainView: UIView!
    var filteredSelectedStepList : [GetSelectListResponseModel] = []
    var selectedStepList : [GetSelectListResponseModel] = []
    var remember = true
    var addStepCustomView : AddStepCustomView?
    var viewFavoriteList : FavoriteListCustomView?
    var nameList : [String] = []
    var sendingListofSteps : [Steps] = []
    var stepsPageListDelegate : StepsPageListDelegate?
    var stepsList : [Steps] = []
    var adlCount = 1
    var chldCount = 0
    var infCount = 0
    var orderOfStep = 1
    var newInfo = ""
    
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
        self.viewMainView.addCustomContainerView(self)
        self.viewMainView.backgroundColor = UIColor.mainViewColor
        
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetSelectList, method: .get, parameters: "") { (response : [GetSelectListResponseModel] ) in
            
            if response.count > 0 {
                //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                self.selectedStepList = response
            }else{
                print("data has not recived")
            }
        }
        
        self.viewStepListView.headerLAbel.text = "Add Steps"
        self.viewAddedFavoriteListView.headerLAbel.text = "Add from Favorite Steps"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(StepsPageTableViewCell.nib, forCellReuseIdentifier: StepsPageTableViewCell.identifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.viewStepListView.addGestureRecognizer(tap)
        self.viewStepListView.isUserInteractionEnabled = true
        
        let tapFavorite = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFavorite(_:)))
        self.viewAddedFavoriteListView.addGestureRecognizer(tapFavorite)
        self.viewAddedFavoriteListView.isUserInteractionEnabled = true
    }
    
    @objc func handleTapFavorite(_ sender: UITapGestureRecognizer) {
        if self.remember == true{
            if let topVC = UIApplication.getTopViewController() {
                UIView.animate(withDuration: 0, animations: {
                    self.viewFavoriteList = FavoriteListCustomView()
                    self.viewFavoriteList?.sendFavoriteInfoDelegate = self
                    self.viewFavoriteList!.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height: 896)
                    topVC.view.addSubview(self.viewFavoriteList!)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }
        }
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
        self.filteredSelectedStepList.removeAll()
        for updateList in self.nameList {
            let filter = self.selectedStepList.filter{($0.text?.elementsEqual(updateList) ?? false)}
            
            self.filteredSelectedStepList.append(filter[0])
            // let filter = paxesNameList.filter{($0.text?.contains(updateList) ?? false)}
        }
        print(self.filteredSelectedStepList)
        
        if self.filteredSelectedStepList.count > 0 {
            
            var companyValue : [Int] = []
            var companyName  : [String] = []
            var status : [Int] = []
            
            for listarray in self.filteredSelectedStepList {
                companyValue.append(listarray.value ?? 0)
                companyName.append(listarray.text ?? "")
                status.append(listarray.sTATUS ?? 0)
            }
            
            self.sendingListofSteps.removeAll()
            for i in 0...(self.filteredSelectedStepList.count) - 1 {
                
                self.stepsList.append(Steps(sTP_STATE: 0, name: companyName[i], sTP_COMPANY: companyValue[i], sTP_NOTE: "", sTP_ID: 0, sTP_ADULTCOUNT: self.adlCount, sTP_CHILDCOUNT: self.chldCount, sTP_INFANTCOUNT: self.infCount, sTP_SHOPREF: 0, sTP_STATUS: status[i], sTP_ORDER: (i+1) ))
                self.sendingListofSteps.append(self.stepsList[i])
            }
        }
        self.stepsPageListDelegate?.stepsPageList(listofsteps: self.sendingListofSteps, isChange: true)
    }
}

extension StepsPageCustomView : SendInfoDelegate {
    func sendInfo(sendinfo: String ){
        for item in self.nameList {
            if item == sendinfo {
                self.newInfo = item
                break
            }
        }
        if self.nameList == [] || self.newInfo != sendinfo {
            self.viewStepListView.mainLabel.text = sendinfo
            self.nameList.append(sendinfo)
            self.tableView.reloadData()
            self.filteredSelectedStepList.removeAll()
            for updateList in self.nameList {
                let filter = self.selectedStepList.filter{($0.text?.elementsEqual(updateList) ?? false)}
                
                self.filteredSelectedStepList.append(filter[0])
                // let filter = paxesNameList.filter{($0.text?.contains(updateList) ?? false)}
            }
            print(self.filteredSelectedStepList)
            var companyValue : [Int] = []
            var companyName  : [String] = []
            var status : [Int] = []
            
            for listarray in self.filteredSelectedStepList {
                companyValue.append(listarray.value ?? 0)
                companyName.append(listarray.text ?? "")
                status.append(listarray.sTATUS ?? 0)
            }
            self.sendingListofSteps.removeAll()
            self.stepsList.removeAll()
            self.orderOfStep = 1
            for i in 0...(self.filteredSelectedStepList.count) - 1 {
                
                self.stepsList.append(Steps(sTP_STATE: 0, name: companyName[i], sTP_COMPANY: companyValue[i], sTP_NOTE: "", sTP_ID: 0, sTP_ADULTCOUNT: self.adlCount, sTP_CHILDCOUNT: self.chldCount, sTP_INFANTCOUNT: self.infCount, sTP_SHOPREF: 0, sTP_STATUS: status[i], sTP_ORDER: (self.orderOfStep) ))
                
                self.sendingListofSteps.append(self.stepsList[i])
                self.orderOfStep += 1
            }
            
            self.stepsPageListDelegate?.stepsPageList(listofsteps: self.sendingListofSteps, isChange: true)
        }else {
            return
        }
    }
}

extension StepsPageCustomView : SendFavoriteInfoDelegate {
    func sendFavoriteInfo(sendinfo: String ){
        for item in self.nameList {
            if item == sendinfo {
                self.newInfo = item
                break
            }
        }
        if self.nameList == [] || self.newInfo != sendinfo{
            self.viewAddedFavoriteListView.mainLabel.text = sendinfo
            self.nameList.append(sendinfo)
            self.tableView.reloadData()
            self.filteredSelectedStepList.removeAll()
            for updateList in self.nameList {
                let filter = self.selectedStepList.filter{($0.text?.elementsEqual(updateList) ?? false)}
                self.filteredSelectedStepList.append(filter[0])
                // let filter = paxesNameList.filter{($0.text?.contains(updateList) ?? false)}
            }
            print(self.filteredSelectedStepList)
            var companyValue : [Int] = []
            var companyName  : [String] = []
            var status : [Int] = []
            
            for listarray in self.filteredSelectedStepList {
                companyValue.append(listarray.value ?? 0)
                companyName.append(listarray.text ?? "")
                status.append(listarray.sTATUS ?? 0)
            }
            
            self.sendingListofSteps.removeAll()
            self.orderOfStep = 1
            for i in 0...(self.filteredSelectedStepList.count) - 1 {
                
                self.stepsList.append(Steps(sTP_STATE: 0, name: companyName[i], sTP_COMPANY: companyValue[i], sTP_NOTE: "", sTP_ID: 0, sTP_ADULTCOUNT: self.adlCount, sTP_CHILDCOUNT: self.chldCount, sTP_INFANTCOUNT: self.infCount, sTP_SHOPREF: 0, sTP_STATUS: status[i], sTP_ORDER: (self.orderOfStep) ))
                
                self.sendingListofSteps.append(self.stepsList[i])
                self.orderOfStep += 1
            }
            self.stepsPageListDelegate?.stepsPageList(listofsteps: self.sendingListofSteps, isChange: true)
        }else {
            return
        }
    }
}












