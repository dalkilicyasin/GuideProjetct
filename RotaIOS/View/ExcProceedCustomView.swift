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
        
        // Exchange Menu
        let exchangeRequestModel = GetExhangeRatesRequestModel.init(date: "12-21-2021") // burda aynı günün değeri alınmalı fakat özgeyle konuş aynı gün değer dönmüyor
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint: .GetExhangeRates, method: .get, parameters: exchangeRequestModel.requestPathString()) { ( response : [GetExhangeRatesResponseModel]) in
            if response.count > 0 {
                self.exchangeList = response
                
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
            self.tempTouristMenu.append(listofArray.text ?? "")
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
        
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetCurrencySelectList, method: .get, parameters: "") { (response : [GetCurrencyResponeModel] ) in
            if response.count > 0 {
                self.currencyList = response
                
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
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappedItem))
        gesture.numberOfTouchesRequired = 1
        self.viewCurrencyType.addGestureRecognizer(gesture)
        
        self.currencyMenu.selectionAction = { index, title in
            self.viewCurrencyType.mainLabel.text = title
            self.selectedCurrencyType = title
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
            self.discount = discount
        }
        self.viewDicountCalculate.mainText.text = String(self.discount)
    }
    
    @IBAction func addPaymentButtonTapped(_ sender: Any) {
        
        if self.selectedTouristName != "" && self.selectedPaymentType != "" && self.selectedCurrencyType != "" {
            self.paymentTypeList.append(PaymentType(paymentype: self.selectedPaymentType, paymentAmount: Double(self.viewAmount.mainText.text ?? "") ?? 0.00))
            self.tableView.reloadData()
            
            if let total = Double(self.viewAmount.mainText.text ?? ""){
                self.savedTotalAmount = total
            }
            self.viewPaid.mainText.text = String(self.savedTotalAmount)
            
            if self.savedTotalAmount < 0 {
                self.savedTotalAmount = -self.savedTotalAmount
            }
            self.balanceAmount = self.totalAmount - self.savedTotalAmount - self.discount
            self.totalAmount = self.balanceAmount
            if self.balanceAmount < 0 {
                self.balanceAmount = 0.00
            }
            self.viewBalanced.mainText.text = String(self.balanceAmount)
        }else {
            let alert = UIAlertController.init(title: "Error", message: "Please Insert CurrencyType, Pax and PaymentType", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let topVC = UIApplication.getTopViewController() {
                topVC.present(alert, animated: true, completion: nil)
            }
        }
        self.payments.append(Payment(ByDesc:"aaa",ById:"0",ConvertedCurrency:"USD",ConvertedPaymentAmount:73,Currency:"USD",CurrencyId:"147",PaymentAmount:73,PaymentType:"CASH",TargetAmount:0,TypeId:"CASH"))
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
        let multisale = Multisale.init(CouponAmount:0,CouponId:0,CurrencyId:147,GuideId:205,HotelId:1423,ID:0,IsMobile:1,IsOfficeSale:false,ManualDiscount:0,MarketId:2,Note: "",PaidAmount:73,PromotionId:13,SaleDate:"12-31-2021",TotalAmount:86)
        var paxTourList : [PaxTourList] = []
        var paxes : [Paxes] = []
        var tourList : [TourList] = []
        let extras : [Extras] = []
        let transfers : [Transfers] = []
        if self.tourList.count > 0 {
            for i in 0...self.tourList.count - 1{
                for index in 0...self.touristList.count - 1 {
                    let paxesTour = PaxTourList(AgeGroup:self.touristList[index].ageGroup ?? "", Gender:self.touristList[index].gender ?? "",ID:String(self.tourList[i].iD ?? 0), PlanId:self.tourList[i].planId ?? 0)
                    paxTourList.append(paxesTour)
                }
            }
        }
        
        for i in 0...self.tourList.count - 1 {
            tourList.append(TourList(id: 2,AdultAmount:20,AdultCount:2,AdultPrice:2,ChildAmount:2,ChildCount:2,ChildPrice:2,InfantAmount:2, InfantCount:2,InfantPrice:2,ToodleAmount:2,ToodleCount:2,ToodlePrice:2,MatchId:2,MarketId:2,PromotionId:2,PoolType:2,PriceId:2,PlanId:2,TourType:2,TourName:"12421",TourId:2,Currency:2,CurrencyDesc:"1242",TourDateStr:"1414",TourDateShort:"214214",AllotmenStatus:2,RemainingAllotment:0,PriceType:2,MinPax:0.00,TotalPrice:0.00,FlatPrice:0.00,MinPrice:0.00,InfantAge1:0.00,InfantAge2:0.00,ToodleAge1:0.00,ToodleAge2:0.00,ChildAge1:0.00,ChildAge2:0.00,PickUpTime:"2142",DetractAdult:false,DetractChild:false,DetractKid:false,DetractInfant:false,AskSell:false,MeetingPointId:2,Paref:2,TourCode:"141",ID:0, CREATEDDATE:"0001-01-01T00:00:00",RefundCondition:"",TicketCount:2,TourAmount:2,VoucherNo:"367821-00005",ExtraTourist:extras,TransferTourist:transfers))
        }
        
        paxes = userDefaultsData.getTouristDetailInfoList() ?? paxes
        
    let tourSalePost = TourSalePost(Multisale:multisale,PaxTourLists:paxTourList,Payments:self.payments,Paxes:paxes,isOffline:"0",AllowDublicatePax:"0",TourList:tourList )
        
        self.data = "\(tourSalePost.toJSONString(prettyPrint: true) ?? "")"
        print(data)
        
        let toursaleRequestModel = GetSaveMobileSaleRequestModel.init(data: self.data)
        
        NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetSaveMobileSale, requestModel: toursaleRequestModel ) { (response: GetSaveMobileSaleResponseModel) in
            
            if response.Message != "" {
                print(response)
            }else {
                
            }
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
            self.paymentTypeList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            print(self.paymentTypeList)
        }
    }
}

