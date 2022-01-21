//
//  ExcPaxCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.12.2021.
//

import Foundation
import UIKit

protocol ExcPaxPageDelegate {
    func excPaxInfo(tourButtonTapped : Bool?)
}

class ExcPaxCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var buttonTourButton: UIButton!
    @IBOutlet weak var buttonPaxButton: UIButton!
    @IBOutlet weak var labelTouristAdded: UILabel!
    @IBOutlet weak var viewTouristAdded: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelPaxes: UILabel!
    var excPaxPageDelegate : ExcPaxPageDelegate?
    var touristNumber = 0
    var tourButtonTapped = false
    var paxesList : [GetInHoseListResponseModel] = []
    var checkFilteredList : [Bool] = []
    var filteredData : [GetInHoseListResponseModel] = []
    var filteredList : [GetInHoseListResponseModel] = []
    var isFiltered = false
    var tempFilteredList : [GetInHoseListResponseModel] = []
    var checkList : [Bool] = []
    var tempTouristAddView : TempTouristAddCustomView?
    //var tempTouristAddView : TempTouristAddCustomView?
    var remember = true
    //  var isFiltered = false
    // var filteredData : [GetInHoseListResponseModel] = []
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
    // var paxesList : [Paxes] = []
    var equalableFilteredPaxList : [String] = []
    var tempValue = 0
    var tempListofPaxes : [Paxes] = []
    // var checkList : [Bool] = []
    // var checkFilteredList : [Bool] = []
    // var tempFilteredList : [GetInHoseListResponseModel] = []
    var tempList : [GetInHoseListResponseModel] = []
    //var filteredList : [GetInHoseListResponseModel] = []
    var savePaxesList : [GetInHoseListResponseModel] = []
    var totalPaxesCount = 0
    var manuelAddedPaxesList : [GetInHoseListResponseModel] = []
    var manuelPaxAgeGroup = ""
    var manuelPaxAge = 0
    //touristDetailInfo
    var touristDetailInfoList : [Paxes] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ExcPaxCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.labelPaxes.addLine(position: .bottom, color: .lightGray, width: 1.0)
        self.tableView.backgroundColor = UIColor.tableViewColor
        self.viewMainView.backgroundColor = UIColor.grayColor
        self.buttonTourButton.clipsToBounds = true
        self.buttonTourButton.layer.cornerRadius = 10
        self.buttonTourButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        self.buttonPaxButton.clipsToBounds = true
        self.buttonPaxButton.layer.cornerRadius = 10
        self.buttonPaxButton.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        self.buttonPaxButton.backgroundColor = UIColor.greenColor
        self.buttonTourButton.layer.borderWidth = 1
        self.buttonTourButton.backgroundColor = UIColor.clear
        self.viewTouristAdded.layer.borderWidth = 1
        self.viewTouristAdded.layer.borderColor = UIColor.green.cgColor
        self.viewTouristAdded.layer.cornerRadius = 10
        self.buttonTourButton.layer.borderColor = UIColor.greenColor.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.viewTouristAdded.addGestureRecognizer(tap)
        self.viewTouristAdded.isUserInteractionEnabled = true
        
        self.tableView.register(ExcPaxPageTableViewCell.nib, forCellReuseIdentifier: ExcPaxPageTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
        self.searchBar.placeholder = "Pax Name Filter"
        self.searchBar.delegate = self
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
    
    @IBAction func tourButtonTapped(_ sender: Any) {
        self.tourButtonTapped = true
        self.excPaxPageDelegate?.excPaxInfo(tourButtonTapped: self.tourButtonTapped)
    }
    
    @IBAction func paxButtonTapped(_ sender: Any) {
        self.tourButtonTapped = false
        self.excPaxPageDelegate?.excPaxInfo(tourButtonTapped: self.tourButtonTapped)
    }
}

extension ExcPaxCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltered == true {
            return self.filteredData.count
        }else{
            return self.paxesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExcPaxPageTableViewCell.identifier) as! ExcPaxPageTableViewCell
        cell.excPaxPageTableViewCellDelegate = self
        if self.isFiltered == true {
            cell.labelPaxName.text = self.filteredData[indexPath.row].text
            cell.paxesListInCell = self.filteredData[indexPath.row]
            cell.isTappedCheck = self.checkFilteredList[indexPath.row]
        }else{
            cell.labelPaxName.text = self.paxesList[indexPath.row].text
            cell.marketGroup = self.paxesList[indexPath.row].mrkGrp ?? 0
            cell.paxesListInCell = self.paxesList[indexPath.row]
            cell.isTappedCheck = self.checkList[indexPath.row]
        }
        return cell
    }
}

extension ExcPaxCustomView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = []
        self.checkFilteredList = []
        self.filteredList  = []
        
        if searchText.elementsEqual(""){
            self.isFiltered = false
            //  self.paxesNameList = self.tempPaxesNameList
            self.filteredData = self.paxesList
        }else {
            self.isFiltered = true
            for data in self.paxesList{
                if data.text!.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                    //   self.paxesNameList = self.filteredData
                }
            }
        }
        
        if filteredData.count > 0 {
            for index in 0...self.filteredData.count - 1 {
                let filter = self.paxesList.filter{($0.text?.contains(self.filteredData[index].text ?? "") ?? false)}
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
        self.tableView.reloadData()
    }
}

extension ExcPaxCustomView : TempAddPaxesListDelegate {
    func tempAddList(listofpaxes: [Paxes], manuellist: [String], changeValue: Int) {
        if  self.tempListofPaxes.count != listofpaxes.count {
            self.tempListofPaxes = listofpaxes
            self.manuelAddedPaxesList.removeAll()
            let currentYear =  Calendar.current.component(.year, from: Date())
            if self.tempValue != changeValue {
                self.tempValue = changeValue
                self.sendingListofPaxes = listofpaxes
                userDefaultsData.saveManuelandHousePaxesList(tour: self.sendingListofPaxes)
                if self.sendingListofPaxes.count > 0 {
                    for i in 0...self.sendingListofPaxes.count - 1 {
                        if let birtdate =  self.sendingListofPaxes[i].pAX_BIRTHDAY {
                            let year = Int(birtdate.suffix(4))
                            self.manuelPaxAge = currentYear - (year ?? 0)
                            if self.manuelPaxAge >= 0 &&  self.manuelPaxAge < 2 {
                                self.manuelPaxAgeGroup = "INF"
                            }else if self.manuelPaxAge >= 2 &&  self.manuelPaxAge < 6{
                                self.manuelPaxAgeGroup = "TDL"
                            }else if self.manuelPaxAge >= 6 &&  self.manuelPaxAge < 11{
                                self.manuelPaxAgeGroup = "CHL"
                            }else{
                                self.manuelPaxAgeGroup = "ADL"
                            }
                        }
                        
                        self.manuelAddedPaxesList.append(GetInHoseListResponseModel(text: self.sendingListofPaxes[i].pAX_NAME ?? "", ageGroup:  self.manuelPaxAgeGroup, gender:self.sendingListofPaxes[i].pAX_GENDER, room: self.sendingListofPaxes[i].pAX_ROOM, birtDate: self.sendingListofPaxes[i].pAX_BIRTHDAY))
                    }
                }
                if self.manuelAddedPaxesList.count > 0 && self.paxesList.count > 0 {
                    if self.paxesList.count > self.manuelAddedPaxesList.count {
                        for i in 0...self.paxesList.count - 1 {
                            for index in 0...self.manuelAddedPaxesList.count - 1 {
                                if self.manuelAddedPaxesList[index].text != self.paxesList[i].text {
                                    self.paxesList.append(self.manuelAddedPaxesList[i])
                                    self.checkList.append(false)
                                }
                            }
                        }
                    }else {
                        for i in 0...self.manuelAddedPaxesList.count - 1 {
                            for index in 0...self.paxesList.count - 1 {
                                if self.manuelAddedPaxesList[i].text != self.paxesList[index].text {
                                    self.paxesList.append(self.manuelAddedPaxesList[i])
                                    self.checkList.append(false)
                                }
                            }
                        }
                    }
                   
                }else {
                    for i in 0...self.manuelAddedPaxesList.count - 1 {
                            self.paxesList.append(self.manuelAddedPaxesList[i])
                            self.checkList.append(false)
                    }
                }
                
                self.tableView.reloadData()
                // self.labelTouristAdded.text = "\(self.totalPaxesCount + self.tempValue) Tourist Added" ind. shop sayfası ile burdaki farklı çeşitte daha sonra değerlendirilmesi
                // self.paxesListDelegate?.paxesList(ischosen: false, sendingPaxesLis: self.sendingListofPaxes, isChange: true)
                return
            }else {
                self.paxesListinPaxPage.removeAll()
                self.sendingListofPaxes = listofpaxes
                // self.paxesListDelegate?.paxesList(ischosen: false, sendingPaxesLis: self.sendingListofPaxes, isChange: false)
                self.tempValue = changeValue
            }
            if sendingListofPaxes.count > 0 {
                for i in 0...self.sendingListofPaxes.count - 1 {
                    if let birtdate =  Int(self.sendingListofPaxes[i].pAX_BIRTHDAY) {
                        self.manuelPaxAge = birtdate
                        if self.manuelPaxAge > 0 &&  self.manuelPaxAge < 2{
                            self.manuelPaxAgeGroup = "INF"
                        }else if self.manuelPaxAge > 2 &&  self.manuelPaxAge < 6{
                            self.manuelPaxAgeGroup = "TDL"
                        }else if self.manuelPaxAge > 6 &&  self.manuelPaxAge < 11{
                            self.manuelPaxAgeGroup = "CHL"
                        }else{
                            self.manuelPaxAgeGroup = "ADL"
                        }
                    }
                    self.manuelAddedPaxesList.append(GetInHoseListResponseModel.init(text: self.sendingListofPaxes[i].pAX_NAME, ageGroup:  self.sendingListofPaxes[i].pAX_AGEGROUP, gender:  self.sendingListofPaxes[i].pAX_GENDER, room:  self.sendingListofPaxes[i].pAX_ROOM, birtDate:  self.sendingListofPaxes[i].pAX_BIRTHDAY))
                }
            }
            if self.manuelAddedPaxesList.count > 0 {
                for i in 0...self.paxesList.count - 1 {
                    for index in 0...self.manuelAddedPaxesList.count - 1 {
                        if self.manuelAddedPaxesList[index].text != self.paxesList[i].text {
                            self.paxesList.append(self.manuelAddedPaxesList[i])
                            self.checkList.append(false)
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }else{
            return
        }
    }
}

extension ExcPaxCustomView : ExcPaxPageTableViewCellDelegate {
    func checkBoxTapped(checkCounter: Bool, touristName: String, marketGroup: Int, tempPaxes: GetInHoseListResponseModel) {
        self.tempFilteredList = []
        
        if isFiltered == true {
            if let index = self.filteredData.firstIndex(where: {$0 === tempPaxes}){
                self.filteredList[index].isTapped = checkCounter
                self.checkFilteredList[index] = checkCounter
                self.tempFilteredList = self.filteredList
            }
        }else{
            if let index = self.paxesList.firstIndex(where: {$0 === tempPaxes}){
                self.paxesList[index].isTapped = checkCounter
                self.checkList[index] = checkCounter
                self.tempList = self.paxesNameList
            }
        }
        self.tableView.reloadData()
        if checkCounter == true {
            let filter = paxesList.filter{ $0 === tempPaxes}
            // let filter = self.excursionList.filter{($0.tourId?.elementsEqual(tourid) ?? false)}
            self.savePaxesList.append(filter[0])
            
            // manuelPaxes added
            let filterManuelPax = self.manuelAddedPaxesList.filter{ $0 === tempPaxes}
            var manuelPaxList : [Paxes] = []
            if sendingListofPaxes.count > 0 {
                for i in 0...self.sendingListofPaxes.count - 1 {
                    if filterManuelPax[0].text ==  self.sendingListofPaxes[i].pAX_NAME {
                        manuelPaxList.append(self.sendingListofPaxes[i])
                    }
                }
                self.touristDetailInfoList.append(manuelPaxList[0])
            }
            
           //
            
            let getInTouristInfoRequestModelList = GetTouristInfoRequestModel(touristId: filter[0].value ?? 0, resNo: filter[0].resNo ?? "")
            
            NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetTouristInfo, method: .get, parameters: getInTouristInfoRequestModelList.requestPathString() ) { (response : [GetTouristInfoResponseModel] ) in
                if response.count > 0 {
                    self.touristDetailInfoList.append(Paxes(pAX_CHECKOUT_DATE: "", pAX_OPRID: response[0].oprId ?? 0, pAX_OPRNAME: response[0].operatorName ?? "", pAX_PHONE: "", hotelname: "1453", pAX_GENDER: response[0].gender ?? "", pAX_AGEGROUP: response[0].ageGroup ?? "", pAX_NAME: response[0].name ?? "", pAX_BIRTHDAY: response[0].birthDay ?? "", pAX_RESNO: response[0].resNo ?? "", pAX_PASSPORT: response[0].passport ?? "", pAX_ROOM: response[0].room ?? "", pAX_TOURISTREF: response[0].touristIdRef ?? 0, pAX_STATUS: 1))
                   // userDefaultsData.saveTouristDetailInfoList(tour: self.touristDetailInfoList)
                }
            }
            userDefaultsData.saveTouristDetailInfoList(tour: self.touristDetailInfoList)
        }else{
            // let filter = self.excursionList.filter{($0.tourName?.elementsEqual(tourid) ?? false)}
            
            if let insideIndex = self.savePaxesList.firstIndex(where: {$0 === tempPaxes}){
                self.savePaxesList.remove(at: insideIndex)
            }
        }
        self.totalPaxesCount = self.savePaxesList.count
        self.labelTouristAdded.text = "\(self.totalPaxesCount) Tourist Added"
        userDefaultsData.savePaxesList(tour: self.savePaxesList)
    }
}
/*
 extension GetInHoseListResponseModel : Equatable {
 static func == (lhs: GetInHoseListResponseModel, rhs: GetInHoseListResponseModel) -> Bool {
 return true
 }
 }*/
