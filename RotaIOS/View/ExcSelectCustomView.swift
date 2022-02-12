//
//  ExcSelectCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 30.11.2021.
//

import Foundation
import UIKit

protocol ExcSelectDelegate {
    func exSelectDelegateInf(paxButtonTapped: Bool?)
}

class ExcSelectCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var buttonTour: UIButton!
    @IBOutlet weak var buttonPaxes: UIButton!
    @IBOutlet weak var buttonDefault: UIButton!
    @IBOutlet weak var buttonPromotion: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelExcursion: UILabel!
    @IBOutlet weak var viewTourDetailHeader: UIView!
    @IBOutlet weak var labelPickUpTime: UILabel!
    var excursionList : [GetSearchTourResponseModel] = []
    var viewPaxCustomView : ExcPaxCustomView?
    var excSelectDelegate : ExcSelectDelegate?
    var paxSelected = false
    var checkFilteredList : [Bool] = []
    var filteredData : [GetSearchTourResponseModel] = []
    var filteredList : [GetSearchTourResponseModel] = []
    var tempFilteredList : [GetSearchTourResponseModel] = []
    var isFiltered = false
    var checkList : [Bool] = []
    var savesTourList : [GetSearchTourResponseModel] = []
    var currentTime = Date()
    var pickUpTimeList : [String] = []
    var pickUpTime = ""
    var promotionPickupTimeList : [String] = []
    var promotionList : [GetSearchTourResponseModel] = []
    var promotionButtonTapped = false
    var checkPromotionList : [Bool] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        if Connectivity.isConnectedToInternet {
            print("connect")
        } else {
            self.excursionList = userDefaultsData.getSearchTourOffline() ?? [GetSearchTourResponseModel]()
        }
        
        Bundle.main.loadNibNamed(String(describing: ExcSelectCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.buttonTour.clipsToBounds = true
        self.buttonTour.layer.cornerRadius = 10
        self.buttonTour.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        self.buttonPaxes.clipsToBounds = true
        self.buttonPaxes.layer.cornerRadius = 10
        self.buttonPaxes.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        self.buttonDefault.clipsToBounds = true
        self.buttonDefault.layer.cornerRadius = 10
        self.buttonDefault.layer.maskedCorners = [.layerMinXMinYCorner]
        self.buttonPromotion.clipsToBounds = true
        self.buttonPromotion.layer.cornerRadius = 10
        self.buttonPromotion.layer.maskedCorners = [.layerMaxXMinYCorner]
        self.buttonPromotion.layer.borderWidth = 1
        self.buttonPromotion.backgroundColor = UIColor.clear
        self.buttonPromotion.layer.borderColor = UIColor.greenColor.cgColor
        self.viewMainView.backgroundColor = UIColor.grayColor
        self.buttonTour.backgroundColor = UIColor.greenColor
        self.buttonDefault.backgroundColor = UIColor.greenColor
        self.buttonPaxes.layer.borderWidth = 1
        self.buttonPaxes.backgroundColor = UIColor.clear
        self.buttonPaxes.layer.borderColor = UIColor.greenColor.cgColor
        self.tableView.backgroundColor = UIColor.tableViewColor
        self.labelExcursion.addLine(position: .bottom, color: .lightGray, width: 1.0)
        print( self.excursionList.count)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ExcursionListTableViewCell.nib, forCellReuseIdentifier: ExcursionListTableViewCell.identifier)
        
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
        self.searchBar.delegate = self
    
    }
    
    @IBAction func toursButtonTapped(_ sender: Any) {
        self.promotionButtonTapped = false
        self.buttonPromotion.backgroundColor = UIColor.clear
        self.buttonDefault.backgroundColor = UIColor.greenColor
        self.buttonPromotion.layer.borderWidth = 1
        self.buttonPromotion.layer.borderColor = UIColor.greenColor.cgColor
        self.tableView.reloadData()
    }
    
    @IBAction func promotionButtonTapped(_ sender: Any) {
        self.promotionButtonTapped = true
        self.buttonPromotion.backgroundColor = UIColor.greenColor
        self.buttonDefault.backgroundColor = UIColor.clear
        self.buttonDefault.layer.borderWidth = 1
        self.buttonDefault.layer.borderColor = UIColor.greenColor.cgColor
        self.tableView.reloadData()
    }
    
    @IBAction func tourButtonTapped(_ sender: Any) {
        self.paxSelected = false
        self.excSelectDelegate?.exSelectDelegateInf(paxButtonTapped: self.paxSelected)
    }
    
    @IBAction func paxButtonTapped(_ sender: Any) {
        self.paxSelected = true
        self.excSelectDelegate?.exSelectDelegateInf(paxButtonTapped: self.paxSelected)
    }
}

extension ExcSelectCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered == true {
            return self.filteredData.count
        }else{
            if self.promotionButtonTapped == true {
                return self.promotionList.count
            }else{
                return self.excursionList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExcursionListTableViewCell.identifier) as! ExcursionListTableViewCell
        cell.excursionListTableViewCellDelegate = self
        if self.isFiltered == true {
            cell.labelExcursion.text = self.filteredData[indexPath.row].tourName
            cell.labelTourdate.text = self.filteredData[indexPath.row].tourDateStr
            if pickUpTimeList.count == 0 {
                cell.textPickUpTime.text = self.filteredData[indexPath.row].pickUpTime
            }else if pickUpTimeList.count > 0{
                cell.textPickUpTime.text = self.pickUpTimeList[indexPath.row]
            }
            // cell.labelSeat.text = self.excursionList[indexPath.row] // yok
            cell.labelPriceType.text = String(self.filteredData[indexPath.row].priceType ?? 0) // pricetypedesc mi yoksa pricetype mı?
            cell.labelCurrency.text = self.filteredData[indexPath.row].currencyDesc // currencyy mi yoksa currencyDesc mi?
            cell.labelAdultPrice.text = String(self.filteredData[indexPath.row].adultPrice ?? 0)
            cell.labelChildPrice.text = String(self.filteredData[indexPath.row].childPrice ?? 0)
            cell.labelInfantPrice.text = String(self.filteredData[indexPath.row].infantPrice ?? 0)
            cell.labelToodlePrice.text = String(self.filteredData[indexPath.row].toodlePrice ?? 0)
            cell.labelMinPrice.text = String(self.filteredData[indexPath.row].minPrice ?? 0)
            cell.labelMinPax.text = String(self.filteredData[indexPath.row].minPax ?? 0)
            cell.labelTotalPrice.text = String(self.filteredData[indexPath.row].totalPrice ?? 0)
            cell.labelFlatPricw.text = String(self.filteredData[indexPath.row].flatPrice ?? 0)
            cell.tourDate = self.filteredData[indexPath.row].tourDate ?? ""
            cell.excursionListInCell = self.filteredData[indexPath.row]
            cell.isTappedCheck = self.checkFilteredList[indexPath.row]
            cell.tourid = self.filteredData[indexPath.row].tourId ?? 0
            cell.priceTypeDesc = filteredData[indexPath.row].priceType ?? 0
            cell.pickuptime = filteredData[indexPath.row].pickUpTime ?? ""
        }else {
            if self.promotionButtonTapped == true {
                cell.pickuptime = ""
                if Connectivity.isConnectedToInternet {
                    print("connect")
                    cell.labelExcursion.text = self.promotionList[indexPath.row].tourName
                    if pickUpTimeList.count == 0 {
                        cell.textPickUpTime.text = self.promotionList[indexPath.row].pickUpTime
                    }else if promotionPickupTimeList.count > 0{
                        cell.textPickUpTime.text = self.promotionPickupTimeList[indexPath.row]
                    }
                    // cell.labelSeat.text = self.promotionList[indexPath.row] // yok
                    cell.labelPriceType.text = String(self.promotionList[indexPath.row].priceTypeDesc ?? "") // pricetypedesc mi yoksa pricetype mı?
                    cell.labelCurrency.text = self.promotionList[indexPath.row].currencyDesc // currencyy mi yoksa currencyDesc mi?
                    cell.labelAdultPrice.text = String(self.promotionList[indexPath.row].adultPrice ?? 0)
                    cell.labelChildPrice.text = String(self.promotionList[indexPath.row].childPrice ?? 0)
                    cell.labelInfantPrice.text = String(self.promotionList[indexPath.row].infantPrice ?? 0)
                    cell.labelToodlePrice.text = String(self.promotionList[indexPath.row].toodlePrice ?? 0)
                    cell.labelMinPrice.text = String(self.promotionList[indexPath.row].minPrice ?? 0)
                    cell.labelMinPax.text = String(self.promotionList[indexPath.row].minPax ?? 0)
                    cell.labelTotalPrice.text = String(self.promotionList[indexPath.row].totalPrice ?? 0)
                    cell.labelFlatPricw.text = String(self.promotionList[indexPath.row].flatPrice ?? 0)
                    cell.tourDate = self.promotionList[indexPath.row].tourDate ?? ""
                    cell.labelTourdate.text = self.promotionList[indexPath.row].tourDateStr ?? ""
                    cell.excursionListInCell = self.promotionList[indexPath.row]
                    cell.isTappedCheck = self.checkPromotionList[indexPath.row]
                    cell.tourid = self.promotionList[indexPath.row].tourId  ?? 0
                    cell.priceTypeDesc = promotionList[indexPath.row].priceType ?? 0
                    cell.pickuptime = promotionList[indexPath.row].pickUpTime ?? ""
                } else {
                    return cell
                }
            }else{
                cell.labelExcursion.text = self.excursionList[indexPath.row].tourName
             /*   if pickUpTimeList.count == 0 {
                    
                }else if pickUpTimeList.count > 0{
                    cell.textPickUpTime.text = self.pickUpTimeList[indexPath.row]
                }*/
                cell.textPickUpTime.text = self.excursionList[indexPath.row].pickUpTime
                // cell.labelSeat.text = self.excursionList[indexPath.row] // yok
                cell.labelPriceType.text = String(self.excursionList[indexPath.row].priceTypeDesc ?? "") // pricetypedesc mi yoksa pricetype mı?
                cell.labelCurrency.text = self.excursionList[indexPath.row].currencyDesc // currencyy mi yoksa currencyDesc mi?
                cell.labelAdultPrice.text = String(self.excursionList[indexPath.row].adultPrice ?? 0)
                cell.labelChildPrice.text = String(self.excursionList[indexPath.row].childPrice ?? 0)
                cell.labelInfantPrice.text = String(self.excursionList[indexPath.row].infantPrice ?? 0)
                cell.labelToodlePrice.text = String(self.excursionList[indexPath.row].toodlePrice ?? 0)
                cell.labelMinPrice.text = String(self.excursionList[indexPath.row].minPrice ?? 0)
                cell.labelMinPax.text = String(self.excursionList[indexPath.row].minPax ?? 0)
                cell.labelTotalPrice.text = String(self.excursionList[indexPath.row].totalPrice ?? 0)
                cell.labelFlatPricw.text = String(self.excursionList[indexPath.row].flatPrice ?? 0)
                cell.tourDate = self.excursionList[indexPath.row].tourDate ?? ""
                cell.labelTourdate.text = self.excursionList[indexPath.row].tourDateStr ?? ""
                cell.excursionListInCell = self.excursionList[indexPath.row]
                cell.isTappedCheck = self.checkList[indexPath.row]
                cell.tourid = self.excursionList[indexPath.row].tourId  ?? 0
                cell.priceTypeDesc = excursionList[indexPath.row].priceType ?? 0
                cell.pickuptime = excursionList[indexPath.row].pickUpTime ?? ""
            }
        }
        return cell
    }
}

extension ExcSelectCustomView : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = []
        self.checkFilteredList = []
        self.filteredList  = []
        
        if searchText.elementsEqual(""){
            self.isFiltered = false
            //  self.paxesNameList = self.tempPaxesNameList
            self.filteredData = self.excursionList
        }else {
            self.isFiltered = true
            for data in self.excursionList{
                if data.tourName!.lowercased().contains(searchText.lowercased()){
                    self.filteredData.append(data)
                    //   self.paxesNameList = self.filteredData
                }
            }
        }
        
        if filteredData.count > 0 {
            for index in 0...self.filteredData.count - 1 {
                let filter = self.excursionList.filter{($0.tourName?.contains(self.filteredData[index].tourName ?? "") ?? false)}
                if filter.count > 0 {
                    self.filteredList.append(filter[0])
                }
            }
            for index in 0...self.filteredList.count - 1 {
                self.checkFilteredList.append(self.filteredList[index].isTapped ?? false)
                //   self.checkList.append(self.paxesNameList[index].isTapped ?? false)
                let filter = self.tempFilteredList.filter{($0.tourName?.contains(self.filteredList[index].tourName ?? "") ?? false)}
                if filter.count > 0 {
                    if let insideIndex = self.filteredList.firstIndex(where: {$0.tourName == filter[0].tourName}){
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

extension ExcSelectCustomView : ExcursionListTableViewCellDelegate {
    func checkBoxTapped(checkCounter: Bool, tourid: Int, tourDate: String, tempPaxes: GetSearchTourResponseModel, priceTypeDesc : Int, pickUpTime: String) {
        
        self.tempFilteredList = []
        if isFiltered == true {
            if let index = self.filteredData.firstIndex(where: {$0.tourId == tourid && $0.tourDate == tourDate} ){
                self.filteredList[index].isTapped = checkCounter
                self.checkFilteredList[index] = checkCounter
                self.tempFilteredList = self.filteredList
                self.tempFilteredList[index].pickUpTime = pickUpTime
            }
        }else{
            if self.promotionButtonTapped == true {
                if Connectivity.isConnectedToInternet {
                    print("connect")
                    if let index = self.promotionList.firstIndex(where: {$0.tourId == tourid && $0.tourDate == tourDate}){
                        self.promotionList[index].isTapped = checkCounter
                        self.checkPromotionList[index] = checkCounter
                        self.promotionList[index].pickUpTime = pickUpTime
                    }
                } else {
                    return
                }
            }
            
            if let index = self.excursionList.firstIndex(where: {$0.tourId == tourid && $0.tourDate == tourDate}){
                self.excursionList[index].isTapped = checkCounter
                self.checkList[index] = checkCounter
                self.excursionList[index].pickUpTime = pickUpTime
            }
        }
        self.tableView.reloadData()
        
        if checkCounter == true {
            if pickUpTime == "" {
                if promotionButtonTapped == true {
                    if Connectivity.isConnectedToInternet {
                        print("connect")
                        for i in 0...self.promotionList.count - 1 {
                            self.promotionPickupTimeList.append(promotionList[i].pickUpTime ?? "")
                        }
                        let alert = UIAlertController(title: "Pick Up Time", message: "Please insert Pick Up Time", preferredStyle: .alert)
                        alert.addTextField {
                            $0.placeholder = "Pick Up Time"
                            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
                        }
                       // alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        let flatAmountAction = UIAlertAction(title: "Submit", style: .default) { [unowned self] _ in
                            guard let flatamount = alert.textFields?[0].text
                                    
                            else { return } // Should never happen
                            
                            self.savesTourList = self.savesTourList.filterDuplicate{($0.tourName,$0.tourDate)}
                            if flatamount == "" {
                                return
                            }
                            
                            let pickUpTimeInt = Int(flatamount) ?? 0
                            
                            
                            self.pickUpTime = "\(pickUpTimeInt)"
                            
                            if self.pickUpTime.count == 1 || self.pickUpTime == "0"{
                                self.pickUpTime = "0\(self.pickUpTime)"
                            }
                            
                            if self.pickUpTime.count == 2{
                                self.pickUpTime = "\(self.pickUpTime)00"
                            }
                            
                            self.pickUpTime.insert(":", at: self.pickUpTime.index(self.pickUpTime.startIndex, offsetBy: 2))
                            
                            if let index = self.promotionList.firstIndex(where: {$0 === tempPaxes}){
                                self.promotionPickupTimeList[index] = self.pickUpTime
                            }
                            if let indexSaveTourList = self.savesTourList.firstIndex(where: { $0 === tempPaxes}) {
                                self.savesTourList[indexSaveTourList].pickUpTime = self.pickUpTime
                            }
                       
                           // self.savesTourList.uniqued()
                            
                            userDefaultsData.saveTourList(tour: self.savesTourList)
                            self.tableView.reloadData()
                        }
                        
                        //  flatAmountAction.isEnabled = false
                        alert.addAction(flatAmountAction)
                        
                        if let topVC = UIApplication.getTopViewController() {
                            topVC.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        return
                    }
                }else {
                    
                    for i in 0...self.excursionList.count - 1 {
                        self.pickUpTimeList.append(excursionList[i].pickUpTime ?? "")
                    }
                    let alert = UIAlertController(title: "Pick Up Time", message: "Please insert Pick Up Time", preferredStyle: .alert)
                    alert.addTextField {
                        $0.placeholder = "Pick Up Time"
                        $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
                     
                    }
                   // alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                  
                    let flatAmountAction = UIAlertAction(title: "Submit", style: .default) { [unowned self] _ in
                        guard let flatamount = alert.textFields?[0].text
                                
                        else { return } // Should never happen
                        
                      /*  if flatamount == "" {
                            let alert = UIAlertController(title: "WARNING", message: "Please fiil Pick Up Time", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            if let topVC = UIApplication.getTopViewController() {
                                topVC.present(alert, animated: true, completion: nil)
                            }
                        }*/
                        
                        if flatamount == "" {
                            return
                        }
                        
                        let pickUpTimeInt = Int(flatamount) ?? 0
                        
                        
                        self.pickUpTime = "\(pickUpTimeInt)"
                        
                        if self.pickUpTime.count == 1 || self.pickUpTime == "0"{
                            self.pickUpTime = "0\(self.pickUpTime)"
                        }
                        
                        if self.pickUpTime.count == 2{
                            self.pickUpTime = "\(self.pickUpTime)00"
                        }
                        
                        self.pickUpTime.insert(":", at: self.pickUpTime.index(self.pickUpTime.startIndex, offsetBy: 2))
                        
                        if let index = self.excursionList.firstIndex(where: {$0 === tempPaxes}){
                            self.pickUpTimeList[index] = self.pickUpTime
                        }
                        
                        if let indexSaveTourList = self.savesTourList.firstIndex(where: { $0 === tempPaxes}) {
                            self.savesTourList[indexSaveTourList].pickUpTime = self.pickUpTime
                        }
                   
                       // self.savesTourList.uniqued()
                        
                        userDefaultsData.saveTourList(tour: self.savesTourList)
                        self.tableView.reloadData()
                    }
                    
                    flatAmountAction.isEnabled = false
                    alert.addAction(flatAmountAction)
                    
                    
                    if let topVC = UIApplication.getTopViewController() {
                        topVC.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let filterExcursionTourId = self.excursionList.filter{ $0.tourId == tourid}
            var filterExcursionTourDate = filterExcursionTourId.filter{ $0.tourDate == tourDate}
            let filterPromotionId = self.promotionList.filter{ $0.tourId == tourid}
            var filterPromotionDate = filterPromotionId.filter{ $0.tourDate == tourDate}
            // let filter = self.excursionList.filter{($0.tourId?.elementsEqual(tourid) ?? false)}
            // Özgeyle konuş burda offline salede tourid ye göre filtreleme yaptığında 24 tane aynı tur geliyor. oyüzden filter[0] yapıldı. düzeltilecek
          /* self.savesTourList.append(filterExcursionTourDate[0])
           self.savesTourList.append(filterPromotionDate[0]) */
            filterExcursionTourDate = filterExcursionTourDate.filterDuplicate{($0.tourName,$0.tourDate)}
            filterPromotionDate = filterPromotionDate.filterDuplicate{($0.tourName,$0.tourDate)}
            for index in filterExcursionTourDate {
                self.savesTourList.append(index)
            }
            
            for index in filterPromotionDate {
                self.savesTourList.append(index)
            }
            
        }else{
            if self.promotionButtonTapped == true {
                let filter = self.promotionList.filter{ $0.tourId == tourid}
                if let insideIndex = self.savesTourList.firstIndex(where: {$0.tourId == filter[0].tourId}){
                    self.savesTourList.remove(at: insideIndex)
                }
            }
            // let filter = self.excursionList.filter{($0.tourName?.elementsEqual(tourid) ?? false)}
            let filter = excursionList.filter{ $0.tourId == tourid}
            if let insideIndex = self.savesTourList.firstIndex(where: {$0.tourId == filter[0].tourId}){
                self.savesTourList.remove(at: insideIndex)
            }
        }
        self.savesTourList = self.savesTourList.filterDuplicate{($0.tourName,$0.tourDate)}
        userDefaultsData.saveTourList(tour: self.savesTourList)
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Array
{
   func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element]
   {
      var uniqueKeys = Set<String>()
      return filter{uniqueKeys.insert("\(keyValue($0))").inserted}
   }
}


