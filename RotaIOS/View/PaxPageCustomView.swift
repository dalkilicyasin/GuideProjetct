//
//  PaxPageCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 21.04.2021.
//

import Foundation
import UIKit

protocol PaxesListDelegate {
    func paxesList(ischosen : Bool, sendingPaxesLis : [Paxes], isChange : Bool)
}

class PaxPageCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTouristAdded: UIView!
    @IBOutlet weak var labelTouristAdded: UILabel!
    var tempTouristAddView : TempTouristAddCustomView?
    var remember = true
    var isFiltered = false
    var filteredData : [GetInHoseListResponseModel] = []
    var paxesListDelegate : PaxesListDelegate?
    var counter = 0
    var tempPaxesNameList : [GetInHoseListResponseModel] = [] // servis geldikten sonra denenip silinecek
    var paxesNameList :[GetInHoseListResponseModel] = []
    var filteredPaxesList : [GetInHoseListResponseModel] = []
    var tempNameList : [String] = []
    var paxesListinPaxPage : [Paxes] = []
    var touristInfoList : [GetTouristInfoResponseModel] = []
    var getInTouristInfoRequestModelList : [GetTouristInfoRequestModel] = []
    var paxID : [String] = [] //kullanıp kullanılmayacağı belli değil 0 aldım
    var oprID : [Int] = []
    var oprName : [String] = []
    //  var oprType : [Int] = [] // ne olduğu belli değil 1 aldım
    var reservationNo : [String] = []
    var hotelName : [String] = []
    var ageGroup : [String] = []
    var birthDay : [String] = []
    var passport : [String] = []
    var touristIdRef : [Int] = []
    var name : [String] = []
    var sendingListofPaxes : [Paxes] = []
    var tempSendingListofPaxes : [Paxes] = []
    var paxesList : [Paxes] = []
    var equalableFilteredPaxList : [String] = []
    var tempValue = 0
    var checkList : [Bool] = []
    var checkFilteredList : [Bool] = []
    var tempFilteredList : [GetInHoseListResponseModel] = []
    var tempList : [GetInHoseListResponseModel] = []
    var filteredList : [GetInHoseListResponseModel] = []
    
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
        self.viewMainView.addCustomContainerView(self)
        self.viewMainView.backgroundColor = UIColor.mainViewColor
        if userDefaultsData.getHotelId() > 0 {
            let getInHouseListRequestModel = GetInHouseListRequestModel(hotelId: String(userDefaultsData.getHotelId()), marketId: String(userDefaultsData.getMarketId()))
            NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetInHouseList, method: .get, parameters: getInHouseListRequestModel.requestPathString()) { (response : [GetInHoseListResponseModel] ) in
                if response.count > 0 {
                    //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                    userDefaultsData.saveHotelId(hotelId: 0)
                    userDefaultsData.saveMarketId(marketId: 0)
                    self.paxesNameList = response
                    // düzenleme yapılıyor
                    for index in 0...self.paxesNameList.count - 1 {
                        self.paxesNameList[index].isTapped = false
                        self.checkList.append(self.paxesNameList[index].isTapped ?? false)
                    }
                    //
                    self.tempPaxesNameList = self.paxesNameList // servis düzeldikten sonra denelinip silinecek.
                    self.filteredData = self.paxesNameList
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }else{
                    print("data has not recived")
                }
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.viewTouristAdded.addGestureRecognizer(tap)
        self.viewTouristAdded.isUserInteractionEnabled = true
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.alwaysBounceVertical = true
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshPaxses), for: .valueChanged)
    }
    
    @objc func refreshPaxses() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.isFiltered = false
            self.paxesNameList = self.tempPaxesNameList
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let topVC = UIApplication.getTopViewController() {
            UIView.animate(withDuration: 0, animations: {
                self.tempTouristAddView = TempTouristAddCustomView()
                self.tempTouristAddView?.tempPaxesList = self.sendingListofPaxes
                self.tempTouristAddView?.changeCounterValue = self.tempValue
                self.tempTouristAddView?.temppAddPaxesListDelegate = self
                self.tempTouristAddView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1200)
                topVC.view.addSubview(self.tempTouristAddView!)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
        }
    }
}

extension PaxPageCustomView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered == true {
            return self.filteredData.count
        }else{
            return self.paxesNameList.count
            // return self.nameList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaxPageTableViewCell.identifier) as! PaxPageTableViewCell
        cell.paxPageTableViewCellDelegate = self
        if self.isFiltered == true {
            cell.labelPaxNameListCell.text = self.filteredData[indexPath.row].text
            cell.tempPaxes = self.filteredData[indexPath.row]
            cell.isTappedCheck = self.checkFilteredList[indexPath.row]
            //  cell.checkBoxView.imageCheck.isHidden = !(self.filteredData[indexPath.row].isSelected ?? false)
        }else{
            cell.labelPaxNameListCell.text = self.paxesNameList[indexPath.row].text
            cell.tempPaxes = self.paxesNameList[indexPath.row]
            cell.isTappedCheck = self.checkList[indexPath.row]
            // cell.checkBoxView.imageCheck.isHidden = !(self.paxesNameList[indexPath.row].isSelected ?? false)
        }
        return cell
    }
    
  /*  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.paxesNameList.count > 0 {
            let selectedName = paxesNameList[indexPath.row]
            let filterResNo = self.paxesNameList.filter{($0.resNo?.elementsEqual((selectedName.resNo ?? "")) ?? false)}
            self.isFiltered = true
            self.filteredData = filterResNo
            self.tableView.reloadData()
        }else{
            print("selected")
        }
    } */
}

extension PaxPageCustomView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = []
        self.checkFilteredList = []
        self.filteredList  = []
       // self.checkList = []
        if searchText.elementsEqual(""){
            self.isFiltered = false
            //  self.paxesNameList = self.tempPaxesNameList
            self.filteredData = self.paxesNameList
        }else {
            self.isFiltered = true
            for data in self.paxesNameList{
                if data.text!.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                    //   self.paxesNameList = self.filteredData
                }
            }
        }
        
        if filteredData.count > 0 {
            for index in 0...self.filteredData.count - 1 {
                let filter = self.paxesNameList.filter{($0.text?.contains(self.filteredData[index].text ?? "") ?? false)}
                if filter.count > 0 {
                    self.filteredList.append(filter[0])
                }
            }
            for index in 0...self.filteredList.count - 1 {
                self.checkFilteredList.append(self.filteredList[index].isTapped ?? false)
                //   self.checkList.append(self.paxesNameList[index].isTapped ?? false)
                let filter = self.tempFilteredList.filter{($0.text?.contains(self.filteredList[index].text ?? "") ?? false)}
                if filter.count > 0 {
                    if let insideIndex = self.filteredList.firstIndex(where: {$0.text == filter[0].text}){
                        self.filteredList[insideIndex].isTapped = filter[0].isTapped ?? false
                        self.checkFilteredList[insideIndex] = filter[0].isTapped ?? false
                     /*   if  self.tempFilteredList.count > 0 {
                            self.tempFilteredList[insideIndex].isTapped = filter[0].isTapped ?? false
                        } */
                    }
                }
            }
        }
        if self.checkFilteredList.count == self.checkList.count {
         self.checkList = self.checkFilteredList
         }
        /*else {
            for index in 0...self.paxesNameList.count - 1 {
                //  self.checkFilteredList.append(self.filteredList[index].isTapped ?? false)
                self.checkList.append(self.paxesNameList[index].isTapped ?? false)
                let filter = self.tempList.filter{($0.text?.contains(self.paxesNameList[index].text ?? "") ?? false)}
                if filter.count > 0 {
                    if let insideIndex = self.paxesNameList.firstIndex(where: {$0.text == filter[0].text}){
                        // self.checkFilteredList[insideIndex] = filter[0].isTapped ?? false
                        self.checkList[insideIndex] = filter[0].isTapped ?? false
                        self.tempList[insideIndex].isTapped = filter[0].isTapped ?? false
                    }
                }
                let tempFilter = self.tempFilteredList.filter{($0.text?.contains(self.paxesNameList[index].text ?? "") ?? false)}
                if tempFilter.count > 0 {
                    if let insideIndex = self.paxesNameList.firstIndex(where: {$0.text == tempFilter[0].text}){
                        // self.checkFilteredList[insideIndex] = filter[0].isTapped ?? false
                        self.checkList[insideIndex] = tempFilter[0].isTapped ?? false
                        if self.tempList.count > 0 {
                            self.tempList[insideIndex].isTapped = tempFilter[0].isTapped ?? false
                        }
                    }
                }
            }
            
            /* if self.checkFilteredList.count == self.paxesNameList.count {
             self.checkFilteredList = self.checkList
             self.tempFilteredList = self.tempList
             }*/
        }
        if self.checkFilteredList.count == self.checkList.count {
            self.checkList = self.checkFilteredList
        } */
        self.tableView.reloadData()
    }
}

extension PaxPageCustomView : PaxPageTableViewCellDelegate {
    func checkBoxTapped(checkCounter: Bool, touristName: String, tempPaxes: GetInHoseListResponseModel) {
        self.tempFilteredList = []
        if isFiltered == true {
            if let index = self.filteredData.firstIndex(where: {$0.text == touristName} ){
                self.filteredList[index].isTapped = checkCounter
                self.checkFilteredList[index] = checkCounter
                self.tempFilteredList = self.filteredList
            }
        }else{
            if let index = self.paxesNameList.firstIndex(where: {$0 === tempPaxes}){
                self.paxesNameList[index].isTapped = checkCounter
                self.checkList[index] = checkCounter
                self.tempList = self.paxesNameList
            }
        }
        self.tableView.reloadData()
        let filter = self.paxesNameList.filter{($0.text?.elementsEqual(touristName) ?? false)}
        if checkCounter {
            self.counter += 1
            print(self.counter)
            self.labelTouristAdded.text = "\(self.counter + self.tempValue) Tourist Added"
            self.tempNameList.append(touristName)
            self.filteredPaxesList.removeAll()
            self.filteredPaxesList.append(filter[0])
            var touristId : [Int] = []
            var resNo : [String] = []
            touristId.removeAll()
            resNo.removeAll()
            if self.filteredPaxesList.count > 0 {
                for listarray in self.filteredPaxesList {
                    touristId.append(listarray.value ?? 0)
                    resNo.append(listarray.ResNo ?? "")
                }
                self.getInTouristInfoRequestModelList.removeAll()
                
                for i in 0...filteredPaxesList.count - 1 {
                    self.getInTouristInfoRequestModelList.append(GetTouristInfoRequestModel(touristId: touristId[i], resNo: resNo[i]))
                }
                self.paxesListinPaxPage.removeAll()
                NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetTouristInfo, method: .get, parameters: getInTouristInfoRequestModelList[0].requestPathString()) { (response : [GetTouristInfoResponseModel] ) in
                    if response.count > 0 {
                        print(response)
                        // let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                        self.touristInfoList = response
                        self.oprID.removeAll()
                        self.oprName.removeAll()
                        self.reservationNo.removeAll()
                        self.hotelName.removeAll()
                        self.ageGroup.removeAll()
                        self.name.removeAll()
                        self.birthDay.removeAll()
                        self.passport.removeAll()
                        self.touristIdRef.removeAll()
                        for listarray in self.touristInfoList {
                            // self.paxID.append(listarray.id ?? "")
                            self.oprID.append(listarray.oprId ?? 0)
                            self.oprName.append(listarray.operatorName ?? "")
                            self.reservationNo.append(listarray.resNo ?? "")
                            self.hotelName.append(listarray.hotelName ?? "")
                            self.ageGroup.append(listarray.ageGroup ?? "")
                            self.name.append(listarray.name ?? "")
                            self.birthDay.append(listarray.birthDay ?? "")
                            self.passport.append(listarray.passport ?? "")
                            self.touristIdRef.append(listarray.touristIdRef ?? 0)
                        }
                        self.paxesList.removeAll()
                        for i in 0...(self.touristInfoList.count) - 1 {
                            self.paxesList.append(Paxes( pAX_CHECKOUT_DATE: "1/1/2020",  pAX_OPRID: self.oprID[i], pAX_OPRNAME: self.oprName[i], pAX_PHONE: "", hotelname: self.hotelName[i], pAX_GENDER: "MRS.", pAX_AGEGROUP: self.ageGroup[i], pAX_NAME: self.name[i], pAX_BIRTHDAY: self.birthDay[i], pAX_RESNO: self.reservationNo[i], pAX_PASSPORT: self.passport[i], pAX_ROOM: "1", pAX_TOURISTREF:self.touristIdRef[i], pAX_STATUS: 1, ID: 0 ))
                            self.paxesListinPaxPage.append(self.paxesList[i])
                        }
                        for listarray in self.paxesListinPaxPage {
                            self.sendingListofPaxes.append(listarray)
                        }
                        self.paxesListDelegate?.paxesList(ischosen: false, sendingPaxesLis: self.sendingListofPaxes, isChange: true)
                    }else{
                        print("data has not recived")
                    }
                }
            }
        }
        else{
            self.counter -= 1
            print(self.counter)
            if self.counter >= 0 {
                self.labelTouristAdded.text = "\(counter) Tourist Added"
            }else {
                self.counter = 0
                self.labelTouristAdded.text = "\(counter) Tourist Added"
            }
            self.filteredPaxesList.removeAll()
            self.filteredPaxesList.append(filter[0])
            var touristId : [Int] = []
            var resNo : [String] = []
            touristId.removeAll()
            resNo.removeAll()
            if self.filteredPaxesList.count > 0 {
                for listarray in self.filteredPaxesList {
                    touristId.append(listarray.value ?? 0)
                    resNo.append(listarray.ResNo ?? "")
                }
                getInTouristInfoRequestModelList.removeAll()
                for i in 0...filteredPaxesList.count - 1 {
                    self.getInTouristInfoRequestModelList.append(GetTouristInfoRequestModel(touristId: touristId[i], resNo: resNo[i]))
                }
                self.paxesListinPaxPage.removeAll()
                NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetTouristInfo, method: .get, parameters: getInTouristInfoRequestModelList[0].requestPathString()) { (response : [GetTouristInfoResponseModel] ) in
                    if response.count > 0 {
                        // let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)
                        self.touristInfoList = response
                        self.oprID.removeAll()
                        self.oprName.removeAll()
                        self.reservationNo.removeAll()
                        self.hotelName.removeAll()
                        self.ageGroup.removeAll()
                        self.name.removeAll()
                        self.birthDay.removeAll()
                        self.passport.removeAll()
                        self.touristIdRef.removeAll()
                        for listarray in self.touristInfoList {
                            // self.paxID.append(listarray.id ?? "")
                            self.oprID.append(listarray.oprId ?? 0)
                            self.oprName.append(listarray.operatorName ?? "")
                            self.reservationNo.append(listarray.resNo ?? "")
                            self.hotelName.append(listarray.hotelName ?? "")
                            self.ageGroup.append(listarray.ageGroup ?? "")
                            self.name.append(listarray.name ?? "")
                            self.birthDay.append(listarray.birthDay ?? "")
                            self.passport.append(listarray.passport ?? "")
                            self.touristIdRef.append(listarray.touristIdRef ?? 0)
                        }
                        self.paxesList.removeAll()
                        for i in 0...(self.touristInfoList.count) - 1 {
                            self.paxesList.append(Paxes( pAX_CHECKOUT_DATE: "",  pAX_OPRID: self.oprID[i], pAX_OPRNAME: self.oprName[i], pAX_PHONE: "", hotelname: self.hotelName[i], pAX_GENDER: "MRS.", pAX_AGEGROUP: self.ageGroup[i], pAX_NAME: self.name[i], pAX_BIRTHDAY: self.birthDay[i], pAX_RESNO: self.reservationNo[i], pAX_PASSPORT: self.passport[i], pAX_ROOM: "1", pAX_TOURISTREF:self.touristIdRef[i], pAX_STATUS: 1, ID: 0 ))
                            self.paxesListinPaxPage.append(self.paxesList[i])
                        }
                        self.tempSendingListofPaxes = self.sendingListofPaxes
                        if self.tempSendingListofPaxes.count > 0 {
                            for i in 0...self.sendingListofPaxes.count - 1 {
                                if self.paxesListinPaxPage[0] === self.sendingListofPaxes[i]{
                                    self.tempSendingListofPaxes.remove(at: i)
                                }
                            }
                            self.sendingListofPaxes = self.tempSendingListofPaxes
                        }else {
                            self.sendingListofPaxes.removeAll()
                        }
                        self.paxesListDelegate?.paxesList(ischosen: false, sendingPaxesLis: self.sendingListofPaxes, isChange: true)
                        
                    }else{
                        print("data has not recived")
                    }
                }      
            }
        }
        self.tableView.reloadData()
    }
}

extension PaxPageCustomView : TempAddPaxesListDelegate {
    func tempAddList(listofpaxes: [Paxes], manuellist: [String], changeValue: Int) {
        if self.tempValue != changeValue {
            self.tempValue = changeValue
            self.sendingListofPaxes = listofpaxes
            self.labelTouristAdded.text = "\(self.counter + self.tempValue) Tourist Added"
            self.paxesListDelegate?.paxesList(ischosen: false, sendingPaxesLis: self.sendingListofPaxes, isChange: true)
            return
        }else {
            self.paxesListinPaxPage.removeAll()
            self.sendingListofPaxes = listofpaxes
            self.paxesListDelegate?.paxesList(ischosen: false, sendingPaxesLis: self.sendingListofPaxes, isChange: false)
            self.tempValue = changeValue
        }
    }
}





