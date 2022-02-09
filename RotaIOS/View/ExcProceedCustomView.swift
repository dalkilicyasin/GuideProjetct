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

struct SendDataPrint {
    var tourName : String?
    var paxInfo : String?
    var voucher : String?
    var tourDate : String?
    var transTourist : String?
    var hotelName : String?
    var date : String?
    var room : String?
    var paxName : String?
    var operatorName : String?
    var resNo : String?
    var total : String?
    var discount : String?
    var netTotal : String?
    var cash : String?
    var card : String?
    var guideInfoNumber : String?
}

struct PaymentType {
    var paymentype : String?
    var paymentAmount : Double?
    var currencyTpye : String?
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
    @IBOutlet weak var buttonPrintVoucher: UIButton!
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
    var valueforDivided = 1.0
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
    var sendedTotalAmount = 0.0
    var extras : [Extras] = []
    var transfers : [Transfers] = []
    var multisaleCurrencyId = 0
    var extrasTotalPrice = 0.0
    var transfersTotalPrice = 0.0
    var tourExtras : [Extras] = []
    var tourTransfers : [Transfers] = []
    var printManager = PrintManager.sharedInstance
    var promotionDiscount = 0.0
    var promotionId = 0
    var printString = ""
    var tourNameList : [String] = []
    var paxList : [String] = []
    var totalDiscount = 0.0
    var printList : [SendDataPrint] = []
    var printListStringType : [String] = []
    var connectedAccessories : [EAAccessory] = []
    
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
        printManager.connectionDelegate = self
        self.updateConnectedAccessories()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProceedPaxTableViewCell.nib, forCellReuseIdentifier: ProceedPaxTableViewCell.identifier)
        self.tableView.backgroundColor = UIColor.tableViewColor
        
        self.touristList = userDefaultsData.getPaxesList() ?? self.touristList
        self.tourList = userDefaultsData.getTourList() ?? self.tourList
        
        self.extras = userDefaultsData.getExtrasList() ?? self.extras
        self.transfers = userDefaultsData.getTransfersList() ?? self.transfers
        
       
        self.voucherNo = userDefaultsData.getMaxVoucher() ?? self.voucherNo
        self.buttonSend.isEnabled = true
        
        self.buttonPrintVoucher.backgroundColor = UIColor.clear
        self.buttonPrintVoucher.layer.borderWidth = 1
        self.buttonPrintVoucher.layer.cornerRadius = 10
        self.buttonPrintVoucher.layer.borderColor = UIColor.green.cgColor
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
       
        // self.sendedTotalAmount = self.totalAmount
        
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
        }
    }
    
    func updateConnectedAccessories(){
        self.connectedAccessories = EAAccessoryManager.shared().connectedAccessories
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
        self.discount = 0.0
        if let discount = Double(self.viewDiscount.mainText.text ?? ""){
            self.discount += discount
            self.totalDiscount += discount
        }
        self.viewDiscount.mainText.text = self.viewDiscount.mainText.text?.replacingOccurrences(of: ",", with: ".")
        self.viewDicountCalculate.mainText.text = String(self.totalDiscount + self.promotionDiscount)
        self.balanceAmount = self.balanceAmount - self.discount
        self.viewBalanced.mainText.text = String(self.balanceAmount)
        self.totalAmount = self.totalAmount - self.discount
        self.viewTotalAmount.mainText.text = String(self.totalAmount)
        self.viewDiscount.mainText.text = "\(0.0)"
    }
    
    @IBAction func addPaymentButtonTapped(_ sender: Any) {
        
        if self.selectedCurrencyType == "" {
            self.selectedCurrencyType = self.viewCurrencyType.mainLabel.text ?? "EUR"
        }
        var roundedPaymentAmount = 0.0
        var roundedPaymentAmountChosenCurrency = 0.0
        self.viewAmount.mainText.text = self.viewAmount.mainText.text?.replacingOccurrences(of: ",", with: ".")
        let filter = self.exchangeList.filter{ $0.sHORTCODE == self.selectedCurrencyType}
        var paymentAmount = Double(self.viewAmount.mainText.text ?? "")
        roundedPaymentAmountChosenCurrency = paymentAmount ?? 0.0
        roundedPaymentAmountChosenCurrency = Double(round(100 * roundedPaymentAmountChosenCurrency) / 100 )
        if filter.count > 0 {
            paymentAmount = (paymentAmount ?? 0.0) * (filter[0].eUROCROSS ?? 0.0)
        }
        roundedPaymentAmount = paymentAmount ?? 0.00
        roundedPaymentAmount = Double(round(100 * roundedPaymentAmount) / 100 )
        
        if self.selectedTouristName != "" && self.selectedPaymentType != "" && self.viewCurrencyType.mainLabel.text != "" {
            
            /* self.paymentTypeList.append(PaymentType(paymentype: self.selectedPaymentType, paymentAmount: Double(self.viewAmount.mainText.text ?? "") ?? 0.00), currencyTpye : self.selectedCurrencyType)*/
            self.paymentTypeList.append(PaymentType.init(paymentype:self.selectedPaymentType, paymentAmount: roundedPaymentAmountChosenCurrency, currencyTpye:  self.selectedCurrencyType))
            
            self.tableView.reloadData()
            
            
            self.savedTotalAmount += paymentAmount ?? 0.0
            
            var roundedSavedTotalAmountValue = Double(round(100 * self.savedTotalAmount) / 100 )
            
            self.viewPaid.mainText.text = String(roundedSavedTotalAmountValue)
            self.viewPaid.mainText.text = self.viewPaid.mainText.text?.replacingOccurrences(of: ",", with: ".")
            
            if roundedSavedTotalAmountValue < 0 {
                roundedSavedTotalAmountValue = -roundedSavedTotalAmountValue
            }
            self.balanceAmount = self.totalAmount - roundedSavedTotalAmountValue
            //self.totalAmount = self.balanceAmount
            let roundedBalanceValue = Double(round(100 * self.balanceAmount) / 100 )
            if roundedBalanceValue <= 0.5 && roundedBalanceValue >= -0.5 {
                self.balanceAmount = 0.0
                
            }
            self.viewBalanced.mainText.text = String(roundedBalanceValue)
            
            if self.currencyId == 0 {
                if let index = self.currencyList.firstIndex(where: {$0.text == self.viewCurrencyType.mainLabel.text} ){
                        self.currencyId = self.currencyList[index].value ?? 0
                    }
            }
            self.viewTotalAmount.mainText.text = self.viewTotalAmount.mainText.text?.replacingOccurrences(of: ",", with: ".")
            
            self.payments.append(Payment(ByDesc: self.selectedTouristName , ById:"0", ConvertedCurrency: self.convertedCurrencyTitle, ConvertedPaymentAmount:  Int(self.totalAmount), Currency: self.selectedCurrencyType, CurrencyId: String(self.currencyId), PaymentAmount: Double(self.viewAmount.mainText.text ?? "") ?? 0.00, PaymentType: self.selectedPaymentType, TargetAmount:0, TypeId: self.selectedPaymentType))
            
        }else {
            let alert = UIAlertController.init(title: "Error", message: "Please Insert CurrencyType, Pax and PaymentType", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let topVC = UIApplication.getTopViewController() {
                topVC.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func printButtonTapped(_ sender: Any) {
       
        if self.printList.count > 0 {
            self.connectEaAccessory(eaAccessory: self.connectedAccessories[0])
        }else{
            let alert = UIAlertController.init(title: "Warning", message: "Please send data", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let topVC = UIApplication.getTopViewController() {
                topVC.present(alert, animated: true, completion: nil)
            }
        }
     if let topVC = UIApplication.getTopViewController() {
            topVC.otiPushViewController(viewController: MainPAgeViewController())
        }
    }
    
    @IBAction func convertButtonTapped(_ sender: Any) {
        self.convertedCurrency = self.balanceAmount / self.valueforDivided
        let roundedValue = Double(round(100 * self.convertedCurrency) / 100 )
        let alert = UIAlertController.init(title: "Message", message: "Converted balance  for \(self.balanceAmount) EUR is \(roundedValue)\(self.convertedCurrencyTitle)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let topVC = UIApplication.getTopViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
        //  self.balanceAmount = self.convertedCurrency
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        if self.balanceAmount == 0.0{
            if Connectivity.isConnectedToInternet == true {
                self.hotelId = userDefaultsData.getHotelId()
                self.marketId = userDefaultsData.getMarketId()
            }else{
                self.hotelId = userDefaultsData.getOfflineHotelId()
                self.marketId = userDefaultsData.getOfflineMarketId()
                if self.tourList.count > 0 {
                    for _ in 0...self.tourList.count - 1 {
                        self.voucherNo.append("123")
                    }
                }
            }
            
            if let index = self.currencyList.firstIndex(where: {$0.text == "EUR"} ){
                    self.currencyId = self.currencyList[index].value ?? 0
                }
            
            let multisale = Multisale.init(CouponAmount:0, CouponId:0, CurrencyId: self.currencyId, GuideId: userDefaultsData.getGuideId(), HotelId: self.hotelId, ID:0, IsMobile:1, IsOfficeSale: false, ManualDiscount: self.totalDiscount, MarketId: self.marketId, Note: "", PaidAmount: self.savedTotalAmount, PromotionId: self.promotionId, SaleDate: self.currentDate , TotalAmount: self.sendedTotalAmount)
            var paxTourList : [PaxTourList] = []
            var paxes : [Paxes] = []
            var tourListIndata : [TourList] = []
            var adultCount = 0
            var childCount = 0
            var toodleCount = 0
            var infantCount = 0
            self.tourTotalAmount = 0.0
         
            var hotelName = ""
            var room = ""
            var paxName = ""
            var resNo = ""
            var operatorName = ""
            var netTotal = 0.0
            var discount = 0.0
            var total = 0.0

            paxes = userDefaultsData.getTouristDetailInfoList() ?? paxes
            if paxes.count > 0 {
                for i in 0...paxes.count - 1 {
                    self.paxList.append(paxes[i].pAX_AGEGROUP ?? "")
                    
                    if self.selectedTouristName.haveSameCharecterSet(paxes[i].pAX_NAME) == true {
                        hotelName = paxes[i].hotelname ?? ""
                        room = paxes[i].pAX_ROOM ?? ""
                        paxName = paxes[i].pAX_NAME ?? ""
                        resNo = paxes[i].pAX_RESNO ?? ""
                        operatorName = paxes[i].pAX_OPRNAME ?? ""
                    }
                }
            }
    
            if self.extras.count > 0 {
                for i in 0...self.extras.count - 1 {
                    self.extras[i].TotalPrice = self.extrasTotalPrice
                    self.extras[i].totalAmount = self.extrasTotalPrice
                }
            }
            
            if self.transfers.count > 0 {
                for i in 0...self.transfers.count - 1 {
                    self.transfers[i].TotalPrice = self.transfersTotalPrice
                    self.transfers[i].totalAmount = self.transfersTotalPrice
                }
            }
            
            if self.tourList.count > 0 && self.touristList.count > 0 && self.voucherNo.count > 0{
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
                
                
                for i in 0...self.tourList.count - 1 {
                    self.tourExtras = []
                    self.tourTransfers = []
                    self.totalPricePerTour = 0.0
                    
                    if self.extras.count > 0 {
                        for index in 0...self.extras.count - 1 {
                            if self.extras[index].tourId == self.tourList[i].tourId && self.extras[index].tourDate == self.tourList[i].tourDate && self.extras[index].tourName == self.tourList[i].tourName {
                                self.tourExtras.append(extras[index])
                            }
                        }
                    }
                    
                    if self.transfers.count > 0 {
                        for index in 0...self.transfers.count - 1 {
                            if self.transfers[index].tourId == self.tourList[i].tourId && self.transfers[index].tourDate == self.tourList[i].tourDate && self.transfers[index].tourName == self.tourList[i].tourName {
                                self.tourTransfers.append(transfers[index])
                            }
                        }
                    }
                    
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
                   // self.totalPricePerTour += userDefaultsData.getExtrasandTransfersTotalPrice()
                    self.tourTotalAmount = self.totalPricePerTour + userDefaultsData.getExtrasandTransfersTotalPrice()
                    netTotal += self.tourTotalAmount
                    discount = self.discount
                    total = netTotal - discount
                    self.pickUpTimeProceedView = tourList[i].pickUpTime ?? ""
                 
                    tourListIndata.append(TourList(id: Int(self.tourList[i].id ?? "") ?? 0, AdultAmount:(self.tourList[i].adultPrice ?? 0.0)*Double(adultCount), AdultCount:adultCount, AdultPrice:self.tourList[i].adultPrice ?? 0.00,ChildAmount:(self.tourList[i].childPrice ?? 0.0)*Double(childCount), ChildCount:childCount, ChildPrice:self.tourList[i].childPrice ?? 0.00, InfantAmount: (self.tourList[i].infantPrice ?? 0.0)*Double(infantCount), InfantCount:infantCount, InfantPrice: self.tourList[i].infantPrice ?? 0.00, ToodleAmount:  (self.tourList[i].toodlePrice ?? 0.0)*Double(toodleCount), ToodleCount:toodleCount, ToodlePrice: self.tourList[i].toodlePrice ?? 0.00, MatchId: self.tourList[i].matchId ?? 0, MarketId: self.tourList[i].marketId ?? 0, PromotionId: self.tourList[i].promotionId ?? 0, PoolType: self.tourList[i].poolType ?? 0, PriceId: self.tourList[i].priceId ?? 0, PlanId: self.tourList[i].planId ?? 0, TourType: self.tourList[i].tourType ?? 0, TourName: self.tourList[i].tourName ?? "", TourId:  self.tourList[i].tourId ?? 0, Currency: self.tourList[i].currency ?? 0 , CurrencyDesc: self.tourList[i].currencyDesc ?? "", TourDateStr:self.tourList[i].tourDateStr ?? "", TourDate: self.tourList[i].tourDate ?? "", AllotmenStatus: self.tourList[i].allotmenStatus ?? 0, RemainingAllotment: self.tourList[i].remainingAllotment ?? 0, PriceType: self.tourList[i].priceType ?? 0, MinPax:self.tourList[i].minPax ?? 0.0, TotalPrice: self.tourTotalAmount, FlatPrice: self.tourList[i].flatPrice ?? 0.0, MinPrice: self.tourList[i].minPrice ?? 0.0, InfantAge1: self.tourList[i].infantAge1 ?? 0.0, InfantAge2: self.tourList[i].infantAge2 ?? 0.0, ToodleAge1: self.tourList[i].toodleAge1 ?? 0.0, ToodleAge2: self.tourList[i].toodleAge2 ?? 0.0, ChildAge1: self.tourList[i].childAge1 ?? 0.0, ChildAge2: self.tourList[i].childAge2 ?? 0.0, PickUpTime:  self.pickUpTimeProceedView, DetractAdult: self.tourList[i].detractAdult ?? false, DetractChild: self.tourList[i].detractChild ?? false, DetractKid: self.tourList[i].detractKid ?? false, DetractInfant: self.tourList[i].detractInfant ?? false, AskSell: self.tourList[i].askSell ?? false, MeetingPointId: self.tourList[i].meetingPointId ?? 0, Paref: String(self.tourList[i].paref ?? 0) ,TourCode: self.tourList[i].tourCode ?? "", ID: self.tourList[i].ID ?? 0, CREATEDDATE: self.tourList[i].cREATEDDATE ?? "", RefundCondition:"", TicketCount: 0, TourAmount: self.totalPricePerTour, VoucherNo: self.voucherNo[i], ExtraTourist: self.tourExtras, TransferTourist:self.tourTransfers))
                    self.selectedTouristName.append(tourList[i].tourName ?? "")
                    
                    
                    self.printList.append(SendDataPrint(tourName: self.tourList[i].tourName, paxInfo: "ADL :\(adultCount),CHD: \(childCount), TDL:\(toodleCount), INF: \(infantCount)", voucher: self.voucherNo[i], tourDate: self.tourList[i].tourDateStr, transTourist: self.transfers.toJSONString() ?? "", hotelName: hotelName, date: self.currentDate, room: room, paxName: paxName, operatorName: operatorName, resNo: resNo, total:"\(total)EUR" , discount: "\(discount)EUR", netTotal: "\(netTotal)EUR", cash: "", card: "", guideInfoNumber: ""))
                }
            }
            
            if  self.payments.count > 0 && self.payments.count < 2 && self.printList.count > 0 {
                for i in 0...self.printList.count - 1 {
                    if self.payments.count == 1 {
                        self.printList[i].cash = String(payments[0].PaymentAmount ?? 0.0)
                    }else{
                        self.printList[i].card = String(payments[1].PaymentAmount ?? 0.0)
                    }
               }
            }
        
            print(self.data)
            
            if Connectivity.isConnectedToInternet {
                print("connect")
                
                let tourSalePost = TourSalePost(Multisale:multisale, PaxTourLists:paxTourList, Payments: self.payments, Paxes:paxes, IsOffline:"0", AllowDublicatePax:"0",TourList:tourListIndata )
                
                self.data = "\(tourSalePost.toJSONString() ?? "")"
                
                let toursaleRequestModel = GetSaveMobileSaleRequestModel.init(data: self.data)
                NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetSaveMobileSale, requestModel: toursaleRequestModel ) { (response: GetSaveMobileSaleResponseModel) in
                    if response.IsSuccesful == true {
                        print(response)
                        let alert = UIAlertController(title: "SUCCSESS", message: "\(response.Message ?? "")\(self.voucherNo)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let topVC = UIApplication.getTopViewController() {
                            topVC.present(alert, animated: true, completion: nil)
                        }
                        userDefaultsData.saveMaxVoucher(voucher: [])
                        userDefaultsData.saveTouristDetailInfoList(tour: [])
                        userDefaultsData.saveExtrasList(tour: [])
                        userDefaultsData.saveTransfersList(tour: [])
                        userDefaultsData.saveExtrasandTransfersTotalPrice(totalPrice: 0.0)
                        userDefaultsData.saveTourList(tour: [])
                        self.buttonSend.isEnabled = false
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
        cell.labelPaymentCurrency.text = paymentTypeList[indexPath.row].currencyTpye
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            let chosenCrossType = self.paymentTypeList[indexPath.row].currencyTpye
            let baseCrossType = "EUR"
            var baseCrossValue = 1.0
            var roundedSavedValue = 0.0
            
            for i in 0...self.exchangeList.count - 1 {
                if chosenCrossType == exchangeList[i].sHORTCODE {
                    if baseCrossType == "EUR" {
                        baseCrossValue = exchangeList[i].eUROCROSS ?? 1.0
                    }else if baseCrossType == "USD" {
                        baseCrossValue = exchangeList[i].uSDCROSS ?? 1.0
                    }else if baseCrossType == "RUB" {
                        baseCrossValue = exchangeList[i].rUBCROSS ?? 1.0
                    }else {
                        baseCrossValue = exchangeList[i].eUROCROSS ?? 1.0
                    }
                }
            }
            
            self.deletedAmount = self.paymentTypeList[indexPath.row].paymentAmount ?? 0.00
            self.deletedAmount = self.deletedAmount * baseCrossValue
            let roundedDeletedValue = Double(round(100 * self.deletedAmount) / 100 )
            self.savedTotalAmount -= roundedDeletedValue
            roundedSavedValue = Double(round(100 * self.savedTotalAmount) / 100 )
            if roundedSavedValue == -0.0 {
                roundedSavedValue = 0.0
            }
            self.viewPaid.mainText.text = String(roundedSavedValue)
            self.viewPaid.mainText.text = self.viewPaid.mainText.text?.replacingOccurrences(of: ",", with: ".")
            self.balanceAmount = self.totalAmount - roundedSavedValue
            self.viewBalanced.mainText.text = String(self.balanceAmount)
            if let index = self.payments.firstIndex(where: {$0.PaymentAmount ==  self.paymentTypeList[indexPath.row].paymentAmount ?? 0.00} ){
                self.payments.remove(at: index)
            }
            
            self.paymentTypeList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            print(self.paymentTypeList)
        }
    }
}

extension ExcProceedCustomView: EAAccessoryManagerConnectionStatusDelegate {
    func changeLabelStatus() {
       /*if printManager.isConnected {
            printerConnectionStatus.text = "Connected"
        } else {
            printerConnectionStatus.text = "Not Connected"
        }*/
    }
}

extension String {
    func haveSameCharecterSet(_ str : String) -> Bool {
            return self.sorted() == str.sorted()
    }
}

extension ExcProceedCustomView{
 
    private func connectEaAccessory(eaAccessory : EAAccessory){
        if eaAccessory.modelNumber.hasPrefix("iMZ320"){

            //Note: Zebra SDK requires communication in background thread
            DispatchQueue.global(qos: .background).async {
                //Zebra SDK specific code -- Start
                var connection :  NSObjectProtocol & ZebraPrinterConnection //define variable that confronts to NSObjectProtocol & ZebraPrinterConnection
                connection = MfiBtPrinterConnection.init(serialNumber: eaAccessory.serialNumber)! //Call Zebra's SDK to init a BT Connection
                
                if connection.open(){
                    print ("Printer Connected")
                    do{
                        var printer : ZebraPrinter & NSObjectProtocol //define variable that confronts to NSObjectProtocol & ZebraPrinter
                        printer = try ZebraPrinterFactory.getInstance(connection)
                        
                        let printerLanguage = printer.getControlLanguage()
                        print ("Connected Printer uses the following language: \(printerLanguage)")
                        if printerLanguage == PRINTER_LANGUAGE_ZPL{
                            self.configureLabelSize(connection: connection)
                            self.sendZebraTestingString(connection: connection)
                        } else{
                            print ("Our program only support printer using ZPL language")
                        }
                        
                    }catch{
                        print ("Error occured: \(error.localizedDescription)")
                    }
                    
                }else{
                    print ("Failed to Connect to ZQ620 Printer")
                    
                }
                //Zebra SDK specific code -- End
            }
        }
    }
    
    private func sendStrToPrinter(_ strToSend: String, connection: ZebraPrinterConnection){
        let data = strToSend.data(using: .utf8)!
        var error : NSErrorPointer = nil
        connection.write(data, error: error)
    }
    private func configureLabelSize(connection: ZebraPrinterConnection){
        let strToSend = """
        ^XA
        ^PW408
        ^LT16
        ^XZ
        """
       // sendStrToPrinter(strToSend, connection: connection)
    }
    private func sendZebraTestingString(connection: ZebraPrinterConnection){
        var hotelNameFirstColumn = ""
        var hotelNameScondColumn = ""
        
        //strToSend it written in ZPL language
        let testingStr = "^XA^FO17,16^GB379,371,8^FS^FT65,255^A0N,135,134^FDTEST^FS^XZ"
      // sendStrToPrinter(testingStr, connection: connection)
        
        //The first
       /* let testingLabelStr = ""*/
        
        if self.printList.count > 0 {
            for i in 0...self.printList.count - 1 {
                if self.printList[i].hotelName?.count ?? 0 > 20 {
                    hotelNameFirstColumn = self.printList[i].hotelName?[1..<20] ?? ""
                    hotelNameScondColumn = self.printList[i].hotelName?.substring(fromIndex: 20) ?? ""
                }else{
                    hotelNameFirstColumn = self.printList[i].hotelName ?? ""
                }
                self.printString = "^XA^POI^FO0,1560^GFA,34500,34500,69,,::::::::::::::::::::::::::::::J0C4I031C660C08I0186J0CC0018602003FE7CI0E18101C38I0F86F8I018803E663186388C1861860CM01J0300C60C60C6047F8,J0C603031CE70C10C0018608608E06186020026266080E1820DC30C20JC8300184026261186104E1861860CM030240381C60C60C60C4C8,J0C307008C020C306001821820040618607I060671C061860DC30830CE8C0380186006060186100C1861860C008J030620381C60C60C7080C,J0C307800C020C206001021030040718607I060631C0618C01831818C60C038018600606018610041861861C008J010620381C61C60C3I0C,J0C307800C020C606001023030040718607I060631E0618C01831818C60C0380186006060186100C18618618008J0104203C3C61C60C3800C,J0C301801C020C6030010230100403186018006067060619C0183101CC60C01C0186006060086108C1861861C008J010C202C3C61C60C1800C,J0C700C05E030C6030010230100401986098006066060619C0183101IC0C00C018E006072086188E1860860C008J010C30262C60C60C1C00C,J0C708C07F030C603001023010040B8C609C006060270619C0183101CC00C04C018E0060620C618861860860C008J010C30264C60C60C0E00C,J0C38DC0CF020C603001023010041FC061DC006060370619C0183101CC00C0FE018700606I0610041870870C00803C010C20224C70C60C0600C,J0C38040C9820C6020018230300410C0610C006060438619C00831818C00C086018300606I0610041870870C00823C010420238C70C60C0600C,J0C380608D820C3060018210300420E06106006060418618C00C31818C00C002018300606I0610041860860C0082I010620238C70C60C0200C,J0C380619CC20C3060018218210C20606206006060C18618E01C30810C00C1030187006060806100C1860860C0084I018620218C60C60C0400C,J0C300619CC60C1042018608030E60606206006060818618701C30C00C00C1030186006060806184E1861860CI04I018200210C60C60CJ0C6,J0CI021084204I030102I070E60604202006060808408I083J0800C003018I0206I02100408408408M01M0860C60C1800C7,gM0E02jN03,gM04jP02,,::::::J0CC1C70CE70FC18FC1CC60C60C0070E331FF8CC1F0E073FC07F0E18660EE0FE7FC0FC006638630E0FE198E38E39E1CE19I02030E61C60C70DC00187,I018618718671EC18EE30C60C60C0030E61199886198E031840618618C30461CC4CC0C700C318E30608C308618C18E18E308006030E60C60C618600187,J083184102310E10C630460820C003004191818219CC031800218610C304618C0C40C3018218830600C20C618C18E18C20C006031060C60C218600184,K03180300300610C660461820C00300C081830318CC0218002083218184618C0C00C3018018830E00C604618C18610C60E007030060C60C2303I088,K03880300300610C660061821C00300C0C1830318CC0218002083018184618C0C00C3010019030E00C606618C18710C406007030060C21C2703I088,K03890700300320C660061820C00300C0C1830319CE0218802181C3818461CC0C00E701001A030600C606618E18320E406003830060C2083703I0D,K038F07003C03A0EC60060824C003E0C0C18303198EC218802381C38180607C0C00EF01001E030600C406738E181E0EC0600183E060C2083F01I0F,K039F87003E01C0E060068828C00360C0C18303180C6218802181C38188606C0C00C703001F034600C4063B8C181C0E406019836060C68C2703I0F,K039987003601C0C060070830C00330C0C18303180C62180020C0E3818860CC0C00C381001B838600C606018C180C0C40601FC33060C70C2703001B8,K0398C3003300C0C060070830C00330C0C18303180C32180020C071818860CC0C00C1810011838600C606018C180C0C606010C33060C70C23030019C,K0318C3003300C0C060060830C00318C0818303180C22180020C0318188618C0C00C1818019C38610C604018C18080C606I0C31860C70C23030018C,K03184300318080C030060820C0031841818182180C631800208438C110618C0C00C3018018C30630C20C018C18I0E20C020631860C60C61820018C,M082080718I0C010060820C40308I018080180C421840208C384230630C0C00C300C010430630EJ018C18200E3I020630C60C60C208430186,gO06gP0707Y0E07gK0EM018,i0601Y0C03gK02M01,gO04gP04gI01gK02M03,,:::::N0806gK02g018g06I04K08O018R08J02,J0FC0661F9FC1F820FFDC381C39FE038E0D81DC3B8FF39C6040FF807E02I0FE7F8C18CI0FE19807B061C33B877063F07738718701FC01E0B005878,J0C60C3118C61DC308CDC301C38C2030618C18C1186038C606098804602I0CE308C18CI0CC10C061861C61987306330C318718701CE03E01008868,J0C308310CC318C300C0CI0C10C0010610608C118600C8006008800607J0C308C184I08C20C060C620C0980300319C1187187018602711808CC4,J0C318180CC308C700C0CI0C10C0010630200C11860048807008I0207J0C3008104I08C206I0C621C0180300119801871860186003108084C4,J0C3181818C308C780C06I0C10C0010630300C11860048807008I0607J0C3008104I08C606I066418018018011B80187186018600310988584,J0E6101C38EE08C980C07I0C30EC010660300C1187603D003808001C098I0C330C306I084606I0E7C1801A01C011B8018718201CE00210998586,J0E7101C38EE0D88C0C03I0C30C4010660300C1186203F001808I0C098I0C310C306E0084606I0E7C1801F00E0I30018318201CEI030818586,J0C3181C18C70809C0C03C00C10C4010660300C1186007981B808I0619CI0C310C1046008C606I066C1801B0070303801831A20186I030818586,J0C398180CC3881FC0C01C00C10C0010660300C1186006981FC08I071FCI0C300C1042010C606I0I6180198070303801831C20187I010818584,J0C398180CC39810C0C01800C10C0010630300C018600C8810C08I0310CI0C300C1043010C606I0E661C0198030103801C31C20183I0108184C4,J0C398180CC3981060C01800C10C0010630600C018600C8C20C08I03306010C300C1043010C206I0C631C018C020301801831830183I010808CC4,J0C308301CC3182060C01800C18C1030610420C2186018C420608I06206030E304C1846030C30C0018638E018C020300C01871830186039018088C,J0C2J018C2182060C07001C10C20306I070EC186018C4606186004206070E308C1844030E0080010618201861C03006018718301C403F0018J06,gX0E0ET02M0607O0607hJ04,gX0802gH0401O0403,h02gV01,,:hM021,hM033,,P06h08hG0CT01003001,J0E3CFC0983B0719F860FFDC6030E0D8718E04019CE0CE1C39DFF040070E02003F0C630E398E38E30C70E0079833BFE38006718300630CC0CC198638E799C38C38E6,J0C18C610C318609DC608CC800306184718C06011860C61860C190E0030E06003B8C0306308C18C30C30C0030861B703J0318300C31861861886186308C38C18C2,J0C18C630630C6018C600C080030630611900E0108600618E04110E00304070031880306300C18C30C20C00300C08303J0318301811831831806184300C18C38C,J0C18C260630C6018E600C080030620709900E0108300618C00100E00304070031880306300C18C30C20C00300C08303J0318701803033031804184300810C38C,J0C18C260230C6018E600C080030660309800F0108300639C00100700304030031880306300C18C30C20C00300800303J0318B01803033019804184310810C58C,J0C18C6602398730CC600C0C403066030DE0030108110659C0010030030C0180398C4306390C18430C30C003B08003038I031830380301F019804186330C30C18E4,J0C18E46023B8730D86E0C0C003066030FE0030108190699C0010038030C01803B0C4306390C18430C30C00311800303BI031830300301F019986186310C30C98C4,J0C18C060230C601C0630C08003066030DE01381081E0619C0010138030C198038080306300C18C30C30C00300800303180031830380301F0198C4184310C30D18C,J0C18C060230E60180630C08003066030DB03381080E0619C0010118030411C030080306300C18C30C20C00300800303180031C3038030330198C4184300C10E18C,J0C18C060630E60180630C080030620319982181080C0618C001I08030420C030080306300C18C30C20C00300C003031C0031C3018030330318C4184300C10E18C,J0C18C030630C60180630C0800306306199800C1080C0618E001I0C030420C030080306300C18C30C20C00300C0030318003183018038338318C6184300C18C18C,J0C18C010C30C709C0630C0800306384319C40CE181806187001840C030E2060380C0306304C18C30C30C403046003033818318300C018618618C6186308C38C18C1,J0E1CE0088398719C0660C0C4030E088318C40EE1C300E1C3803840E070E6060380C238E388C18E39C70E6039C380703B0387183007004C044198638E718C38C18E2,iS03S02gT07,iS01,,::::::iQ024,J0C1804006301018618C20186180C1DC001807102108C60384018631830C61C06018633180E388C18E118618218201CC390C0380C600C30C100C41806309982301,J0C180C006103018618C10106181C18C020803186188C7038C104661830831C0E018623180E304C18E118618618201C6398C0381C600C30C100C718063010C23018,J0C180C006183818618C00106181C388060C030CC1C0430388184641831830C0E0106239C1E300C184010610618601C7398C0381C6008108300C318043I0C03038,J0C181C006183818618C001061C1C3080E06020CC0C04303081C0601831018E0E0106039C1E300C184010610618601C7388C03C3C6008108300C318043I0C03038,J0C1816006182818618C0010E1C1C3880C060209C0C0C383180C2681833018E0E010E030E0E300C184010610618E01C7398C03C3C6008308700C718063I0C0300C,J0C3832006704C18618E40112160C1D80C06033980C18383180C3781C73018616011206060E390C186618610619201CE398E6242C720C308900CE1C06390380304C,J0C3822006384C18618C40102162C0F80C06033980C0C2C3180C3781C33018306010207070E390C186218610218201CE380C4264C600C308100CF1986310180304E,J0C186300618CE18618C00182170C0F80C06031DC0C0C2CB980C3781833018326018203030E300C186010618218201C7380C0264C600C30C100C718C63I0C0304E,J0C1843006188618618C00182134C1C80E06030CC0C042F9081C66C18330181A6018203838E300C18401061C21C201C3380C0238C600810E100C398C43I0C43086,J0C1801806188618618C0018213CC188060C030CC0C06271081866C18318101C601820381CE300C184010618218201C3380C0238C600810C100C398C43I0C43083,J0C1801806190318618C10182118C38C060C030CC18042718C1846618318301C6018203818E304C184010618218201C3380C0238C600810C100C318C63I0C83003,J0C1881C06390318618C30106118C30C0318031C6180C6338410C671830C200C6018603118E384C18E118618618201C7380C1210C618C30C100C718C630C1C8310308,J0C1881C0633031C638E30186110C60C011007102201862382008631830441806018606100E38CC18E338618718201CC380E2200C710C30C181C4198E3881B8790398,lM03018,lP08,,::::::M0401I0100C18018I04009818I020C0600C18021J08610040800204308I0C03K0230830806100C6100C0100410430401L020020100401002,J0630C03003380C1808C0C0630B93B04031C0630C386618431C738461C0070C308420C030C630671831C06301C6100C6384618E306038C308031866384603067,J0C18C01I0180C1808C0C061018318603100618C406218C11C63806080020C300C30C0308E18231830C0E300C6I0C71846184306010C30C030863184603062,J0C18C01I0100C380060C041818318E02200618C004210C18861804080020C301818C0188C18221830E0E100C6I0C3180618430E0106606030C631807070C2,I0181CC01I0100C3800E1E04181831CF02200618C004211808C61804080020C30181CC0191C0C221870E0E100C6I0C3180618430E0106E06030C631807070C2,I0180CC01080100C7800C16061038318303400618C004211808C63806080020C31181CC00E180C221870E16100C6I0C7180618430E010CE060308231887830E2,I0180CE01982180C1801C320630383B8383C00638F804219808C63906180030C31181CC00E180C621830B16180C6200CE1886184306019CC06031827188583076,I0180CE61082180C1801C37063038381383C00638D804219808C63806180030C31181CC40F180C421830B26118C6I0C71804184306018CC060318201885C3036,I0180CC21002180C1800C2706183838138360061CC804211808063806080020C30181CC60F180C421C309A610CC6I0C318061843060106E06030C201804D3032,I0180CC31002100E1800E4304181830018270060IC04211808061804080020C30181CC6039C0C421C309E610CC6I0C398061843860106E06030C601804F3062,J0C1CC31004100E1800E418418183I0C230060CC604210818061804080020C301818C6119C0CC21C309C610CC6I0C398061843860106606030C60180073062,J0C18C31004180C1800E418618183020C238060CC604210C18063806080020C300C38C621CC188318308C610CC6080C31806184306010660C030C601824630C2,J0630C6304C380C1800CC1C630383860C3180618C3386184100738460C4060C308C30C420C6118718308C6319C6180C7384618E306018C3080308603844631C7,M040101C380C1800800C400181I042080200C11021K06180408402042K0C020C00183881I06100C6I0C0180410630401L02J018I01002,Q0180CiI03018gH03,T04iL08gH01,,:::::J0C18K08C010C308070C20C0980400C18003066042J0306306I04210060860100608060C1184180608C06100208302020CK0C,J0C18610208C038C318070C70E1980610E38C330E60C63082306306I06618060C60180618060C118E180618CC6106318323070C06018C,J0C18C18608C010C308070C70E3880418C418131060C63182306306I04618060C60100618060C1184180600CE6I0308322060C06018C,J0C18C1C400C010C308060C70E388040CC41803103086138030E30EJ0210060C60100618061C1184180600C66I0308302060C0E030C,J0C1880CC00C010C308060C71E388I0CC41803103006130030E30EI04218060C60100638061C1184380600C66I0308702060C0F030C,J0C1880CC00C010C308470C70E398I0CE83003201806370030630E3004218060C60100658061C1184380640C66I0108B02060C03018C,J0C1980EC00C410C30C470C70E1D8I0CF83003E01C063700306306I04218860C70100608060C11841807C0CC6200108302070C1300CC,J0C1880EC00C010C308470C70E0F8I0CF83003E00E060700306306I04218060C67100608060C11861807C0C06I0108302070C1380CC,J0C1880CC00C010C308070C70E0D8I0IC3003300E060700386306I04218060C63100608060C11861806E0C06I030C302060C1380CC,J0C1880CC00C010C308060C78E1C8I0IC38033006060300386386I04210060C63900608070C1186180660C06I030C302060C21C18C,J0C18C0CC00C010C308060C70E188I0CC618031806060380386386I08210060C63900608070C2186180630C06I030C302060C20C18C,J0C18C18600C010C308070C70E3880018C71C031C04060180306306I08618060C63100618060C2186180630C06080308302060C40C30C,J0C18610300C338C31C270E70E71C0030E30E038C3C0600C03863063018738460C66180E1C061CE18E180618C06188318303070C60E71C,J0418N01043880204204208J04J01041M0306306303879006086J0408040880840804J02018388002020C004008,X018gW0103018gQ03018,Y08gY02008gQ02008,,::::::J0C18080D8DD80418630E040070CK08CI070CI0118408608D998411860106100C6101DJ08470C20062180CI03J01B3L060C60CI03200172,J0C38180CC9C8C218E30E0C0070C04I08C31870C18C11861860C98984118E0306180C6101D81018470863067180CI0700431I30804061C70C0607304172,J0C001808E0C0831863I0E0030C06I08C20C20C3061184086089818011860106100C60018C30304308C1862180CI0700C103020C0C060C60C060330C03,J0C001C086081819863I0E0030C06I08C60620C6061184086181818011840106100C60018C38600390C1842180C003F61818306060E060C60C060318E03,J0C003C08608181986300160030C07I08C40620C6071184086181818011840106180C60018C386001E181C42180C007311818306060E060C60C0E0318E03,J0C00240860C30198E320130030C03I08CC0620C6031184086281818011860106180C6001CC1C6I0E180C42180C00631181830E0607060C60C0B0311603,J0F80460CC0C30198E3E0230030C038008CC0630C603118618608181C811860186190C6201C84C6I0E180C42198C00631B80830C0613060C60C1B0331303,J0F80460C00C3019CE3E0230030C1B8010CC0630C6031186186081818011866186198C6001C04C6I0E180C4219CC00631B80830C0613060C60C1B8303303,J0CC06E0800C10180E330330030C1F8010CC0630C603118408708181801186310611CC6001C0FE6I0F180C4218CC0063118083060637860C60C3F8303703,J0C40020800C181806330018030C31C010C60620C607018408708181801184310610CC6001808660013180C0218CC0073118183060621860C60C21C306183,J0C600308008181006318008030C20C010C60420C606218408608181801184310610CC60018186700238C180218CC003F618183060641860C60C20C304183,J0C30030800C0C300E308408070C60E020C20C70C30E618408608181822184710611CC6001C103300618C180218CCI0780C103030C40C60C60C40E3041C3,J0E39839C01C06600E30CC0C070EE0E071E19070E198C18E1C61C1C1CEE1CEE3863F9C6301C3071F0E1C221CF199E60070062038198C1EF1EF1E60E70C1C71C,gT060EhQ03838I06gR0C,gT0402hQ03018I02gR08,gT0402hT08,,::::::J0C40C306318401060CI06010C23EK0306108C03E0200C1I01831830260187J0C660CI03E176L080C030C070E30EJ04CJ031860318608C,J0C60C306318030871C0C06030C03B86I030C218C03B8430C38861831830C6018701018660C10C330720CI030CE030C270E30E0601CC030C31860398608C04,J0C308302318060C2100C0703080318EI0300408C0318818C01821831860C6018303030260C204318300CI0604E0708030E30607018C020E01040098800C0E,J0C30830031806062200E070308031CFI0300C00C031D818C03031831860C6018303820260C606318301CI0600F0708030E30607018C060601040058800C0E,J0C3083043180E062I0607070C031CFI0300C00C031981CC03031831860C6018303860060C6063183016I0E00B0F08030E30403018C040701040058I0C0F,J0C7083043180C063400705870C43983I0320C00C031981CC83031831830C6018301860060C6063383016I0E00B0F0C430E30C09818C040701062039I0C03,J0E70830431IC063C00305870C43B838003E0C00C43B181CF830118318307E018304C60060C6063303026I0E0099B0C470C30C0180EC04070106603FI0C13,J0C70810431C0C063C00304890C438138003E0C00C038181CF830118318307E01830CC60060C6063003027I0E009930C470E30C1180EC04070106207FI0C13,J0C38C3043180C062603384D9080381B800330C00C030181IC30318318206601830DE60060C6063003077I0E008B308030E30419C0CC040701040079800C338,J0C38C30031806062302184F10803I0C00338C00C0301818C63031831C20E6018318660060C60630030438006008E308030E30620C0CC0606010400D9800C218,J0C38C308318060C2384184710C03I0C00318600C0300818C61821831820C6018310730060C20430030418007008E308030E30620618C020E01040198C00C00C,J0C30C308318230861840C4630C03860C6030C700C0300C30C3186183183186018730738460C30C3003081CC03008430C270E30E20630C030C41840198C20C40C4,J0EE1C39C71CE19070CC1CE038C63860E6038E380E6380660C30CC38718738603873079F060C19870070C1CC01C0C030C670E70E60770C0198E38F331C671EC0E6,J0DC0833FF8F80E0604C0C4030EC10406603040E0FC3001C0C1070182183206018320307060C0803003080CC00E08030F420C30C60660C0061F7C7A2186IF40E6,O01018gH02iY0180CL0C02,O01008kK04L08,,::kW0118,kX0B,,J0C30C04020C20CM04J021831830C026I01041081131306300C6K010430420CJ04I0230C10C10CI201018618C1898386380C30C030E64300603,J0C30C0E060C3140CI0304410431831830C04703018410C3131306300C6I08310430820C00304208230C10C10C06303018618C1818386380C30C030066300603,J0C30C0E020C2I0CI0604C18021830830C00307010410C3030306300C60018310431020C0020460C010C10C10C00103818618C3818306300C30C030043300707,J0C30C0E020C2201EI060080C021830830C0030781041083030306300C60018190431021C00600C0C010810C10C00103818618C3818306300C21C030043300707,J0C30C13020C22016I0E0080C021830830C0070581041087030306300C60030190432021C00600C06010810C10C00301C18618C3818306300C21C030043300707,J0C30C13020C34016I0E0180C021830830C4060D8104108B030306300C62030190436022C00600C06010C30C10C40600C18618C1818386380C22C03004730058B,J0C30C13020C3C023I0C0180E021C30830EC0E088104108103030E3A0C66030198C3E024C00600C06030C30C10E40E00C18618C1818386380C30C03E06639058B,J0C30C01020C3C023I0E0080E021C30830C40E08C10410C103030E3B8C62030198C3E020C00600C06030C30C10E40204E18618C18183863B8C30C03E060390583,J0C30C21820C36023I0E0080C421830830C00318C10410C1030306318C60030180C37030C00600C06210810C10C00300618618C181830631CC30C0320403004D3,J0C30C00820C2304180060080C421830830C00310410410C103030630CC60018180431830C00600C0C210810C10C00108218618E181830630CC30C0330403004F3,J0C30C00C20C21841800700C18421830830C00300610410C103030631CC60018300431820C0030060C210C10C10C00300318618C181830631CC30C031840300463,J0C30C40C60C718C1C40388611831831830C20720718430C3030306318C6100C600C30C20C60380219C30C30C18C10310318618C1818386398C30C031C6030446318,J0IFCC0E70E70CC1CC01F0361871C71FF9FE3E3073IF9C383078F3F1CFF006C00E30E70E601F01B1C39C39FF8FF1E3839IFDE383838F3F1C70E070CE03FCC2398,J0IFC40E60C204C0C400E01C1031831FF8FC1C2031IF9C30303063C0C7E003800430470C600F00E0031C30FFCFE0C3031IFCC18183861E0C70C0304603F840318,gV08Q08hI0CQ0C,gV08Q08hI04Q04,,::::::J0C1981183010046100E18E1CE3C00E1821023042231300C10C18CI0183118018621060300C60104309831841I04180210230C0618C11808I063001,J0C0080183038046100618E1C62I0C1861823083030300C10C18CI018211860C601060700860306300C31861I04180608230C011801180CI0618418,J0C00C0182038046100618E186J0C18C0C03181030300C10C18CJ0C2118E0C601060701840306100C21861I04180C0C030C001800181CI0618C08,J0C00C0182038046100418E386J0C18C0C03181830300C10C18CJ0C0018C0C601060781840603100C21861I04180C0C030C001800181EI0619C0C,J0C00E018201C046100618E186J0C18C0C03181830300C10418CJ0C4018C04601060181840603100601861I04380C0C030C001800180EI0619C0C,J0C806018200C046180618E186J0C18C0C03381830300C10418C4I064018C06601060980C40603180601861I04381C0C030C403A001806I0639C0C,J0F807018200C046180618E1C78I0C19C0603381830310C10418E4I064018C067010608C0E406031903418C19004181C04230C407E001807I0671C0C,J0C803818204E046198618E1C6CI0C18C0C03381830300C10418EJ038018C046710608C06406031983818619C04181C04230C00FB021827I0619C0C,J0C401818200604610C618E1C64I0C18C0C03181830300C10418CJ038218C046310600C0C4060310C1818210C06180C0C430C019B021803800419C0C,J0C601818200304610C618E1866I0C18C0C43181030300C10C18CJ010218E0C631060060C4030610C1818310C06180C0C430C0199821841800418C08,J0C60181830030C610C618E1863I0C1860843083030300C10C18CJ01001860C63106006184030611C1018610C04180608C30C03198418C1800618C18,J0C3030183103386118E18E1CE3880C1861B830C3030308C18C18C1300604186186730620618601843185018611804180618830C2318C418C1CC061861,J0E38E0183303B873B8E1CE1CE1980E18I387046030718C38E18E3300E0E1C3107E30630730E00883B8E01CC3B80E1C0331C79C6738CE38C1CC073023,J0800401831031061C0C18008I0804180C103038030370C18FBC7C30040FFC0C03830620320600701C0401E01C0041800C3FFCFC6187FFC00C4078018,gP08gI04L01804gV0300CK01804,kP01,,:::::J0C008061I0604CJ0618001027042J01061060102L010041042004104004001004I02J04C306306I01J0C840106080991060461,J0C20CC61180618C0630E388218E7066208338630601820860C3384618C300C18418610180E020308604630630610410C00C4C030E30D183870463,J0C3084601C0E18C0418600801883046318030610601821821813806184200C18418600181E060300604630E30630610C00C0C0100205103070463,J0C3086601C0E18C001C601801983046318010610601823031801806184200C184184001C1E060300700630E30630610400C0C0110600103060463,J0C3086601E0E18CI0C601801901886310010E10E01823033801806104200C184384001C1E070300700630E30620710400C0C01106001030E0463,J0C3086600E1E18CI0C601001901886330010E10E01823013801806104200C184386I0E0E0F0300300630E30620310400C0C01006001030E0463,J0C708C7206161CCI0C683001E00906330010610601827013803984104310C18458660060E090300380C30E30660310C00C0C21E0C00103060463,J0C70C07203060ECI0C6C3001E00F07030010610601827013803804184310C18418620070E198301180E30630E60310C00C0C21E0C001030604631,J0C38806003860CCI0C6C3001B00606030018610601827013803804184300C186186I030E198301180630630620310600C040130C0010386046308,J0C38806001C60CCI0C661001B8060603001861C601823013803804184200C186184I03CE31C3010C0738630620310600C0401306001038604630C,J0C38806001C618C001C6618019C0606018018618601823031801806184200C186184I01CE20C3020C0738630620610600C0C01186001038604630C,J0C38806081C618C00186318018CI06018018618601821831C03806184200C184186I018E20C3020C0630630630610600C0C011C600103860C6308,J0C30C060908630C0030630C018E080700C038618601821860C0384618C308C18C18E10108E60E3060E0630630610410C00C0C130C300183873863198,J0C60C061900630C00206186018618070060306106018200406038C618E300C18C18610100E60E306060C30630608018800C0E330418018387306311C,i07iG0C,i01,,::::::J0EC0C38C3026I0160E18E1CE1C330019838618CC19811F0188C18C1800618241FF0903E180E3980E41C3I018C0FCFF01D8006670C61C318020C71873831816,J0C20C30C3043I0610E18E1CE3CC30010C38E30CC19C119830CC10C1800618431331083318063080E31C218408C19C19818C018671C61C318610C71831831861,J0C30830810C1800C18618E1C620810010410060CC00C119C60CC10C1800620C30312043398043I0C30C210600C31C1881860182610618118418C31831C318418,J0C3083081081800C08618E1860181J06100604400C018C404C30C3800601818102043398043I0418E430200C31C1801860300200618118C08C31830C218C08,J0C3083081181801C0C618E386018K071004004004018CC00C30C3800641818306063198043I04186030300C31C1801860300200618018C08C31830C218C0C,J0C3087081180C0180C618E1C601L03100C004806219CC00C70C380060181C1060633980431004303860300C39C18018E0300200638218C0CC318306419C0C,J0EE0830C3180C0180C718E1C781K01F1E0C00F80221DCC00C90C180078380C10606331F043F007F03860300C0DC1801FC03003C061821980CC71E70601F80C,J0C70830C3180C0180C618E1C781L071E0C00FC0341C0C00D10C18007C380C1060630198431006703860300C0DC18018E03003C061821880C6718303819C0C,J0C38C1081180C0180C618E1C6C1L071B0C00CC03C180C00E10E18006C1818106063018C43I04383C20300C09C180186030036061821880C0718303819C0C,J0C38C3081180801C0C618E186618K07118C00C6018180C00E10E1800661818106063018C43I04184C20300C19C1801870300220708018C080318301818C0C,J0C38C3081081800C08618E186618K06118600C6018180C00C10C1800671818106043018C43I04188630200C19C1801870300230608018C080318301018C08,J0C38C30830C1I0C18618E1C631CK0630C600C3010180600C10C1800630C30302043018C43I0C188610620C31C18018601806186180184180318301018418,J0E71C38C3862080630E1CE1CE38FK0C38E380E38601C0380C38C3880E3866038108303D8E38C0E718708470C71C1801CE01C071C61C638210073C70E01C63,J0C0081081J0CJ0418408618M01040CJ04018K010010C0608I01J02018043I04I02I0F0E6081001L02J08E1CJ021820C008,jQ0C06Y080C,jQ08gI04,jQ08,,jV084,jV0CCV0118,jV078W0B,,M0C18C10C18CK070C02K098600EI02E8C080C18400183J0C400C711041I01E0038J08718C18C07387I0C4J0801018020C60C,K080E18C30C18C3180071C06102118C630CC104E4E080C18E001870C20CE08C7198630301E003880C0C718C38C07387I0C40406184198060C70C,K0C0C00C10C18C60C007I02186198C618C6380606080C18C0018318308400C7I0640300C0010C0C02700C38C07387I0C00E0408C190060C30C,J01C0C00810C38C60C007I0208C0C0C618C6380606I0C1840018318308400C3I0640300C0010C0C00300C18C06387I0C00E0C018090020C30C,J01C0C00810C38CC06007I0208C0C0C618C6380602100C1840018330188400C3I0680700C0010C0E01200C18C0638F100C00E0C018010021C20C,J0340C00810C58CC06007400219C0C1C630C60C0603100C1840018330188400C3002680580C0010C0601340C18C06387300C01318018010022420C,J0260F80810C98FC06007C003F1C0C387F0EC4C0601200FF87E018330188400C3F03F00C80C001F82201F80FF8FC6386I0F8131801801F82443FC,J0660FC0810C18CC06007C00239C0C1C638E04E0601E00C1840018330188400C3003F808C0C0019C2301FC0C38CC6387I0DC3318018018020430C,J0670CC0810E18CC06007600219C0C0C618C0CE0601E00C1840018330188400C30067818C0C0010E63013C0C18C66387I0CE339C018010030430C,J0430C60810E18CC06007200208C0C0E618C0860600C00C1840018330180400C30066C10C0C001064383360C18C26387I0C6218C018010030430C,J0838C60810C18C60C007300208C080E618C0070600C00C18C0018318310400C70046E1060C001060182360C18C67387I0C6018C01C010030430C,J0818C30C30C18C2080071802186180C618C1030E01800C18C1018318310E30C708C662070C0010C8186730C18C67387100CE40C600C010060C30C,I01C3FE39FF9E39E1B06071C07F03707CFF0E3878E03I0E3CFF03C78FC3FEE1E7F98E7F071E203FDC1EE739C39FC778F301FCC1E3E07C3FC71E70E,Q01CM06gY0707gU018,R0ChM0603gU01,R04hM0401gU01,,::kI062,kI066,kI03C,,J0C18N020CI0101P0C080080060C2I08008008C2I030820081J0200208L01I01I08L0600810C1,J0C186318020860C06I131020030800IC11CC060C7080C21C508C600630C600C3J0308708C20460188038818J082710C18C18,J0C006218060C60C0601031860030C00C0C10CC060C7080C31C808C210230C600C3J030C31983046010C038018180182600C30C18,J0C0022180E0660C0F01030860030C00C0600C6060C7I0C31C808C230330C200C3J030C1B181806010403003C100300600C30C18,J0CI02180C0660C07010308F0030C00C0600C6060C3100C318008C230330C200C3J030C1E181806010403002C300700600C70C18,J0C8002188C0660C03010318B0031C00C0300CC060C3100C71D008C230330C210C3J03180C181806010C030064300700600C50C18,J0F80021FCC0660C010103B99003F800C0300DC07FC3F00FE1E008C3F01B0C7F0FFJ03F80C101C0601FC03F0443007007E0C90FF8,J0F8002180C0660C1181030198031C00C03C0C0070C3300C71F008C370119C700C3J03180E101C06019C03B846300700720C10C38,J0CC042180C0660C1181030318030C00C01C0C0060C7I0C31D808C230300C600C3J030C0E1818060106039C46300700600C10C18,J0C4042180E0660C218103021C030400C01C0C0060C7I0C11DC08C230300C200C3J030C031818060106031C82300300600E10C18,J0C604218060C60C00C103060C030400C0080C0060C7040C31CC18C210300C200C3J030C239818060106031C03180380600C10C18,J0C318318031860C40C103040E030C00C0700C0060C7080C31C670C208600C608C3J031C41CC3106018C0318030C0180608C18C18,I01E3F87BFC1F0F1EE0E383CE0F07F801E0701E00F1EFF81FE3C7F1E70FC01E7FBC78I07F9E3E7E3FF03F807F183C7C0F8FF9E3DE3C,jG0387Q01002,jG02018,,:::::::J0C080208J020C04010100402O01I08002I080040386L08L0801J0180C00801818118P02I08O0106,J0C086218020860C06I1318C060040109003819800718180064387082I0C208201C6398C0380C1180981C31882001041046I0C240820118386,J0C006218060C60C0E010318C06004119880180980071C180064386183I0C318300C3398C03C1C3180180C318C6001042006I0C0C0860018186,J0CI02180E0660C0F010308C06004119080100980071C3C0064386301800C310100C3388C01C1C3180180C218C7001046006I080C0C4001818E,J0CI02180C0660C03010308C060043190801I080071C2C0268386301980C310180C7398C0141C31801806218C700104600610080C0CC0018186,J0C8002188C0660C03010318C060043090C01001800738640268386301980C630180C7398C4162C19801806418CB0010C600630080C0CC0018186,J0F8002188C0660C03810318F8600430B0C010018007784403F8386301800CE30180FE398E6162C1D801803019898019C600730081C0CC0010186,J0F8042180C0660C11810300FE600430B08010018007384603F8386301800C630180EF380C4126C0D801803818198010C600730080C0CC0010186,J0CC042180C0660C11810300C76004319080101180071CC6067C386301800C310180C3380C0134C1980180181819C01066006I080C0CC0010186,J0C4042180E0660C00C10300C76004119080101180070C82066C386381I0C318300C3B00C0138C1980180181830C01066006I0C0C0C600101C6,J0C604218060C60C00C10300C76004119880181180070C030C66386183I0C318300C3380C0118C318018I01820E01063006I0C040860018186,J0C318318231860C40C10300CE600413098018F180471D030C673860C6180C70C201C7380C1318C6180180F018606010C1806080C061830018386,I01E3F873FC1F071EE0E38381FC700E0E0F0038E1C047F183F8E3B8F07C181FE06C01FE380FF301EE1C03C0E03C60F03F81F8FF81C03F01F038387,i018,iG08,,::k031,k03B,k01A,,J033K06218620430180E0100C0808006I0603K032040403I030C03063008200322I0C03N01J08J060C02I0408080018E18C3083083,J033083046118830C30180E2301C18980061006030181832I0E0308030E0306380C202313001C23I04080C188218061861C061806180C0018E18C3183183,J023081806018020C30180E0300C08080061807070181812I0E0180030C03063818200302I0C03I0C080C0902180E0C61C021804080C0018C38C3183083,J023181806018020C30180E0300C080800618070701C3012I0F0190030C030E3C18200302I0C03I0C00180303180C0C61C021804081E0018C38C3187087,J023181806019020C30180E0300C080800618078F01C3002I0300E0031C030E2C38200303I0C03001C00180303180C0E61C02180408160018C58C3187187,J023101C0607D030C30180E0300C080800630058B00C3003600300E0030403062428210303I0C43101800180303180C0661C02380618070018C18C3183183,J023101C0607E030C3A180FC3B0C080D80670018B00E3003E00300E0030403062668330303200CC31018001803011F9C0660C03380618030018C18E7183183,J023101C0607F030C33980E6318C0808C063800D304E3003E01180F0030403062648210303100C0300180018030319DC0660C03180618230018E1867183183,J0631818060D9020C31980E7308C08086061800D30473002300180300304038622C8200302180C03001C0018030318EC0E70C021C0408238018E18071830C3,J043181806099820431980E7308C08086061C006308330021I08018038403862388200302080C03I0C00180103186C0C70C020C0408018018E18031C30C3,J043081086198820C31980E7308C080860618046318318121800C21C030403062388200302180C03I0CI0C018218C60C60C020C0408418018E1803183083,J0830C2386318C30C33980E6319C1818C063804631839C230C40C60C030E0306310C608303381C230806100E008619C71861C06180618C0DE18E1803183183,I01FFC7C30F71C670E7E3C0FC3F1C1C1F80FF00E03B8387870EE0EE1E078E078F701C7F8707E01FE7F803E003C07C1F81E0F1E07F00E1CC1DC3DE3C079C79C38,I0181C,I0100C,L04,,::::::J0220E019C8C0413B38C230C070C118,J0C18C019C8C0C1383042308070C30C,J0C1CC0318060E0303002308030C606,I0181CC0318040E0303002308030CE06,I0180CC01180C030303082308030CE06,I0180CE01981813030398230C030CE02,I0180CEC0D81C13030398230DC30CE02,I0180CC60D80C338303002308E30CE06,I0180CC309806338303002308630CE06,J0C1CC319806018303002308630C606,J0C18C23180E40C303006308630C70C,J0630E671C0C40C3838DC30CC70E1186,M040218J0C1030081I020CI02,,:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::^FS^FO10,20^GFA,2425,2425,25,,:::00hKFE,007hJFE,:::::::::007gUF80JF3FFE,007LF81JFC3OFE1KF83IF807FFE0FFE,007LF01JF8007MF803IFE01IF803FFC07FE,007KFCI01FEJ03KFCI0IFCI03FC01FFC07FE,007KF8J07L07JF8I0IFK0FE01FFE03FE,007KFK03L01IFEJ07FEK07E00FFE03FE,007JFCS0IFCJ07FCK03F00IF03FE,007JF8S07FF8J07F8K01F807FF03FE,007JF8007EK0FF803FF007E07FI07E01F807FF03FE,007JF001FF80080FFE03FE03FFCFE001FF00F803FF03FE,007IFE001FF80780FFE01FC07JFC003FF80F001FF03FE,007IFC003FFC0781IF01F80KFC007FF80F001FF83FE,007IF8087FFC0781IF00F01KF8107FFC0FI0FF83FE,007IF81CIFE0781IF00F03KF018IFC0E0807F83FE,007IF01JFE0781IF00E07KF03JFC0E0C07F83FE,007IF03JFE0781IF80C07FFC7E03JFC0E0C03F83FE,007IF03JFE0781IF80C0F8003E07JFC0E0E03F83FE,007FFE03JFE0781IF808K03E07JFC0E1E01F83FE,007FFE07JFE0781IF808K03C07JFC0C1F00F83FE,007FFC07JFC0781IF01L03C0KFC0C1F80F83FE,007FFC07JFC0F81IF01L03C0KF81C1F80783FE,007FFC07JFC0F81IF01L07C0KF81C1FC0787FE,007FFC07JF81F81IF0203KFC0KF8181FE0387FE,007FFC07JF81F81FFE0203KF80KF0383FE0187FE,007FFC07JF03F81FFE0603KF80JFE0783FF0187FE,007FFC07IFE03F81FFC0603KF80JFE0703FF8087FE,007FFC07IFE07F81FF80E03KF807IFC0F07FF8007FE,007FFC03IF80FF81FF01E03JFC007IF81E07FFC007FE,007FFC01FFE01FF81F803E01IFEI03FFE01E07FFE00FFE,007FFE007F803F801E007E007FFK0FF807E07FFE00FFE,007FFEL07F8K0FFT0FC0JF00FFE,007IFL0FF8J03FFM06K01FC0JF80FFE,007IF8J03FF8J07FF8K01FK03F00JFC1FFE,007IFCJ0IF8I03IFCK0FF8J0FE00JFE3FFE,007IFEI03IFCI0JFEJ07FFEI03FE01NFE,007JF800JFE007KF8003JF001FFE01NFE,007gSFE03NFE,007gTF03NFE,007gTFC7NFE,007hJFE,007gPFDSFE,007FFEgY07FE,007FFCgY07FE,:007FFEgY07FE,007hJFE,::::007RFE3gLFC7FFE,007FFC001LF00MF8707KFC00LFE00FFE,007FFC001KFE007LF0707KF800LFC00FFE,007FFC001KFE003LF0707KF8007KFC007FE,007FFE003KFC083LF0707KF8007KF8107FE,007IFC1LFC183LF0707KF8307KF8187FE,007IFC1LFC183LF0707KF8307KF81CFFE,007IFC1LFC1C1LF0707KF8107KFC07FFE,007IFC1LFC1C1LF0707KF8007KFC01FFE,007IFC1LFC1C1LF0707KF800LFE00FFE,007IFC1LFC1C1LF0707KF8007LF807FE,007IFC1LFC181LF0707KF8007LFE07FE,007IFC1LFC183LF0707KF8307KF8303FE,007IFC1LFC183LF0307KF8387KF8303FE,007IFC1LFC083LF8007KF8387KF8007FE,007IFC1LFE003LF800LF8387KF8007FE,007IFC1MF007LFC00LF8383KFC00FFE,007IFE1MF80MFE03LFC387KFE01FFE,007hJFE,::::::00hKFE,007hJFC,,::::^FS^CF0,15^FO280,30^FDVoucher No^FS^CF0,15^FO280,60^FD\(self.printList[i].voucher ?? "")^FS^CF0,15^FO280,90^FDPrint Date : ^FS^CF0,15^FO360,90^FD\(self.printList[i].date ?? "")^FS^FO10,150^GB200,100,0^FS^CF0,25^FO20,170^FDTour^FS^FO210,150^GB340,100,0^FS^FO 220, 170 ^A 0, 20 ^FD\(self.printList[i].tourName ?? "")^FS^FO10,250^GB200,60,0^FS^CF0,25^FO20,270^FDPax Info^FS^FO210,250^GB340,60,0^FS^FO220, 270 ^A 0, 20 ^FD\(self.printList[i].paxInfo ?? "")^FS^FO10,310^GB200,60,0^FS^CF0,25^FO20,330^FDDate^FS^FO210,310^GB340,60,0^FS^FO 220, 330 ^A 0, 20 ^FD\(self.printList[i].tourDate ?? "")^FS^FO10,370^GB200,60,0^FS^CF0,25^FO20,390^FDConcept^FS^FO210,370^GB340,60,0^FS^FO 220, 390 ^A 0, 20 ^FDStandart^FS^FO10,430^GB200,60,0^FS^CF0,25^FO20,450^FDTransfer^FS^FO210,430^GB340,60,0^FS^FO 220, 450 ^A 0, 20 ^FD\(self.printList[i].transTourist ?? "")^FS^FO10,490^GB200,100,0^FS^CF0,25^FO20,510^FDHotel^FS^FO210,490^GB340,100,0^FS^FO 220, 510 ^A 0, 20 ^FD\(hotelNameFirstColumn)^FS^FO 220, 550 ^A 0, 20 ^FD\(hotelNameScondColumn)^FS^FO10,590^GB200,60,0^FS^CF0,25^FO20,610^FDRoom^FS^FO210,590^GB340,60,0^FS^FO 220, 610 ^A 0, 20 ^FD\(self.printList[i].room ?? "")^FS^FO10,650^GB200,60,0^FS^CF0,25^FO20,670^FDPick Up^FS^FO210,650^GB340,60,0^FS^FO 220, 670 ^A 0, 20 ^FD00:00:00^FS^FO10,710^GB200,60,0^FS^CF0,25^FO20,730^FDPick Up Point^FS^FO210,710^GB340,60,0^FS^FO 220, 730 ^A 0, 20 ^FD-^FS^FO10,770^GB200,60,0^FS^CF0,25^FO20,790^FDName^FS^FO210,770^GB340,60,0^FS^FO 220, 790 ^A 0, 20 ^FD\(self.printList[i].paxName ?? "")^FS^FO10,830^GB200,60,0^FS^CF0,25^FO20,850^FDOperator^FS^FO210,830^GB340,60,0^FS^FO 220, 850 ^A 0, 20 ^FD\(self.printList[i].operatorName ?? "")^FS^FO10,890^GB200,60,0^FS^CF0,25^FO20,910^FDRes No^FS^FO210,890^GB340,60,0^FS^FO 220, 910 ^A 0, 20 ^FD\(self.printList[i].resNo ?? "")^FS^CF0,25^FO20,980^FDNet Total^FS^CF0,25^FO150,980^FD\(self.printList[i].netTotal ?? "")^FS^CF0,25^FO20,1020^FDDiscount^FS^CF0,25^FO150,1020^FD\(self.printList[i].discount ?? "")^FS^CF0,25^FO20,1080^FDPayment Detail^FS^FO10,1110^GB200,60,0^FS^CF0,25^FO20,1130^FDCASH^FS^FO210,1110^GB340,60,0^FS^FO 220, 1130 ^A 0, 20 ^FD\(self.printList[i].cash ?? "")^FS^FO10,1170^GB540,100,0^FS^FO 20, 1190 ^A 0, 20 ^FDPrivate Transfer^FS^FO 20, 1290 ^A 0, 20 ^FDYour Info Guide Number:^FS^FO 20, 1330 ^A 0, 20 ^FD+900552323232^FS^FO20,1370^BY2^BCN,120,Y,N,N^FD\(self.printList[i].voucher ?? "")^FS^CF0,40^FO20,1530^FDNotes^FS^XZ"
              //  self.printListStringType.append(printString)
                sendStrToPrinter(self.printString, connection: connection)
            }
        }
    }
}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
