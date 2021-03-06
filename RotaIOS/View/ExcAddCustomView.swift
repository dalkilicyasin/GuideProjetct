//
//  ExcAddCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.12.2021.
//

import Foundation
import UIKit
import DropDown

protocol ExcAddCustomViewDelegate {
    func excurAddCustomDelegate(changeTransferNumber : Int, changeExtraNumber : Int, extrasTotalPrice : Double, transfersTotalPrice : Double, extraButtonTapped : Bool, savedExtrasList : [Extras], savedTransferList : [Transfers], currentExtrasTotalPrice : Double, currentTransfersTotalPirce : Double)
}

class ExcAddCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var buttonExtras: UIButton!
    @IBOutlet weak var buttonTransfers: UIButton!
    @IBOutlet weak var viewExcursions: MainTextCustomView!
    @IBOutlet weak var labelExtorTransf: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var excAddCustomViewDelegate : ExcAddCustomViewDelegate?
    var extrasList : [Extras] = []
    var transfersList : [Transfers] = []
    var buttonExtraTapped = true
    var excursionMenu = DropDown()
    var excursionListInAddMenu : [GetSearchTourResponseModel] = []
    var tempExcurionMenu : [String] = []
    var filteredExcursionList : [GetSearchTourResponseModel] = []
    var transferChecklist : [Bool] = []
    var extrasChecklist : [Bool] = []
    var saveExtrasList : [Extras] = []
    var saveTransferList : [Transfers] = []
    var transOrExtraischange = false
    @IBOutlet weak var tableViewPax: UITableView!
    var extrasPaxesList : [GetInHoseListResponseModel] = []
    var transferPaxesList : [GetInHoseListResponseModel] = []
    var extrasPaxCheckList : [Bool] = []
    var transfersPaxCheckList : [Bool] = []
    var saveExtrasPaxesList : [GetInHoseListResponseModel] = []
    var saveTransfersPaxesList : [GetInHoseListResponseModel] = []
    var extrasTotalPrice = 0.00
    var flatAmount = 0
    var extrasMinPrice = 0.00
    var extrasMinPerson = 0
    var transfersTotalPrice = 0.00
    var transfersMinPrice = 0.00
    var transfersMinPerson = 0
    var tempaxeslist : [GetInHoseListResponseModel] = []
    var savedExcursionList : [GetSearchTourResponseModel] = []
    var currentExtrasTotalPrice = 0.0
    var currentTransfersTotalPrice = 0.0
    var perPersonSavedTotalPrice = 0.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ExcAddCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
    
            self.excursionListInAddMenu = userDefaultsData.getTourList() ?? self.excursionListInAddMenu
          //  self.savedExcursionList = self.excursionListInAddMenu
            if let paxesList = userDefaultsData.getPaxesList(){
                self.extrasPaxesList = paxesList
                self.transferPaxesList = paxesList
            }
         
        self.labelExtorTransf.addLine(position: .bottom, color: .lightGray, width: 1.0)
        self.tableView.backgroundColor = UIColor.tableViewColor
        self.tableViewPax.backgroundColor = UIColor.tableViewColor
        self.viewMainView.backgroundColor = UIColor.grayColor
        
        self.buttonExtras.clipsToBounds = true
        self.buttonExtras.layer.cornerRadius = 10
        self.buttonExtras.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        self.buttonExtras.backgroundColor = UIColor.greenColor
        
        self.buttonTransfers.clipsToBounds = true
        self.buttonTransfers.layer.cornerRadius = 10
        self.buttonTransfers.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        self.buttonTransfers.layer.borderWidth = 1
        self.buttonTransfers.backgroundColor = UIColor.clear
        self.buttonTransfers.layer.borderColor = UIColor.green.cgColor
        
        self.viewExcursions.layer.cornerRadius = 10
        self.viewExcursions.backgroundColor = UIColor.mainTextColor
      
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddMenuTableViewCell.nib, forCellReuseIdentifier: AddMenuTableViewCell.identifier)
        
        self.tableViewPax.delegate = self
        self.tableViewPax.dataSource = self
        self.tableViewPax.register(AddMenuPaxTableViewCell.nib, forCellReuseIdentifier: AddMenuPaxTableViewCell.identifier)
        
        self.viewExcursions.headerLAbel.text = "Excursion"
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedExcursionMenu))
        gesture.numberOfTouchesRequired = 1
        self.viewExcursions.addGestureRecognizer(gesture)
        
      for listofArray in self.excursionListInAddMenu {
            self.tempExcurionMenu.append(listofArray.tourName ?? "")
        }
        
        self.excursionMenu.dataSource = self.tempExcurionMenu
       // self.excursionMenu.dataSource.insert("", at: 0)
        self.excursionMenu.backgroundColor = UIColor.grayColor
        self.excursionMenu.separatorColor = UIColor.gray
        self.excursionMenu.textColor = .white
        self.excursionMenu.anchorView = self.viewExcursions
        self.excursionMenu.topOffset = CGPoint(x: 0, y:-(self.excursionMenu.anchorView?.plainView.bounds.height)!)
        
        self.excursionMenu.selectionAction = { index, title in
            if title != self.viewExcursions.mainLabel.text {
            }
            self.viewExcursions.mainLabel.text = title
           
            var filtered : [GetSearchTourResponseModel] = []
            
            if self.excursionListInAddMenu.count == 1  || self.excursionListInAddMenu.count == 0 {
                filtered = self.excursionListInAddMenu.filter{($0.tourName?.contains(title) ?? false)}
            }else {
                if self.excursionListInAddMenu.count > 0 {
                    for i in 0...self.excursionListInAddMenu.count - 1 {
                        if i == index {
                            filtered.append(self.excursionListInAddMenu[i])
                        }
                    }
                }
            }
          //  filtered = self.excursionListInAddMenu.filter{($0.tourName?.contains(title) ?? false)}
            
            
            self.filteredExcursionList = filtered
            
            for listofArray in self.filteredExcursionList {
                self.extrasList = listofArray.extras ?? self.extrasList
                self.transfersList = listofArray.transfers ?? self.transfersList
            }
            
            if self.extrasList.count > 0 {
                for index in 0...self.extrasList.count - 1 {
                   // self.extrasList[index].isTapped = false
                    self.extrasChecklist.append(self.extrasList[index].isTapped ?? false)
                }
            }
            
            if self.transfersList.count > 0  {
                for index in 0...self.transfersList.count - 1 {
                   // self.transfersList[index].isTapped = false
                    self.transferChecklist.append(self.transfersList[index].isTapped ?? false)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func tappedExcursionMenu() {
        self.excursionMenu.show()
        self.excursionMenu.direction = .bottom
    }

    
    @IBAction func transfersButtonTapped(_ sender: Any) {
        if  self.buttonExtraTapped == true {
            self.buttonExtraTapped = false
            self.excAddCustomViewDelegate?.excurAddCustomDelegate(changeTransferNumber: self.transfersList.count, changeExtraNumber: self.saveExtrasList.count, extrasTotalPrice: self.extrasTotalPrice, transfersTotalPrice : self.transfersTotalPrice, extraButtonTapped: self.buttonExtraTapped, savedExtrasList : self.saveExtrasList , savedTransferList : self.transfersList, currentExtrasTotalPrice: self.currentExtrasTotalPrice, currentTransfersTotalPirce: self.currentTransfersTotalPrice)
        }
        self.buttonTransfers.backgroundColor = UIColor.greenColor
        self.buttonExtras.layer.borderWidth = 1
        self.buttonExtras.backgroundColor = UIColor.clear
        self.buttonExtras.layer.borderColor = UIColor.greenColor.cgColor
        self.labelExtorTransf.text = "Transfers"
        self.tableView.reloadData()
    }
    
    @IBAction func extrasButtonTapped(_ sender: Any) {
      if  self.buttonExtraTapped == false {
        self.buttonExtraTapped = true
          self.excAddCustomViewDelegate?.excurAddCustomDelegate(changeTransferNumber: self.transfersList.count, changeExtraNumber: self.saveExtrasList.count, extrasTotalPrice: self.extrasTotalPrice, transfersTotalPrice: self.transfersTotalPrice, extraButtonTapped: self.buttonExtraTapped, savedExtrasList : self.saveExtrasList , savedTransferList : self.transfersList, currentExtrasTotalPrice: self.currentExtrasTotalPrice, currentTransfersTotalPirce: self.currentTransfersTotalPrice)
        }
        
        self.buttonExtras.backgroundColor = UIColor.greenColor
        self.buttonTransfers.layer.borderWidth = 1
        self.buttonTransfers.backgroundColor = UIColor.clear
        self.buttonTransfers.layer.borderColor = UIColor.greenColor.cgColor
        self.labelExtorTransf.text = "Extras"
        self.tableView.reloadData()
    }
    
    func extrapriceReduceCalculation( _ extrasSavePaxesList : [GetInHoseListResponseModel] ){
        self.saveExtrasPaxesList = extrasSavePaxesList
           // self.extrasTotalPrice = 0.00
        self.currentExtrasTotalPrice = 0.0
            if self.saveExtrasList.count > 0 && extrasSavePaxesList.count > 0 {
                for i in 0...self.saveExtrasList.count - 1{
                    // Per Person Price calculation
                    if self.saveExtrasList[i].priceType == 35 {
                       
                        for index in 0...extrasSavePaxesList.count - 1 {
                            switch extrasSavePaxesList[index].ageGroup {
                            case "INF":
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].infantPrice ?? 0.00
                            case "TDL":
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].toodlePrice ?? 0.00
                            case "CHD":
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].childPrice ?? 0.00
                            default:
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].adultPrice ?? 0.00
                            }
                        }
                        self.perPersonSavedTotalPrice -= self.currentExtrasTotalPrice
                        self.extrasTotalPrice -= self.currentExtrasTotalPrice
                        self.currentExtrasTotalPrice = -(self.currentExtrasTotalPrice)
                        self.excAddCustomViewDelegate?.excurAddCustomDelegate(changeTransferNumber: self.transfersList.count, changeExtraNumber: self.saveExtrasList.count, extrasTotalPrice: self.extrasTotalPrice, transfersTotalPrice: self.transfersTotalPrice, extraButtonTapped: self.buttonExtraTapped, savedExtrasList : self.saveExtrasList , savedTransferList : self.transfersList, currentExtrasTotalPrice: self.currentExtrasTotalPrice, currentTransfersTotalPirce: self.currentTransfersTotalPrice)
                    }
                }
            }
       /* self.saveExtrasList.removeAll()
        self.saveExtrasPaxesList.removeAll()*/
           // self.showToast(message: "\(self.totalPrice)")
    }
    
    func extrapriceAddCalculation( _ extrasSavePaxesList : [GetInHoseListResponseModel] ){
        self.saveExtrasPaxesList = extrasSavePaxesList
        self.currentExtrasTotalPrice = 0.0
           // self.extrasTotalPrice = 0.00
            if self.saveExtrasList.count > 0 && extrasSavePaxesList.count > 0 {
                for i in 0...self.saveExtrasList.count - 1{
                    // Per Person Price calculation
                    if self.saveExtrasList[i].priceType == 35 {
                        
                        // ??zgeye sor getinforesponse mu yoksa direk gethouselisten d??nen agegrup mu al??nacak
                        /*   let getTouristInfoModel = GetTouristInfoRequestModel.init(touristId: self.paxesListSaved[i].value ?? 0, resNo: self.paxesListSaved[i].resNo ?? "")
                         NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetTouristInfo, method: .get, parameters: getTouristInfoModel.requestPathString()) { (response : [GetTouristInfoResponseModel] ) in
                         if response.count > 0 {
                         
                         }
                         }*/
                        /*
                         if self.tourListSaved[i].infantAge1 ?? 0.00 <= self.tourListSaved[i].infantAge2 ?? 0.00 {
                         self.ageGroup = "INF"
                         }else if self.tourListSaved[i].toodleAge1 ?? 0.00 <= self.tourListSaved[i].toodleAge2 ?? 0.00 {
                         self.ageGroup = "TDL"
                         }else if self.tourListSaved[i].childAge1 ?? 0.00 <= self.tourListSaved[i].childAge1 ?? 0.00 {
                         self.ageGroup = "CHD"
                         }else{
                         self.ageGroup = "ADL"
                         }*/
                        for index in 0...extrasSavePaxesList.count - 1 {
                            switch extrasSavePaxesList[index].ageGroup {
                            case "INF":
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].infantPrice ?? 0.00
                            case "TDL":
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].toodlePrice ?? 0.00
                            case "CHD":
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].childPrice ?? 0.00
                            default:
                                self.currentExtrasTotalPrice += self.saveExtrasList[i].adultPrice ?? 0.00
                            }
                        }
                        self.perPersonSavedTotalPrice += self.currentExtrasTotalPrice
                        self.extrasTotalPrice += self.currentExtrasTotalPrice
                        self.saveExtrasList[i].savedAmount = self.perPersonSavedTotalPrice
                        
                        self.excAddCustomViewDelegate?.excurAddCustomDelegate(changeTransferNumber: self.transfersList.count, changeExtraNumber: self.saveExtrasList.count, extrasTotalPrice: self.extrasTotalPrice, transfersTotalPrice: self.transfersTotalPrice, extraButtonTapped: self.buttonExtraTapped, savedExtrasList : self.saveExtrasList , savedTransferList : self.transfersList, currentExtrasTotalPrice: self.currentExtrasTotalPrice, currentTransfersTotalPirce: self.currentTransfersTotalPrice)
                    }
                    //Flat Price calculation
                   /* else if self.saveExtrasList[i].priceType == 36{
                        let alert = UIAlertController(title: "Flat Price", message: "Please insert Flat amount", preferredStyle: .alert)
                        
                        alert.addTextField {
                            $0.placeholder = "Flat Amount"
                            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
                           }
                        
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

                          let flatAmountAction = UIAlertAction(title: "Submit", style: .default) { [unowned self] _ in
                              guard let flatamount = alert.textFields?[0].text
                                  else { return } // Should never happen
                            self.flatAmount = Int(flatamount) ?? 0
                          }
                        
                        flatAmountAction.isEnabled = false
                        alert.addAction(flatAmountAction)
                        
                        if let topVC = UIApplication.getTopViewController() {
                            topVC.present(alert, animated: true, completion: nil)
                        }
                        self.extrasTotalPrice += self.saveExtrasList[i].flatPrice ?? 0.00
                    }
                    else if self.saveExtrasList[i].priceType == 37{
                        self.extrasMinPerson = Int(self.saveExtrasList[i].minPax ?? Int(0.00))
                        if self.extrasMinPerson > 0 {
                            for index in 0...self.saveExtrasPaxesList.count - 1{
                                if  self.saveExtrasPaxesList[index].ageGroup == "ADL" {
                                    self.extrasMinPrice = self.saveExtrasList[i].minPrice ?? 0.00
                                    self.extrasMinPerson -= 1
                                }else if self.extrasMinPerson > 0 && self.saveExtrasPaxesList[index].ageGroup == "CHD" {
                                    self.extrasMinPrice = self.saveExtrasList[i].minPrice ?? 0.00
                                    self.extrasMinPerson -= 1
                                }else if self.extrasMinPerson > 0 && self.saveExtrasPaxesList[index].ageGroup == "TDL" {
                                    self.extrasMinPrice = self.saveExtrasList[i].minPrice ?? 0.00
                                    self.extrasMinPerson -= 1
                                }else if self.extrasMinPerson > 0 && self.saveExtrasPaxesList[index].ageGroup == "INF" {
                                    self.extrasMinPrice = self.saveExtrasList[i].minPrice ?? 0.00
                                    self.extrasMinPerson -= 1
                                }
                            }
                        }else {
                            for index in 0...self.saveExtrasPaxesList.count - 1{
                                if  self.saveExtrasPaxesList[index].ageGroup == "ADL" {
                                    self.extrasTotalPrice += saveExtrasList[i].adultPrice ?? 0.00
                                }else if self.extrasMinPerson > 0 && self.saveExtrasPaxesList[index].ageGroup == "CHD" {
                                    self.extrasTotalPrice += saveExtrasList[i].childPrice ?? 0.00
                                }else if self.extrasMinPerson > 0 && self.saveExtrasPaxesList[index].ageGroup == "TDL" {
                                    self.extrasTotalPrice += saveExtrasList[i].toodlePrice ?? 0.00
                                }else if self.extrasMinPerson > 0 && self.saveExtrasPaxesList[index].ageGroup == "INF" {
                                    self.extrasTotalPrice += saveExtrasList[i].infantPrice ?? 0.00
                                }
                            }
                        }
                        self.extrasTotalPrice += self.extrasMinPrice
                      
                    }*/
                }
            }
     /*   self.saveExtrasList.removeAll()
        self.saveExtrasPaxesList.removeAll()*/
           // self.showToast(message: "\(self.totalPrice)")
    }
}

extension ExcAddCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            if buttonExtraTapped == true {
                return self.extrasList.count
            }else {
                return self.transfersList.count
            }
        }else if tableView == self.tableViewPax {
            if buttonExtraTapped == true {
                return self.extrasPaxesList.count
            }else {
                return self.transferPaxesList.count
            }
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddMenuTableViewCell.identifier ) as! AddMenuTableViewCell
            cell.addMenuTableViewCellDelegate = self
            if self.buttonExtraTapped == true {
                cell.labelTransforExtraName.text = self.extrasList[indexPath.row].desc
                cell.labelPriceType.text = self.extrasList[indexPath.row].priceTypeDesc
                cell.labelAdultPrice.text = String(self.extrasList[indexPath.row].adultPrice ?? 0.0)
                cell.labelChildPrice.text = String(self.extrasList[indexPath.row].childPrice ?? 0.0)
                cell.labelInfantPrice.text = String(self.extrasList[indexPath.row].infantPrice ?? 0.0)
                cell.labelToodlePrice.text = String(self.extrasList[indexPath.row].toodlePrice ?? 0.0)
                cell.labelCurrency.text = self.extrasList[indexPath.row].currencyDesc
                cell.labelFlatPrice.text = String(self.extrasList[indexPath.row].flatPrice ?? 0.0)
                cell.extraListInAddMenuCell = self.extrasList[indexPath.row]
                cell.priceTypeDesc = self.extrasList[indexPath.row].priceType ?? 0
                cell.transExtrDesc = self.extrasList[indexPath.row].desc ?? ""
                cell.isTappedCheck = self.extrasList[indexPath.row].isTapped ?? false
                cell.tourDate = self.extrasList[indexPath.row].tourDate ?? ""
                return cell
            }else{
                cell.labelTransforExtraName.text = self.transfersList[indexPath.row].desc
                cell.labelPriceType.text = self.transfersList[indexPath.row].priceTypeDesc
                cell.labelAdultPrice.text = String(self.transfersList[indexPath.row].adultPrice ?? 0.0)
                cell.labelChildPrice.text = String(self.transfersList[indexPath.row].childPrice ?? 0.0)
                cell.labelInfantPrice.text = String(self.transfersList[indexPath.row].infantPrice ?? 0.0)
                cell.labelToodlePrice.text = String(self.transfersList[indexPath.row].toodlePrice ?? 0.0)
                cell.labelCurrency.text = self.transfersList[indexPath.row].currencyDesc
                cell.labelFlatPrice.text = String(self.transfersList[indexPath.row].flatPrice ?? 0.0)
                cell.priceTypeDesc = self.transfersList[indexPath.row].priceType ?? 0
                cell.transferListInAddMenuCell = self.transfersList[indexPath.row]
                cell.transExtrDesc = self.transfersList[indexPath.row].desc ?? ""
                cell.isTappedCheck = self.transfersList[indexPath.row].isTapped ?? false
                cell.tourDate = self.transfersList[indexPath.row].tourDate ?? ""
                return cell
            }
        }else if tableView == self.tableViewPax {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddMenuPaxTableViewCell.identifier ) as! AddMenuPaxTableViewCell
            cell.addMenuPaxTableViewCellDelegate = self
            if self.buttonExtraTapped == true {
                if self.extrasPaxesList.count > 0 && self.extrasPaxCheckList.count > 0 {
                    if self.extrasPaxesList[indexPath.row].text == nil {
                        cell.labelPaxName.text = self.extrasPaxesList[indexPath.row].name
                        cell.isTappedCheck = self.extrasPaxesList[indexPath.row].isTapped ?? false
                    }else {
                        cell.labelPaxName.text = self.extrasPaxesList[indexPath.row].text
                        cell.isTappedCheck = self.extrasPaxesList[indexPath.row].isTapped ?? false
                    }
                  cell.paxesListInCell = self.extrasPaxesList[indexPath.row]
                  //  cell.isTappedCheck = self.extrasPaxCheckList[indexPath.row]
                    return cell
                }
            }else{
                if self.transferPaxesList.count > 0  && self.transfersPaxCheckList.count > 0 {
                    if self.transferPaxesList[indexPath.row].text == nil {
                        cell.labelPaxName.text = self.transferPaxesList[indexPath.row].name
                    }else {
                        cell.labelPaxName.text = self.transferPaxesList[indexPath.row].text
                    }
                    cell.paxesListInCell = self.transferPaxesList[indexPath.row]
                    cell.isTappedCheck = self.transfersPaxCheckList[indexPath.row]
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}

extension ExcAddCustomView : AddMenuTableViewCellDelegate, AddMenuPaxTableViewCellDelegate {
    func addMenuPaxcheckBoxTapped(checkCounter: Bool, touristName: String, tempPaxes: GetInHoseListResponseModel) {
        var adlCount = 0
        var chdCount = 0
        var tdlCount = 0
        var infCount = 0
        self.saveExtrasPaxesList.removeAll()
        self.tempaxeslist.removeAll()
        if let index = self.extrasPaxesList.firstIndex(where: {$0 === tempPaxes}){
            self.extrasPaxesList[index].isTapped = checkCounter
            self.extrasPaxCheckList[index] = checkCounter
        }
        
        if let index = self.transferPaxesList.firstIndex(where: {$0 === tempPaxes}){
            self.transferPaxesList[index].isTapped = checkCounter
            self.transfersPaxCheckList[index] = checkCounter
        }
        self.tableViewPax.reloadData()
        self.tempaxeslist.append(tempPaxes)
        if self.tempaxeslist[0].ageGroup == "ADL"{
            adlCount += 1
        }else if self.tempaxeslist[0].ageGroup == "CHD"{
            chdCount += 1
        }else if self.tempaxeslist[0].ageGroup == "TDL"{
            tdlCount += 1
        }else{
            infCount += 1
        }
        
        if checkCounter == true {
            self.extrapriceAddCalculation(self.tempaxeslist)
            if self.extrasList.count > 0 {
                for i in 0...self.extrasList.count - 1 {
                    self.extrasList[i].adultCount = adlCount
                    self.extrasList[i].childCount = chdCount
                    self.extrasList[i].toodleCount = tdlCount
                    self.extrasList[i].infantCount = infCount
                }
            }
        }else {
            self.extrapriceReduceCalculation(self.tempaxeslist)
        }
    }
    
   func checkBoxTapped(checkCounter: Bool, transExtrDesc : String, priceTypeDesc : Int, extras : Extras?, transfers : Transfers?, tourdate: String) {
        if let index = self.extrasList.firstIndex(where: {$0.desc == transExtrDesc && $0.tourDate == tourdate }){
            self.extrasList[index].isTapped = checkCounter
            self.extrasChecklist[index] = checkCounter
        }
        
        if let index = self.transfersList.firstIndex(where: {$0.desc == transExtrDesc && $0.tourDate == tourdate}){
            self.transfersList[index].isTapped = checkCounter
            self.transferChecklist[index] = checkCounter
        }
       
//       self.filteredExcursionList[0].extras = self.extrasList
    //   self.filteredExcursionList[0].transfers = self.transfersList
     
     //  let filter = self.savedExcursionList.filter{ $0 === self.filteredExcursionList[0]}
      
        self.tableView.reloadData()
        
        if checkCounter == true {
            self.currentExtrasTotalPrice = 0.0
            self.currentTransfersTotalPrice = 0.0
            if let paxesList = userDefaultsData.getPaxesList(){
                self.extrasPaxesList = paxesList
                self.transferPaxesList = paxesList
            }
            
            if priceTypeDesc == 35 {
                self.perPersonSavedTotalPrice = 0.0
                print(priceTypeDesc)
                if self.extrasPaxesList.count > 0 {
                    for index in 0...self.extrasPaxesList.count - 1 {
                        self.extrasPaxesList[index].isTapped = false
                        self.extrasPaxCheckList.append(self.extrasPaxesList[index].isTapped ?? false)
                    }
                }
                
                if self.transferPaxesList.count > 0  {
                    for index in 0...self.transferPaxesList.count - 1 {
                        self.transferPaxesList[index].isTapped = false
                        self.transfersPaxCheckList.append(self.transferPaxesList[index].isTapped ?? false)
                    }
                }
                
                self.filteredExcursionList[0].extras = self.extrasList
                self.filteredExcursionList[0].transfers = self.transfersList
                if let insideIndex = self.excursionListInAddMenu.firstIndex(where: {$0.tourName == self.filteredExcursionList[0].tourName && $0.tourDate == self.filteredExcursionList[0].tourDate}){
                    self.excursionListInAddMenu.remove(at: insideIndex)
                    self.excursionListInAddMenu.insert(self.filteredExcursionList[0], at: insideIndex)
                }
                self.tableViewPax.reloadData()
               /* self.extrasPaxesList = []
                self.transferPaxesList = []
                self.extrasPaxCheckList = []
                self.transfersPaxCheckList = [] */
            } else if priceTypeDesc == 36 {
                    let alert = UIAlertController(title: "Flat Price", message: "Please insert Flat amount", preferredStyle: .alert)
                    alert.addTextField {
                        $0.placeholder = "Flat Amount"
                        $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
                       }
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                      let flatAmountAction = UIAlertAction(title: "Submit", style: .default) { [unowned self] _ in
                          guard let flatamount = alert.textFields?[0].text
                           
                              else { return } // Should never happen
                        self.flatAmount = Int(flatamount) ?? 0
                        self.extrasTotalPrice += Double(self.flatAmount) * (extras?.flatPrice ?? 0.00)
                        self.transfersTotalPrice += Double(self.flatAmount) * (transfers?.flatPrice ?? 0.00)
                          // Perform login action
                          if let index = self.extrasList.firstIndex(where: {$0.desc == transExtrDesc && $0.tourDate == tourdate}){
                              self.extrasList[index].savedAmount = self.extrasTotalPrice
                          }
                          
                          if let index = self.transfersList.firstIndex(where: {$0.desc == transExtrDesc && $0.tourDate == tourdate}){
                              self.transfersList[index].savedAmount = self.transfersTotalPrice
                          }
                
                          self.filteredExcursionList[0].extras = self.extrasList
                          self.filteredExcursionList[0].transfers = self.transfersList
                          if let insideIndex = self.excursionListInAddMenu.firstIndex(where: {$0.tourName == self.filteredExcursionList[0].tourName && $0.tourDate == self.filteredExcursionList[0].tourDate}){
                              self.excursionListInAddMenu.remove(at: insideIndex)
                              self.excursionListInAddMenu.insert(self.filteredExcursionList[0], at: insideIndex)
                          }
                          
                          self.excAddCustomViewDelegate?.excurAddCustomDelegate(changeTransferNumber: self.transfersList.count, changeExtraNumber: self.saveExtrasList.count, extrasTotalPrice: self.extrasTotalPrice, transfersTotalPrice: self.transfersTotalPrice, extraButtonTapped: self.buttonExtraTapped, savedExtrasList : self.saveExtrasList , savedTransferList : self.transfersList, currentExtrasTotalPrice: self.currentExtrasTotalPrice, currentTransfersTotalPirce: self.currentTransfersTotalPrice)
                      }
               
                    
                  //  flatAmountAction.isEnabled = false
                    alert.addAction(flatAmountAction)
                    
                    if let topVC = UIApplication.getTopViewController() {
                        topVC.present(alert, animated: true, completion: nil)
                    }
                
            } else if priceTypeDesc == 37 {
                //extras
                self.extrasMinPrice = 0
                self.extrasMinPerson = Int(extras?.minPax  ?? Int(0.00))
                if self.extrasMinPerson > 0 {
                    for index in 0...self.extrasPaxesList.count - 1{
                        if  self.extrasPaxesList[index].ageGroup == "ADL" {
                            self.extrasMinPrice = extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                            self.extrasMinPrice = extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                            self.extrasMinPrice = extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                            self.extrasMinPrice = extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }
                    }
                }else {
                    for index in 0...self.extrasPaxesList.count - 1{
                        if  self.extrasPaxesList[index].ageGroup == "ADL" {
                            self.extrasMinPrice += extras?.adultPrice ?? 0.00
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                            self.extrasTotalPrice += extras?.childPrice ?? 0.00
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                            self.extrasTotalPrice += extras?.toodlePrice ?? 0.00
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                            self.extrasTotalPrice += extras?.infantPrice ?? 0.00
                        }
                    }
                }
                
                // transfers
                self.transfersMinPrice = 0
                self.transfersMinPerson = Int(transfers?.minPax  ?? Int(0.00))
                if self.transfersMinPerson > 0 {
                    for index in 0...self.extrasPaxesList.count - 1{
                        if  self.extrasPaxesList[index].ageGroup == "ADL" {
                            self.transfersMinPrice = transfers?.minPrice ?? 0.00
                            self.transfersMinPerson -= 1
                        }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                            self.transfersMinPrice = transfers?.minPrice ?? 0.00
                            self.transfersMinPerson -= 1
                        }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                            self.transfersMinPrice = transfers?.minPrice ?? 0.00
                            self.transfersMinPerson -= 1
                        }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                            self.transfersMinPrice = transfers?.minPrice ?? 0.00
                            self.transfersMinPerson -= 1
                        }
                    }
                }else {
                    for index in 0...self.extrasPaxesList.count - 1{
                        if  self.extrasPaxesList[index].ageGroup == "ADL" {
                            self.transfersTotalPrice += transfers?.adultPrice ?? 0.00
                        }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                            self.transfersTotalPrice += transfers?.childPrice ?? 0.00
                        }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                            self.extrasTotalPrice += transfers?.toodlePrice ?? 0.00
                        }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                            self.transfersTotalPrice += transfers?.infantPrice ?? 0.00
                        }
                    }
                }
                self.extrasTotalPrice += self.extrasMinPrice
                self.transfersTotalPrice += self.transfersMinPrice
                
                self.filteredExcursionList[0].extras = self.extrasList
                self.filteredExcursionList[0].transfers = self.transfersList
                if let insideIndex = self.excursionListInAddMenu.firstIndex(where: {$0.tourName == self.filteredExcursionList[0].tourName && $0.tourDate == self.filteredExcursionList[0].tourDate}){
                    self.excursionListInAddMenu.remove(at: insideIndex)
                    self.excursionListInAddMenu.insert(self.filteredExcursionList[0], at: insideIndex)
                }
            }
            
            let filterExtras = extrasList.filter{ $0.desc == transExtrDesc && $0.tourDate == tourdate}
            let filterTransfers = transfersList.filter{ $0.desc == transExtrDesc && $0.tourDate == tourdate}
           // let filter = self.excursionList.filter{($0.tourId?.elementsEqual(tourid) ?? false)}
            for index in filterExtras {
                self.saveExtrasList.append(index)
            }
            
            for index in filterTransfers {
                self.saveTransferList.append(index)
            }
            
        }else{
            if priceTypeDesc == 35 {
                //self.extrasTotalPrice = 0.00
               // self.transfersTotalPrice = 0.00
                if self.extrasPaxesList.count > 0 {
                    for i in 0...self.extrasPaxesList.count - 1 {
                        self.extrasPaxesList[i].isTapped = false
                    }
                }
                if self.transferPaxesList.count > 0 {
                    for i in 0...self.transferPaxesList.count - 1 {
                        self.transferPaxesList[i].isTapped = false
                    }
                }
                self.transferPaxesList.removeAll()
                self.extrasPaxesList.removeAll()
                self.tableViewPax.reloadData()
               if let index = self.extrasList.firstIndex(where: {$0.desc == transExtrDesc && $0.tourDate == tourdate}){
                    self.perPersonSavedTotalPrice -= self.extrasList[index].savedAmount ?? 0.0
                }
                
                self.extrasTotalPrice -= self.perPersonSavedTotalPrice
            }
            // reduce price
          if priceTypeDesc == 36 {
                    let alert = UIAlertController(title: "WARNING", message: "Are you sure delete Transfer/Extra price?", preferredStyle: .alert)
                   
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

                      let flatAmountAction = UIAlertAction(title: "Yes", style: .default) { [unowned self] _ in
                       
                          
                          if let index = self.extrasList.firstIndex(where: {$0.desc == transExtrDesc && $0.tourDate == tourdate}){
                              self.extrasTotalPrice -=  self.extrasList[index].savedAmount ?? 0.0
                          }
                          
                          if let index = self.transfersList.firstIndex(where: {$0.desc == transExtrDesc && $0.tourDate == tourdate}){
                              self.transfersTotalPrice -=  self.transfersList[index].savedAmount ?? 0.0
                          }
                          
                          self.filteredExcursionList[0].extras = self.extrasList
                          self.filteredExcursionList[0].transfers = self.transfersList
                          if let insideIndex = self.excursionListInAddMenu.firstIndex(where: {$0.tourName == self.filteredExcursionList[0].tourName && $0.tourDate == self.filteredExcursionList[0].tourDate}){
                              self.excursionListInAddMenu.remove(at: insideIndex)
                              self.excursionListInAddMenu.insert(self.filteredExcursionList[0], at: insideIndex)
                          }
                          
                     
                          
                       /* self.extrasTotalPrice -= Double(self.flatAmount) * (extras?.flatPrice ?? 0.00)
                        self.transfersTotalPrice -= Double(self.flatAmount) * (transfers?.flatPrice ?? 0.00) */
                          // Perform login action
                          self.excAddCustomViewDelegate?.excurAddCustomDelegate(changeTransferNumber: self.transfersList.count, changeExtraNumber: self.saveExtrasList.count, extrasTotalPrice: self.extrasTotalPrice, transfersTotalPrice: self.transfersTotalPrice, extraButtonTapped: self.buttonExtraTapped, savedExtrasList : self.saveExtrasList , savedTransferList : self.transfersList, currentExtrasTotalPrice: self.currentExtrasTotalPrice, currentTransfersTotalPirce: self.currentTransfersTotalPrice)
                      }
                    
                  //  flatAmountAction.isEnabled = false
                    alert.addAction(flatAmountAction)
                    
                    if let topVC = UIApplication.getTopViewController() {
                        topVC.present(alert, animated: true, completion: nil)
                    }
            } else if priceTypeDesc == 37 {
                self.extrasMinPrice = 0
                self.extrasMinPerson = Int(extras?.minPax  ?? Int(0.00))
                self.transfersMinPrice = 0
                self.transfersMinPerson = Int(transfers?.minPax  ?? Int(0.00))
                if self.extrasMinPerson > 0 {
                    for index in 0...self.extrasPaxesList.count - 1{
                        if  self.extrasPaxesList[index].ageGroup == "ADL" {
                            self.extrasMinPrice -= extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                            self.extrasMinPrice -= extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                            self.extrasMinPrice -= extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                            self.extrasMinPrice -= extras?.minPrice ?? 0.00
                            self.extrasMinPerson -= 1
                        }
                    }
                }else {
                    for index in 0...self.extrasPaxesList.count - 1{
                        if  self.extrasPaxesList[index].ageGroup == "ADL" {
                            self.extrasMinPrice -= extras?.adultPrice ?? 0.00
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                            self.extrasTotalPrice -= extras?.childPrice ?? 0.00
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                            self.extrasTotalPrice -= extras?.toodlePrice ?? 0.00
                        }else if self.extrasMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                            self.extrasTotalPrice -= extras?.infantPrice ?? 0.00
                        }
                    }
                }
                
                  if self.transfersMinPerson > 0 {
                      for index in 0...self.extrasPaxesList.count - 1{
                          if  self.extrasPaxesList[index].ageGroup == "ADL" {
                              self.transfersMinPrice = transfers?.minPrice ?? 0.00
                              self.transfersMinPerson -= 1
                          }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                              self.transfersMinPrice = transfers?.minPrice ?? 0.00
                              self.transfersMinPerson -= 1
                          }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                              self.transfersMinPrice = transfers?.minPrice ?? 0.00
                              self.transfersMinPerson -= 1
                          }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                              self.transfersMinPrice = transfers?.minPrice ?? 0.00
                              self.transfersMinPerson -= 1
                          }
                      }
                  }else {
                      for index in 0...self.extrasPaxesList.count - 1{
                          if  self.extrasPaxesList[index].ageGroup == "ADL" {
                              self.transfersTotalPrice -= transfers?.adultPrice ?? 0.00
                          }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "CHD" {
                              self.transfersTotalPrice -= transfers?.childPrice ?? 0.00
                          }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "TDL" {
                              self.extrasTotalPrice -= transfers?.toodlePrice ?? 0.00
                          }else if self.transfersMinPerson > 0 && self.extrasPaxesList[index].ageGroup == "INF" {
                              self.transfersTotalPrice -= transfers?.infantPrice ?? 0.00
                          }
                      }
                  }
                
                self.currentExtrasTotalPrice = self.extrasMinPrice
                self.currentTransfersTotalPrice = self.transfersMinPrice
                self.extrasTotalPrice += self.extrasMinPrice
                self.transfersTotalPrice += self.transfersMinPrice
                
                self.currentExtrasTotalPrice = -(self.currentExtrasTotalPrice)
                self.currentTransfersTotalPrice = -(self.currentTransfersTotalPrice)
            }
            
           // let filter = self.excursionList.filter{($0.tourName?.elementsEqual(tourid) ?? false)}
            let filterExtras = extrasList.filter{ $0.desc == transExtrDesc && $0.tourDate == tourdate}
            let filterTransfers = transfersList.filter{ $0.desc == transExtrDesc && $0.tourDate == tourdate}
            
            
            if filterExtras.count > 0 {
                if let insideIndex = self.saveExtrasList.firstIndex(where: {$0.desc == filterExtras[0].desc && $0.tourDate == self.filteredExcursionList[0].tourDate}){
                    self.saveExtrasList.remove(at: insideIndex)
                    
                }
            }else if filterTransfers.count > 0 {
                if let insideIndex = self.saveTransferList.firstIndex(where: {$0.desc == filterTransfers[0].desc && $0.tourDate == self.filteredExcursionList[0].tourDate}){
                    self.saveTransferList.remove(at: insideIndex)
                }
            }else{
                return
            }
            
            self.filteredExcursionList[0].extras = self.extrasList
            self.filteredExcursionList[0].transfers = self.transfersList
            if let insideIndex = self.excursionListInAddMenu.firstIndex(where: {$0.tourName == self.filteredExcursionList[0].tourName && $0.tourDate == self.filteredExcursionList[0].tourDate}){
                self.excursionListInAddMenu.remove(at: insideIndex)
                self.excursionListInAddMenu.insert(self.filteredExcursionList[0], at: insideIndex)
            } 
        }
       self.excAddCustomViewDelegate?.excurAddCustomDelegate(changeTransferNumber: self.transfersList.count, changeExtraNumber: self.saveExtrasList.count, extrasTotalPrice: self.extrasTotalPrice, transfersTotalPrice: self.transfersTotalPrice, extraButtonTapped: self.buttonExtraTapped, savedExtrasList : self.saveExtrasList , savedTransferList : self.saveTransferList, currentExtrasTotalPrice: self.currentExtrasTotalPrice, currentTransfersTotalPirce: self.currentTransfersTotalPrice)
      }
  }

