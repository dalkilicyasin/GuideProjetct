//
//  ExcProceedCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.12.2021.
//

import Foundation
import UIKit
import DropDown
import ObjectMapper

struct PaymentType {
    var paymentype : String?
    var paymentAmount : Double?
}

class ExcProceedCustomView: UIView{
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var viewTouristView: MainTextCustomView!
    @IBOutlet weak var viewCurrencyType: MainTextCustomView!
    @IBOutlet weak var viewType: MainTextCustomView!
    @IBOutlet weak var viewAmount: MainTextCustomView!
    @IBOutlet weak var viewDiscount: MainTextCustomView!
    @IBOutlet weak var viewNotes: MainTextCustomView!
    @IBOutlet weak var viewPaid: MainTextCustomView!
    @IBOutlet weak var viewBalanced: MainTextCustomView!
    @IBOutlet weak var viewDicountCalculate: MainTextCustomView!
    @IBOutlet weak var viewTotalAmount: MainTextCustomView!
    @IBOutlet weak var viewCurrencyConvert: MainTextCustomView!
    @IBOutlet weak var buttonApplyDiscount: UIButton!
    @IBOutlet weak var buttonAddPayment: UIButton!
    @IBOutlet weak var buttonConvert: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonSend: UIButton!
    var totalAmount = 0.00
    var balanceAmount = 0.00
    var savedTotalAmount = 0.00
    var discount = 0.00
    var selectedTouristName = ""
    var selectedCurrencyType = ""
    var selectedPaymentType = ""
    var data = ""
    var offlineDataList : [TourSalePost] = []
    // TourList
    var tourList : [GetSearchTourResponseModel] = []
    //currencyMenu
    var currencyList : [GetCurrencyResponeModel] = []
    var currencyMenu = DropDown()
    var tempCurrencyMenu  : [String] = []
    //TouristMenu
    var touristList : [GetInHoseListResponseModel] = []
    var touristMenu = DropDown()
    var tempTouristMenu  : [String] = []
    //TypeMenu
    var typeList = ["CASH","CARD"]
    var paymentTypeList : [PaymentType] = []
    var typeMenu = DropDown()
    //ExchangeMenu
    var exchangeList : [GetExhangeRatesResponseModel] = []
    var exchangeMenu = DropDown()
    var selectedExchange : [GetExhangeRatesResponseModel] = []
    var exchangeListStringType : [String] = []
    var valueforDivided = 0.00
    var convertedCurrency = 0.00
    var convertedCurrencyTitle = ""
    var payments : [Payment] = []
    var minPerson = 0
    var minPriceTotal = 0.0
    var currencyId = 0
    var hotelId = 0
    var marketId = 0
    let date = Date()
    var currentDate = ""
    var voucherNo : [String] = []
    var pickUpTimeProceedView = ""
    var internetConnection = true
    var promotionTourList : [Tours] = []
    var tourTotalAmount = 0.0
    var totalPricePerTour = 0.0
    var deletedAmount = 0.0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ExcProceedCustomView.self), owner: self, options: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProceedPaxTableViewCell.nib, forCellReuseIdentifier: ProceedPaxTableViewCell.identifier)
        self.tableView.backgroundColor = UIColor.tableViewColor
        
        self.touristList = userDefaultsData.getPaxesList() ?? self.touristList
        self.tourList = userDefaultsData.getTourList() ?? self.tourList
        
        /*   var adultCount = 0
         var childCount = 0
         var toodleCount = 0
         var infantCount = 0
         
         var tours : [TourRequestModel] = []
         
         if self.tourList.count > 0 {
         for i in 0...self.touristList.count - 1{
         if self.touristList[i].ageGroup == "ADL" {
         adultCount += 1
         }else if self.touristList[i].ageGroup == "CHD" {
         childCount += 1
         }else if self.touristList[i].ageGroup == "TDL" {
         toodleCount += 1
         }else if self.touristList[i].ageGroup == "INF" {
         infantCount += 1
         }
         }
         }
         
         for i in 0...self.tourList.count - 1 {
         tours.append(TourRequestModel(Adl: adultCount, AdultAmount: self.tourList[i].adultPrice ?? 0.00, Chd: childCount, ChildAmount: self.tourList[i].childPrice ?? 0.0, Inf: infantCount, InfantAmount: self.tourList[i].infantPrice ?? 0.0, PaxTotalAmount: self.totalAmount, PlanId: self.tourList[i].planId ?? 0, PriceType: self.tourList[i].priceType ?? 0, PromotionDiscount: 0.0, Tdl: toodleCount, ToodleAmount: self.tourList[i].toodlePrice ?? 0.0, TotalAmount: self.tourList[i].totalPrice ?? 0.0, TourAmount: self.totalAmount, TourDate: self.tourList[i].tourDate ?? "", TourId: self.tourList[i].tourId ?? 0))
         }
         
         let tourPromotionPostRequestModel = TourPromotionPost(PromotionDiscount: 0, PromotionId: 35, tours: tours)
         
         self.data = "\(tourPromotionPostRequestModel.toJSONString(prettyPrint: true) ?? "")"
         
         let promotionRequestModel = GetSaveMobileSaleRequestModel.init(data: self.data)
         NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetApplyPromotionMobile, requestModel: promotionRequestModel ) { (response: GetApplyPromotionMobileResponseModel) in
         if response.isSuccesful == true {
         print(response)
         let alert = UIAlertController(title: "SUCCSESS", message: response.message ?? "", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         if let topVC = UIApplication.getTopViewController() {
         topVC.present(alert, animated: true, completion: nil)
         }
         self.promotionTourList = response.record?.tours ?? self.promotionTourList
         for i in 0...self.promotionTourList.count - 1 {
         self.discount += self.promotionTourList[i].promotionDiscount ?? 0.0
         }
         }else {
         let alert = UIAlertController(title: "FAILED", message: response.message ?? "", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         if let topVC = UIApplication.getTopViewController() {
         topVC.present(alert, animated: true, completion: nil)
         }
         }
         }
         */
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        self.currentDate = dateFormatter.string(from: date)
        
        self.viewMainView.addCustomContainerView(self)
        self.viewMainView.backgroundColor = UIColor.grayColor
        self.viewTouristView.headerLAbel.text = "Tourist"
        self.viewCurrencyType.headerLAbel.text = "CurrencyType"
        self.viewType.headerLAbel.text = "Type"
        self.viewAmount.headerLAbel.text = "Amount"
        self.viewDiscount.headerLAbel.text = "Discount"
        self.viewNotes.headerLAbel.text = "Notes"
        self.viewPaid.headerLAbel.text = "Paid"
        self.viewBalanced.headerLAbel.text = "Balanced"
        self.viewDicountCalculate.headerLAbel.text = "Discount"
        self.viewTotalAmount.headerLAbel.text = "TotalAmount"
        self.viewCurrencyConvert.headerLAbel.text = "Currency"
        self.viewCurrencyType.mainLabel.text = "EUR"
        self.viewAmount.mainText.isHidden = false
        self.viewAmount.mainLabel.isHidden = true
        self.viewNotes.mainText.isHidden = false
        self.viewNotes.mainLabel.isHidden = true
        self.viewDiscount.mainText.isHidden = false
        self.viewDiscount.mainLabel.isHidden = true
        self.viewPaid.mainLabel.isHidden = true
        self.viewPaid.mainText.isHidden = false
        self.viewBalanced.mainLabel.isHidden = true
        self.viewBalanced.mainText.isHidden = false
        self.viewDicountCalculate.mainLabel.isHidden = true
        self.viewDicountCalculate.mainText.isHidden = false
        self.viewTotalAmount.mainLabel.isHidden = true
        self.viewTotalAmount.mainText.isHidden = false
        self.viewCurrencyConvert.mainLabel.isHidden = false
        self.viewCurrencyConvert.mainText.isHidden = true
        self.viewAmount.imageMainText.isHidden = true
        self.viewNotes.imageMainText.isHidden = true
        self.viewDiscount.imageMainText.isHidden = true
        self.viewPaid.imageMainText.isHidden = true
        self.viewDicountCalculate.imageMainText.isHidden = true
        self.viewTotalAmount.imageMainText.isHidden = true
        self.viewBalanced.imageMainText.isHidden = true
        self.viewCurrencyConvert.imageMainText.isHidden = true
        self.buttonApplyDiscount.layer.cornerRadius = 10
        self.buttonApplyDiscount.backgroundColor = UIColor.greenColor
        self.buttonConvert.layer.cornerRadius = 10
        self.buttonConvert.backgroundColor = UIColor.greenColor
        self.buttonAddPayment.layer.cornerRadius = 10
        self.buttonAddPayment.backgroundColor = UIColor.greenColor
        self.buttonSend.layer.cornerRadius = 10
        self.buttonSend.backgroundColor = UIColor.greenColor
        self.viewDicountCalculate.mainText.text = String(self.discount)
        self.viewTotalAmount.mainText.text = String(self.totalAmount - self.discount)
        self.viewBalanced.mainText.text = String(self.balanceAmount - self.discount)
        
        if Connectivity.isConnectedToInternet {
            print("connect")
            self.internetConnection = true
        } else {
            self.internetConnection = false
        }
        if self.internetConnection == true {
            // Exchange Menu
            let exchangeRequestModel = GetExhangeRatesRequestModel.init(date: userDefaultsData.getSaleDate() ?? "") // burda aynı günün değeri alınmalı fakat özgeyle konuş aynı gün değer dönmüyor
            NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint: .GetExhangeRates, method: .get, parameters: exchangeRequestModel.requestPathString()) { ( response : [GetExhangeRatesResponseModel]) in
                if response.count > 0 {
                    self.exchangeList = response
                    userDefaultsData.saveExchangeRates(tour: self.exchangeList)
                    for listofArray in self.exchangeList {
                        self.exchangeListStringType.append(listofArray.sHORTCODE ?? "")
                    }
                    self.exchangeMenu.dataSource = self.exchangeListStringType
                    self.exchangeMenu.dataSource.insert("", at: 0)
                    self.exchangeMenu.backgroundColor = UIColor.grayColor
                    self.exchangeMenu.separatorColor = UIColor.gray
                    self.exchangeMenu.textColor = .white
                    self.exchangeMenu.anchorView = self.viewCurrencyConvert
                    self.exchangeMenu.topOffset = CGPoint(x: 0, y:-(self.exchangeMenu.anchorView?.plainView.bounds.height)!)
                }
            }
        }else{
            self.exchangeList = userDefaultsData.getExchangeRates() ?? self.exchangeList
            for listofArray in self.exchangeList {
                self.exchangeListStringType.append(listofArray.sHORTCODE ?? "")
            }
            self.exchangeMenu.dataSource = self.exchangeListStringType
            self.exchangeMenu.dataSource.insert("", at: 0)
            self.exchangeMenu.backgroundColor = UIColor.grayColor
            self.exchangeMenu.separatorColor = UIColor.gray
            self.exchangeMenu.textColor = .white
            self.exchangeMenu.anchorView = self.viewCurrencyConvert
            self.exchangeMenu.topOffset = CGPoint(x: 0, y:-(self.exchangeMenu.anchorView?.plainView.bounds.height)!)
        }
        
        let gestureTourist = UITapGestureRecognizer(target: self, action: #selector(didTappedExchangeMenu))
        gestureTourist.numberOfTouchesRequired = 1
        self.viewCurrencyConvert.addGestureRecognizer(gestureTourist)
        
        self.exchangeMenu.selectionAction = { index, title in
            self.viewCurrencyConvert.mainLabel.text = title
            self.convertedCurrencyTitle = title
            
            let filtered = self.exchangeList.filter{($0.sHORTCODE?.contains(title) ?? false)}
            self.selectedExchange = filtered
            for listofArray in self.selectedExchange {
                self.valueforDivided = listofArray.eUROCROSS ?? 0.00
            }
        }
        
        // TouristMenu
        for listofArray in self.touristList {
            self.tempTouristMenu.append(listofArray.name ?? "")
        }
        self.touristMenu.dataSource = self.tempTouristMenu
        self.touristMenu.dataSource.insert("", at: 0)
        self.touristMenu.backgroundColor = UIColor.grayColor
        self.touristMenu.separatorColor = UIColor.gray
        self.touristMenu.textColor = .white
        self.touristMenu.anchorView = self.viewTouristView
        self.touristMenu.topOffset = CGPoint(x: 0, y:-(self.touristMenu.anchorView?.plainView.bounds.height)!)
        
        let gestureExchange = UITapGestureRecognizer(target: self, action: #selector(didTappedToristListMenu))
        gestureExchange.numberOfTouchesRequired = 1
        self.viewTouristView.addGestureRecognizer(gestureExchange)
        
        self.touristMenu.selectionAction = { index, title in
            self.viewTouristView.mainLabel.text = title
            self.selectedTouristName = title
            
            /*  let filtered = self.hotelList.filter{($0.text?.contains(title) ?? false)}
             self.filteredHotelList = filtered
             for listofArray in self.filteredHotelList {
             userDefaultsData.saveHotelId(hotelId: listofArray.value ?? 0)
             userDefaultsData.saveHotelArea(hotelAreaId: listofArray.area ?? 0)
             }*/
        }
        
        //CurrencyTypeMenu
        self.typeMenu.dataSource = self.typeList
        self.typeMenu.dataSource.insert("", at: 0)
        self.typeMenu.backgroundColor = UIColor.grayColor
        self.typeMenu.separatorColor = UIColor.gray
        self.typeMenu.textColor = .white
        self.typeMenu.anchorView = self.viewType
        self.typeMenu.topOffset = CGPoint(x: 0, y:-(self.typeMenu.anchorView?.plainView.bounds.height)!)
        
        let gestureType = UITapGestureRecognizer(target: self, action: #selector(didTappedTypeListMenu))
        gestureType.numberOfTouchesRequired = 1
        self.viewType.addGestureRecognizer(gestureType)
        
        self.typeMenu.selectionAction = { index, title in
            self.viewType.mainLabel.text = title
            self.selectedPaymentType = title
            /*  let filtered = self.hotelList.filter{($0.text?.contains(title) ?? false)}
             self.filteredHotelList = filtered
             for listofArray in self.filteredHotelList {
             userDefaultsData.saveHotelId(hotelId: listofArray.value ?? 0)
             userDefaultsData.saveHotelArea(hotelAreaId: listofArray.area ?? 0)
             }*/
        }
        
        if self.internetConnection == true {
            NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetCurrencySelectList, method: .get, parameters: "") { (response : [GetCurrencyResponeModel] ) in
                if response.count > 0 {
                    self.currencyList = response
                    userDefaultsData.saveCurrencyList(tour: self.currencyList)
                    
                    for listofArray in self.currencyList {
                        self.tempCurrencyMenu.append(listofArray.text ?? "")
                    }
                    self.currencyMenu.dataSource = self.tempCurrencyMenu
                    self.currencyMenu.dataSource.insert("", at: 0)
                    self.currencyMenu.backgroundColor = UIColor.grayColor
                    self.currencyMenu.separatorColor = UIColor.gray
                    self.currencyMenu.textColor = .white
                    self.currencyMenu.anchorView = self.viewCurrencyType
                    self.currencyMenu.topOffset = CGPoint(x: 0, y:-(self.currencyMenu.anchorView?.plainView.bounds.height)!)
                }else{
                    print("data has not recived")
                }
            }
        }else {
            self.currencyList = userDefaultsData.getCurrencyList() ?? self.currencyList
            
            for listofArray in self.currencyList {
                self.tempCurrencyMenu.append(listofArray.text ?? "")
            }
            self.currencyMenu.dataSource = self.tempCurrencyMenu
            self.currencyMenu.dataSource.insert("", at: 0)
            self.currencyMenu.backgroundColor = UIColor.grayColor
            self.currencyMenu.separatorColor = UIColor.gray
            self.currencyMenu.textColor = .white
            self.currencyMenu.anchorView = self.viewCurrencyType
            self.currencyMenu.topOffset = CGPoint(x: 0, y:-(self.currencyMenu.anchorView?.plainView.bounds.height)!)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedItem))
        gesture.numberOfTouchesRequired = 1
        self.viewCurrencyType.addGestureRecognizer(gesture)
        
        self.currencyMenu.selectionAction = { index, title in
            self.viewCurrencyType.mainLabel.text = title
            self.selectedCurrencyType = title
            if let index = self.currencyList.firstIndex(where: {$0.text == self.selectedCurrencyType} ){
                self.currencyId = self.currencyList[index].value ?? 0
            }
            /*  let filtered = self.hotelList.filter{($0.text?.contains(title) ?? false)}
             self.filteredHotelList = filtered
             for listofArray in self.filteredHotelList {
             userDefaultsData.saveHotelId(hotelId: listofArray.value ?? 0)
             userDefaultsData.saveHotelArea(hotelAreaId: listofArray.area ?? 0)
             }*/
        }
    }
    @objc func didTappedExchangeMenu() {
        self.exchangeMenu.show()
    }
    
    @objc func didTappedItem() {
        self.currencyMenu.show()
    }
    
    @objc func didTappedToristListMenu() {
        self.touristMenu.show()
    }
    
    @objc func didTappedTypeListMenu() {
        self.typeMenu.show()
    }
    
    @IBAction func applyDiscountButtonTapped(_ sender: Any) {
        if let discount = Double(self.viewDiscount.mainText.text ?? ""){
            self.discount += discount
        }
        self.viewDicountCalculate.mainText.text = String(self.discount)
        self.balanceAmount = self.balanceAmount - self.discount
        self.viewBalanced.mainText.text = String(self.balanceAmount)
        self.totalAmount = self.totalAmount - self.discount
        self.viewTotalAmount.mainText.text = String(self.totalAmount)
    }
    
    @IBAction func addPaymentButtonTapped(_ sender: Any) {
        
        if self.selectedTouristName != "" && self.selectedPaymentType != "" && self.selectedCurrencyType != "" {
            self.paymentTypeList.append(PaymentType(paymentype: self.selectedPaymentType, paymentAmount: Double(self.viewAmount.mainText.text ?? "") ?? 0.00))
            
            self.tableView.reloadData()
            
            if let total = Double(self.viewAmount.mainText.text ?? ""){
                self.savedTotalAmount += total
            }
            self.viewPaid.mainText.text = String(self.savedTotalAmount)
            
            if self.savedTotalAmount < 0 {
                self.savedTotalAmount = -self.savedTotalAmount
            }
            self.balanceAmount = self.totalAmount - self.savedTotalAmount
            //self.totalAmount = self.balanceAmount
          
            self.viewBalanced.mainText.text = String(self.balanceAmount)
        }else {
            let alert = UIAlertController.init(title: "Error", message: "Please Insert CurrencyType, Pax and PaymentType", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let topVC = UIApplication.getTopViewController() {
                topVC.present(alert, animated: true, completion: nil)
            }
        }
        
        self.payments.append(Payment(ByDesc: self.selectedTouristName , ById:"0", ConvertedCurrency: self.convertedCurrencyTitle, ConvertedPaymentAmount:  Int(self.totalAmount), Currency: self.selectedCurrencyType, CurrencyId: String(self.currencyId), PaymentAmount: Double(self.viewAmount.mainText.text ?? "") ?? 0.00, PaymentType: self.selectedPaymentType, TargetAmount:0, TypeId: self.selectedPaymentType))
    }
    
    @IBAction func convertButtonTapped(_ sender: Any) {
        self.convertedCurrency = self.totalAmount / self.valueforDivided
        
        let alert = UIAlertController.init(title: "Message", message: "Converted balance  for \(self.totalAmount) EUR is \(self.convertedCurrency)\(self.convertedCurrencyTitle)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let topVC = UIApplication.getTopViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
        self.balanceAmount = self.convertedCurrency
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if self.balanceAmount == 0.0 {
            if Connectivity.isConnectedToInternet == true {
                self.hotelId = userDefaultsData.getHotelId()
                self.marketId = userDefaultsData.getMarketId()
            }else{
                self.hotelId = userDefaultsData.getOfflineHotelId()
                self.marketId = userDefaultsData.getOfflineMarketId()
                if self.tourList.count > 0 {
                    for _ in 0...self.tourList.count - 1 {
                        self.voucherNo.append("")
                    }
                }
            }
            let multisale = Multisale.init(CouponAmount:0, CouponId:0, CurrencyId: self.currencyId, GuideId: userDefaultsData.getGuideId(), HotelId: self.hotelId, ID:0, IsMobile:1, IsOfficeSale: false, ManualDiscount:0, MarketId: self.marketId, Note: "", PaidAmount: Int(self.savedTotalAmount), PromotionId: 0, SaleDate: self.currentDate , TotalAmount: Int(self.totalAmount))
            var paxTourList : [PaxTourList] = []
            var paxes : [Paxes] = []
            var tourListIndata : [TourList] = []
            let extras : [Extras] = []
            let transfers : [Transfers] = []
            var adultCount = 0
            var childCount = 0
            var toodleCount = 0
            var infantCount = 0
            self.tourTotalAmount = 0.0
            if self.tourList.count > 0 && self.touristList.count > 0{
                for i in 0...self.tourList.count - 1{
                    for index in 0...self.touristList.count - 1 {
                        let paxesTour = PaxTourList(AgeGroup:self.touristList[index].ageGroup ?? "", Gender:self.touristList[index].gender ?? "",ID:String(self.touristList[index].ID ?? 0), PlanId:self.tourList[i].planId ?? 0)
                        paxTourList.append(paxesTour)
                    }
                }
                for i in 0...self.touristList.count - 1{
                    if self.touristList[i].ageGroup == "ADL" {
                        adultCount += 1
                    }else if self.touristList[i].ageGroup == "CHD" {
                        childCount += 1
                    }else if self.touristList[i].ageGroup == "TDL" {
                        toodleCount += 1
                    }else if self.touristList[i].ageGroup == "INF" {
                        infantCount += 1
                    }
                }
            }
            
            for i in 0...self.tourList.count - 1 {
                self.totalPricePerTour = 0.0
                if self.tourList[i].priceType == 35 {
                    
                    for index in 0...self.touristList.count - 1 {
                        switch self.touristList[index].ageGroup {
                        case "INF":
                            self.totalPricePerTour += self.tourList[i].infantPrice ?? 0.00
                        case "TDL":
                            self.totalPricePerTour += self.tourList[i].toodlePrice ?? 0.00
                        case "CHD":
                            self.totalPricePerTour += self.tourList[i].childPrice ?? 0.00
                        default:
                            self.totalPricePerTour += self.tourList[i].adultPrice ?? 0.00
                        }
                    }
                }
                
                //Flat Price calculation
                else if self.tourList[i].priceType == 36{
                    self.totalPricePerTour += self.tourList[i].flatPrice ?? 0.00
                }
                
                //Min Price
                else if self.tourList[i].priceType == 37{
                    self.minPerson = Int(self.tourList[i].minPax ?? 0.00)
                    if self.minPerson > 0 {
                        for index in 0...self.touristList.count - 1{
                            if  self.touristList[index].ageGroup == "ADL" {
                                self.minPriceTotal = self.tourList[i].minPrice ?? 0.00
                                self.minPerson -= 1
                            }else if self.minPerson > 0 && self.touristList[index].ageGroup == "CHD" {
                                self.minPriceTotal = self.tourList[i].minPrice ?? 0.00
                                self.minPerson -= 1
                            }else if self.minPerson > 0 && self.touristList[index].ageGroup == "TDL" {
                                self.minPriceTotal = self.tourList[i].minPrice ?? 0.00
                                self.minPerson -= 1
                            }else if self.minPerson > 0 && self.touristList[index].ageGroup == "INF" {
                                self.minPriceTotal = self.tourList[i].minPrice ?? 0.00
                                self.minPerson -= 1
                            }
                        }
                    }else {
                        for index in 0...self.touristList.count - 1{
                            if  self.touristList[index].ageGroup == "ADL" {
                                self.totalPricePerTour += self.tourList[i].adultPrice  ?? 0.00
                            }else if self.minPerson > 0 && self.touristList[index].ageGroup == "CHD" {
                                self.totalPricePerTour += tourList[i].childPrice ?? 0.00
                            }else if self.minPerson > 0 && self.touristList[index].ageGroup == "TDL" {
                                self.totalPricePerTour += tourList[i].toodlePrice ?? 0.00
                            }else if self.minPerson > 0 && self.touristList[index].ageGroup == "INF" {
                                self.totalPricePerTour += tourList[i].infantPrice ?? 0.00
                            }
                        }
                    }
                    self.totalPricePerTour += self.minPriceTotal
                }
                // Önemli, özgeye sor tour date offline tourdan geldiği için tarih geride kalıyor ve offline satışta sale date tourdate ten ileri olamaz hatası veriyor nasıl çözeceğiz
                self.tourTotalAmount += self.totalPricePerTour
                
               
                    tourListIndata.append(TourList(id: Int(self.tourList[i].id ?? "") ?? 0, AdultAmount:(self.tourList[i].adultPrice ?? 0.0)*Double(adultCount), AdultCount:adultCount, AdultPrice:self.tourList[i].adultPrice ?? 0.00,ChildAmount:(self.tourList[i].childPrice ?? 0.0)*Double(childCount), ChildCount:childCount, ChildPrice:self.tourList[i].childPrice ?? 0.00, InfantAmount: (self.tourList[i].infantPrice ?? 0.0)*Double(infantCount), InfantCount:infantCount, InfantPrice: self.tourList[i].infantPrice ?? 0.00, ToodleAmount:  (self.tourList[i].toodlePrice ?? 0.0)*Double(toodleCount), ToodleCount:toodleCount, ToodlePrice: self.tourList[i].toodlePrice ?? 0.00, MatchId: self.tourList[i].matchId ?? 0, MarketId: self.tourList[i].marketId ?? 0, PromotionId: self.tourList[i].promotionId ?? 0, PoolType: self.tourList[i].poolType ?? 0, PriceId: self.tourList[i].priceId ?? 0, PlanId: self.tourList[i].planId ?? 0, TourType: self.tourList[i].tourType ?? 0, TourName: self.tourList[i].tourName ?? "", TourId:  self.tourList[i].tourId ?? 0, Currency: self.tourList[i].currency ?? 0 , CurrencyDesc: self.tourList[i].currencyDesc ?? "", TourDateStr:self.tourList[i].tourDateStr ?? "", TourDate: self.tourList[i].tourDate ?? "", AllotmenStatus: self.tourList[i].allotmenStatus ?? 0, RemainingAllotment: self.tourList[i].remainingAllotment ?? 0, PriceType: self.tourList[i].priceType ?? 0, MinPax:self.tourList[i].minPax ?? 0.0, TotalPrice: self.totalPricePerTour, FlatPrice: self.tourList[i].flatPrice ?? 0.0, MinPrice: self.tourList[i].minPrice ?? 0.0, InfantAge1: self.tourList[i].infantAge1 ?? 0.0, InfantAge2: self.tourList[i].infantAge2 ?? 0.0, ToodleAge1: self.tourList[i].toodleAge1 ?? 0.0, ToodleAge2: self.tourList[i].toodleAge2 ?? 0.0, ChildAge1: self.tourList[i].childAge1 ?? 0.0, ChildAge2: self.tourList[i].childAge2 ?? 0.0, PickUpTime:"02:00:00", DetractAdult: self.tourList[i].detractAdult ?? false, DetractChild: self.tourList[i].detractChild ?? false, DetractKid: self.tourList[i].detractKid ?? false, DetractInfant: self.tourList[i].detractInfant ?? false, AskSell: self.tourList[i].askSell ?? false, MeetingPointId: self.tourList[i].meetingPointId ?? 0, Paref: String(self.tourList[i].paref ?? 0) ,TourCode: self.tourList[i].tourCode ?? "", ID: self.tourList[i].ID ?? 0, CREATEDDATE: self.tourList[i].cREATEDDATE ?? "", RefundCondition:"", TicketCount: 0, TourAmount: self.totalPricePerTour, VoucherNo: self.voucherNo[i], ExtraTourist: extras, TransferTourist:transfers))
              
            }
            
            paxes = userDefaultsData.getTouristDetailInfoList() ?? paxes
            
            print(self.data)
            
            if Connectivity.isConnectedToInternet {
                print("connect")
                
                let tourSalePost = TourSalePost(Multisale:multisale, PaxTourLists:paxTourList, Payments: self.payments, Paxes:paxes, IsOffline:"0", AllowDublicatePax:"0",TourList:tourListIndata )
                
                self.data = "\(tourSalePost.toJSONString(prettyPrint: true) ?? "")"
                
                let toursaleRequestModel = GetSaveMobileSaleRequestModel.init(data: self.data)
                NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetSaveMobileSale, requestModel: toursaleRequestModel ) { (response: GetSaveMobileSaleResponseModel) in
                    if response.IsSuccesful == true {
                        print(response)
                        let alert = UIAlertController(title: "SUCCSESS", message: response.Message ?? "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let topVC = UIApplication.getTopViewController() {
                            topVC.present(alert, animated: true, completion: nil)
                        }
                        
                    }else {
                        let alert = UIAlertController(title: "FAILED", message: response.Message ?? "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let topVC = UIApplication.getTopViewController() {
                            topVC.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                
            } else {
                let tourSalePost = TourSalePost(Multisale:multisale, PaxTourLists:paxTourList, Payments: self.payments, Paxes:paxes, IsOffline:"1", AllowDublicatePax:"0",TourList:tourListIndata )
                self.offlineDataList.append(tourSalePost)
                userDefaultsData.saveTourSalePost(tour: self.offlineDataList)
                let alert = UIAlertController.init(title: "Message", message: "Data has been saved", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                if let topVC = UIApplication.getTopViewController() {
                    topVC.present(alert, animated: true, completion: nil)
                }
            }
        }else {
            let alert = UIAlertController.init(title: "WARNING", message: "Balance amount is not 0.0. Please be sure balance amount is 0.0", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let topVC = UIApplication.getTopViewController() {
                topVC.present(alert, animated: true, completion: nil)
            }
            return
        }
    }
}

extension ExcProceedCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProceedPaxTableViewCell.identifier) as! ProceedPaxTableViewCell
        cell.labelPaymentType.text = paymentTypeList[indexPath.row].paymentype
        cell.labelPaymentPrice.text = "\(Double(paymentTypeList[indexPath.row].paymentAmount ?? 0.00 ))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.deletedAmount = 0.0
            self.deletedAmount = self.paymentTypeList[indexPath.row].paymentAmount ?? 0.00
            self.savedTotalAmount -= self.deletedAmount
            self.viewPaid.mainText.text = String(self.savedTotalAmount)
            self.balanceAmount = self.totalAmount - self.savedTotalAmount
            self.paymentTypeList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            print(self.paymentTypeList)
        }
    }
}

