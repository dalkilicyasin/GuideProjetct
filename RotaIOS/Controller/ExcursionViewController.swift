//
//  ExcursionViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 17.11.2021.
//

import UIKit
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class ExcursionViewController: UIViewController {
    @IBOutlet var viewExcursionView: ExcursionView!
    @IBOutlet weak var viewAppointMentBarCutomView: AppointmentBarCustomView!
    @IBOutlet weak var viewFooterViewCustomView: FooterCustomView!
    var viewExcSearchCustomView : ExcSearchCustomView?
    var viewExcSelectCustomView : ExcSelectCustomView?
    var viewExcAddCustomView : ExcAddCustomView?
    var viewExcProceedCustomView : ExcProceedCustomView?
    var beginDateStringType = ""
    var endDateStringType = ""
    var tourList : [GetSearchTourResponseModel] = []
    var oflineDataTourList : [GetSearchTourResponseModel] = []
    var lastUIView = UIView()
    var isConnectedInternet : Bool?
    var isHotelorMarketChanged = false
    var viewPaxCustomView : ExcPaxCustomView?
    var paxesList : [GetInHoseListResponseModel] = []
    var extrasListInVC : [Extras] = []
    var transfersListInVC : [Transfers] = []
    var constraintOnSelect = [NSLayoutConstraint]()
    var constraintOnPax = [NSLayoutConstraint]()
    var constraintonAdd = [NSLayoutConstraint]()
    var changeNumber = 0
    var isTourChange = false
    var totalExtrasAmount = 0
    var totalTransfersAmount = 0
    var changeTransferNumber = 0
    var changeExcNumber = 0
    var isExcOrTransChange = false
    var tourListSaved : [GetSearchTourResponseModel] = []
    var paxesListSaved : [GetInHoseListResponseModel] = []
    var ageGroup = ""
    var totalPrice = 0.00
    var minPerson = 0
    var minPriceTotal = 0.00
    var extraAndTransTotalPrice = 0.00
    var maxVoucherNo = ""
    var createVoucher = ""
    var counter = 0
    var addedVoucher = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        userDefaultsData.saveTourList(tour: [])
        userDefaultsData.savePaxesList(tour: [])
        self.viewAppointMentBarCutomView.homePageTappedDelegate = self
        self.viewFooterViewCustomView.continueButtonTappedDelegate = self
        self.viewFooterViewCustomView.saveButtonTappedDelegate = self
        UIView.animate(withDuration: 0, animations: { [self] in
            self.viewExcSearchCustomView = ExcSearchCustomView()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = false
            self.viewExcursionView.viewContentView.addSubview(viewExcSearchCustomView!)
            self.viewExcSearchCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
        }, completion: { (finished) in
            if finished{
            }
        })
        self.lastUIView = self.viewExcSearchCustomView!
        
        self.viewFooterViewCustomView.buttonGetOfflineData.isEnabled = true
        let getOfflineDataGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOfflinedataButton))
        self.viewFooterViewCustomView.buttonGetOfflineData.isUserInteractionEnabled = true
        self.viewFooterViewCustomView.buttonGetOfflineData.addGestureRecognizer(getOfflineDataGesture)
        
        // self.constraintOnSelectfunc()
        // self.constraintOnPaxFunc()
        
        if Connectivity.isConnectedToInternet {
            print("Connected")
            self.isConnectedInternet = true
        } else {
            print("No Internet")
            self.isConnectedInternet = false
        }
    }
    
    @objc func viewSendTapped() {
        print("tapped")
    }
    
    func showToast(message : String){
        let toastLabel = UILabel(frame: CGRect(x: self.viewExcursionView.frame.size.width/2 - 50, y: self.viewExcursionView.frame.size.height - 200, width: 250, height: 55))
        toastLabel.numberOfLines = 0
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.sizeToFit()
        toastLabel.frame = CGRect( x: toastLabel.frame.minX, y: toastLabel.frame.minY, width:toastLabel.frame.width + 20, height: toastLabel.frame.height + 8)
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func constraintOnSelectfunc(){
        self.viewFooterViewCustomView.viewHeader.addSubview( self.viewFooterViewCustomView.buttonView)
        self.viewFooterViewCustomView.buttonView.translatesAutoresizingMaskIntoConstraints = false
        self.constraintOnSelect.append(self.viewFooterViewCustomView.buttonView.leadingAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.leadingAnchor, constant: 40))
        self.constraintOnSelect.append(self.viewFooterViewCustomView.buttonView.topAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.topAnchor, constant: 20))
        self.constraintOnSelect.append(self.viewFooterViewCustomView.buttonView.trailingAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.trailingAnchor, constant: -40))
        self.constraintOnSelect.append(self.viewFooterViewCustomView.buttonView.bottomAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.bottomAnchor, constant: -80))
        self.viewFooterViewCustomView.buttonView.setTitle("CONTINUE", for: .normal)
        NSLayoutConstraint.activate( self.constraintOnSelect)
    }
    
    func constraintOnPaxFunc(){
        self.viewFooterViewCustomView.viewHeader.addSubview( self.viewFooterViewCustomView.buttonView)
        self.viewFooterViewCustomView.buttonView.translatesAutoresizingMaskIntoConstraints = false
        self.constraintOnPax .append(self.viewFooterViewCustomView.buttonView.leadingAnchor.constraint(equalTo: self.viewFooterViewCustomView.buttonAddButton.trailingAnchor, constant: 15))
        self.constraintOnPax .append(self.viewFooterViewCustomView.buttonView.topAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.topAnchor, constant: 20))
        self.constraintOnPax .append(self.viewFooterViewCustomView.buttonView.trailingAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.trailingAnchor, constant: -40))
        self.constraintOnPax .append(self.viewFooterViewCustomView.buttonView.bottomAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.bottomAnchor, constant: -80))
        self.viewFooterViewCustomView.buttonView.setTitle("CONTINUE", for: .normal)
        NSLayoutConstraint.activate( self.constraintOnPax)
    }
    
    func constraintOnAddFunc(){
        self.viewFooterViewCustomView.viewHeader.addSubview( self.viewFooterViewCustomView.buttonView)
        self.viewFooterViewCustomView.buttonView.translatesAutoresizingMaskIntoConstraints = false
        self.viewFooterViewCustomView.buttonAddButton.translatesAutoresizingMaskIntoConstraints = false
        self.constraintonAdd .append(self.viewFooterViewCustomView.buttonView.leadingAnchor.constraint(equalTo: self.viewFooterViewCustomView.buttonSaveButton.trailingAnchor, constant: 15))
        self.constraintonAdd .append(self.viewFooterViewCustomView.buttonView.topAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.topAnchor, constant: 80))
        self.constraintonAdd .append(self.viewFooterViewCustomView.buttonView.widthAnchor.constraint(equalToConstant: 140))
        self.constraintonAdd .append(self.viewFooterViewCustomView.buttonView.heightAnchor.constraint(equalToConstant: 50))
        self.viewFooterViewCustomView.buttonView.setTitle("CONTINUE", for: .normal)
        NSLayoutConstraint.activate( self.constraintonAdd)
    }
    
    @objc func tappedOfflinedataButton() {
        let alert = UIAlertController.init(title: "Notice", message: "Are You Sure to Continue", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "Yes", style: UIAlertAction.Style.default, handler: { alert in
            print("yes")
            let getOfflineDataRequestModel = GetTourSearchCacheRequestModel.init(guideId: String(userDefaultsData.getGuideId()), hotelIds: self.viewExcSearchCustomView?.hotelIdStringType ?? "")
            NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint: .GetTourSearchCache, method: .get, parameters: getOfflineDataRequestModel.requestPathString()) { (response : [GetSearchTourResponseModel]) in
                if response.count > 0 {
                    userDefaultsData.saveSearchTourOffline(tour: response )
                    let alert = UIAlertController.init(title: "Success", message: "Offline data was updated", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    print("data has not recived")
                }
            }
            print("tapped")
        }))
        alert.addAction(UIAlertAction.init(title: "No", style: UIAlertAction.Style.default, handler: { alert in
            print("No")
            return
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension ExcursionViewController : HomePageTappedDelegate , ContinueButtonTappedDelegate, SaveButtonTappedDelegate {
    func totalPrice(isSaveButtonTapped: Bool?) {
        self.totalPrice += self.extraAndTransTotalPrice
    }
    
    func continueButtonTappedDelegate(tapped: Int) {
        self.viewFooterViewCustomView.viewSendVoucher.isHidden = true
        if self.changeNumber != userDefaultsData.getTourList()?.count {
            self.isTourChange = true
            self.changeNumber = userDefaultsData.getTourList()?.count ?? 0
        }else{
            self.isTourChange = false
        }
        
        self.viewPaxCustomView?.isHidden = true
        if Connectivity.isConnectedToInternet {
            print("Connected")
            self.isConnectedInternet = true
        } else {
            print("No Internet")
            self.isConnectedInternet = false
        }
        self.viewAppointMentBarCutomView.collectionView(viewAppointMentBarCutomView.collectionView, didSelectItemAt: IndexPath.init(item: tapped, section: 0))
        self.viewFooterViewCustomView.counter = tapped
        if tapped == 0 {
            self.viewFooterViewCustomView.commonInit()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = false
            self.viewFooterViewCustomView.printButton.isHidden = true
            
            //  self.viewFooterViewCustomView.buttonHiding(hidePrintbutton: true, hideButton: false)
            if self.viewExcSearchCustomView == nil {
                
                // self.lastUIView.removeFromSuperview()
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                // self.stepsPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
                self.animatedCustomView(customView: ExcSearchCustomView())
            }else {
                self.viewExcSearchCustomView?.isHidden = false
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.stepsPageCustomView?.isHidden = true
                //self.proceedPageCustomView?.isHidden = true
            }
        }else if tapped == 1 {
            self.constraintOnSelectfunc()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
            self.viewFooterViewCustomView.printButton.isHidden = true
            let getTourSearchRequestModel = GetTourSearchRequestModel.init(guide: String(userDefaultsData.getGuideId()), market: self.viewExcSearchCustomView?.marketIdStringType ?? "", hotel: self.viewExcSearchCustomView?.hotelIdStringType ?? "", area: self.viewExcSearchCustomView?.areaIdStringType ?? "", tourdatestart: self.viewExcSearchCustomView?.beginDateString ??  "", tourdateend: self.viewExcSearchCustomView?.endDateString ?? "", saledate: userDefaultsData.getSaleDate())
            
            let getInHouseListRequestModel = GetInHouseListRequestModel(hotelId: String(userDefaultsData.getHotelId()), marketId: String(userDefaultsData.getMarketId()))
            
            if  self.isConnectedInternet == true {
                NetworkManager.sendRequestArray(url: NetworkManager.BASEURL, endPoint: .GetTourSaleSearchTour, requestModel: getTourSearchRequestModel) { (response : [GetSearchTourResponseModel]) in
                    if response.count > 0 {
                        self.tourList = response
                        print(self.tourList[0])
                        
                        self.viewExcSelectCustomView?.excursionList = self.tourList
                        for index in 0...self.tourList.count - 1 {
                            self.viewExcSelectCustomView?.excursionList[index].isTapped = false
                            self.viewExcSelectCustomView?.checkList.append(self.viewExcSelectCustomView?.excursionList[index].isTapped ?? false)
                        }
                        self.viewExcSelectCustomView?.tableView.reloadData()
                    }else{
                        let alert = UIAlertController.init(title: "Error", message: "Tour Data has not Recived", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetInHouseList, method: .get, parameters: getInHouseListRequestModel.requestPathString()) { (response : [GetInHoseListResponseModel] ) in
                    if response.count > 0 {
                        //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                        self.paxesList = response
                        /* userDefaultsData.saveHotelId(hotelId: 0)
                         userDefaultsData.saveMarketId(marketId: 0)*/
                    }else{
                        print("data has not recived")
                    }
                }
            }else{
            }
            // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.viewExcSearchCustomView?.excurSearchDelegate = self
            if self.viewExcSelectCustomView == nil || self.isHotelorMarketChanged == true{
                userDefaultsData.saveTourList(tour: [])
                userDefaultsData.savePaxesList(tour: [])
                //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
                // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcSelectCustomView = ExcSelectCustomView()
                    self.viewExcSelectCustomView?.excSelectDelegate = self
                    
                    self.viewExcursionView.viewContentView.addSubview(viewExcSelectCustomView!)
                    self.viewExcSelectCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
                // self.lastUIView = self.paxPageCustomView!
                self.isHotelorMarketChanged = false
            }else {
                self.viewExcSelectCustomView?.isHidden = false
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
        }else if tapped == 2 {
            self.viewFooterViewCustomView.printButton.isHidden = true
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
            self.viewFooterViewCustomView.labelAmount.isHidden = false
            self.viewFooterViewCustomView.buttonSaveButton.isHidden = false
            self.viewFooterViewCustomView.buttonAddButton.isHidden = true
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnAddFunc()
            
            self.viewExcSelectCustomView?.excSelectDelegate = self
            if self.viewExcAddCustomView == nil || self.isTourChange == true{
                //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
                // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcAddCustomView = ExcAddCustomView()
                    self.viewExcAddCustomView?.excAddCustomViewDelegate = self
                    //self.viewExcSelectCustomView?.excSelectDelegate = self
                    // self.viewExcAddCustomView?.extrasList = self.tourList
                    //  self.viewExcAddCustomView?.tableView.reloadData()
                    self.viewExcursionView.viewContentView.addSubview(viewExcAddCustomView!)
                    self.viewExcAddCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
                // self.lastUIView = self.paxPageCustomView!
                self.isHotelorMarketChanged = false
            }else {
                self.viewExcAddCustomView?.isHidden = false
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
            self.tourListSaved = userDefaultsData.getTourList() ?? self.tourListSaved
            self.paxesListSaved = userDefaultsData.getPaxesList() ?? self.paxesListSaved
            self.totalPrice = 0.00
            if self.tourListSaved.count > 0 &&  self.paxesListSaved.count > 0 {
                for i in 0...self.tourListSaved.count - 1{
                    // Per Person Price calculation
                    if self.tourListSaved[i].priceType == 35 {
                        // Özgeye sor getinforesponse mu yoksa direk gethouselisten dönen agegrup mu alınacak
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
                        for index in 0...paxesListSaved.count - 1 {
                            switch self.paxesListSaved[index].ageGroup {
                            case "INF":
                                self.totalPrice += self.tourListSaved[i].infantPrice ?? 0.00
                            case "TDL":
                                self.totalPrice += self.tourListSaved[i].toodlePrice ?? 0.00
                            case "CHD":
                                self.totalPrice += self.tourListSaved[i].childPrice ?? 0.00
                            default:
                                self.totalPrice += self.tourListSaved[i].adultPrice ?? 0.00
                            }
                        }
                    }
                    
                    //Flat Price calculation
                    else if self.tourListSaved[i].priceType == 36{
                        self.totalPrice += self.tourListSaved[i].flatPrice ?? 0.00
                    }
                    
                    //Min Price
                    else if self.tourListSaved[i].priceType == 37{
                        self.minPerson = Int(self.tourListSaved[i].minPax ?? 0.00)
                        if self.minPerson > 0 {
                            for index in 0...self.paxesListSaved.count - 1{
                                if  self.paxesListSaved[index].ageGroup == "ADL" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "CHD" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "TDL" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "INF" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }
                            }
                        }else {
                            for index in 0...self.paxesListSaved.count - 1{
                                if  self.paxesListSaved[index].ageGroup == "ADL" {
                                    self.totalPrice += tourListSaved[i].adultPrice ?? 0.00
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "CHD" {
                                    self.totalPrice += tourListSaved[i].childPrice ?? 0.00
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "TDL" {
                                    self.totalPrice += tourListSaved[i].toodlePrice ?? 0.00
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "INF" {
                                    self.totalPrice += tourListSaved[i].infantPrice ?? 0.00
                                }
                            }
                        }
                        self.totalPrice += self.minPriceTotal
                        self.tourListSaved.removeAll()
                        self.paxesListSaved.removeAll()
                    }
                }
            }
            self.showToast(message: "\(self.totalPrice)")
        }else if tapped == 3 {
            self.viewFooterViewCustomView.viewSendVoucher.isHidden = false
            let gesture = UITapGestureRecognizer(target: self, action: #selector(viewSendTapped))
            self.viewFooterViewCustomView.viewSendVoucher.isUserInteractionEnabled = true
            self.viewFooterViewCustomView.viewSendVoucher.addGestureRecognizer(gesture)
            
            //Max Voucher
            
            // Create VOucher
            var shortyear = ""
            let year =  Calendar.current.component(.year, from: Date())
            shortyear = String(year)
            shortyear = shortyear.replacingOccurrences(of: "20", with: "", options: String.CompareOptions.literal, range: nil)
            print(shortyear)
            let month = Calendar.current.component(.month, from: Date())
            let day = Calendar.current.component(.day, from: Date())
            let hour = Calendar.current.component(.hour, from: Date())
            let minute = Calendar.current.component(.minute, from: Date())
            
            let mergeDate = String(format: "%02d%02d%02d%02d", month, day, hour, minute)
            print(mergeDate)
            
            let getMaxVoucherRequestModel = GetMaxGuideVoucherNumberRequestModel(guideId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
         
                NetworkManager.sendGetRequestInt(url: NetworkManager.BASEURL, endPoint: .GetMaxGuideVoucherNumber, method: .get, parameters: getMaxVoucherRequestModel.requestPathString()) { (response : Int) in
                    if response != 0 {
                        self.counter = 0
                        print(response)
                        self.maxVoucherNo = String(response)
                        let startIndex = self.maxVoucherNo.index(self.maxVoucherNo.startIndex, offsetBy: 3)
                        let endIndex = self.maxVoucherNo.index(self.maxVoucherNo.startIndex, offsetBy: 4)
                        self.maxVoucherNo = String(self.maxVoucherNo[startIndex...endIndex])
                        print(self.maxVoucherNo)
                        if let maxVoucherInt = Int(self.maxVoucherNo) {
                            print(maxVoucherInt)
                            self.counter = maxVoucherInt
                            self.counter += 1
                        }
                        self.addedVoucher = String(format: "%02d", self.counter)
                        if userDefaultsData.getDay() != day {
                            self.createVoucher = "\(userDefaultsData.geUserNAme() ?? "")\(shortyear)\(month)\(day)\(hour)\(minute)\(self.addedVoucher)"
                            userDefaultsData.saveDay(day: day)
                        }else if userDefaultsData.getDay() == day {
                            self.counter = 1
                            self.createVoucher = "\(userDefaultsData.geUserNAme() ?? "")\(shortyear)\(mergeDate)\(self.addedVoucher)"
                            userDefaultsData.saveDay(day: day)
                        }
                        print(self.createVoucher)
                        self.viewExcProceedCustomView?.voucherNo = self.createVoucher
                        userDefaultsData.saveMaxVoucher(voucher: self.createVoucher)
                       
                    }else {
                        print("error")
                    }
                }
            
            ///
            self.viewFooterViewCustomView.labelAmount.isHidden = true
            self.viewFooterViewCustomView.buttonSaveButton.isHidden = true
            self.viewFooterViewCustomView.buttonView.isHidden = true
            self.viewFooterViewCustomView.printButton.isHidden = false
            if let transferNumber = userDefaultsData.getTransfersList()?.count {
                if  self.changeTransferNumber != transferNumber {
                    self.isExcOrTransChange = true
                    self.changeTransferNumber = transferNumber
                }else{
                    self.isExcOrTransChange = false
                }
            }
            
            if let extraNumber = userDefaultsData.getTransfersList()?.count {
                if  self.changeExcNumber != extraNumber {
                    self.isExcOrTransChange = true
                    self.changeExcNumber = extraNumber
                }else{
                    self.isExcOrTransChange = false
                }
            }
            if self.isExcOrTransChange == true || self.viewExcProceedCustomView == nil {
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcSearchCustomView?.isHidden = true
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcProceedCustomView = ExcProceedCustomView()
                    self.viewExcProceedCustomView?.viewAmount.mainText.text = String(self.totalPrice)
                    self.viewExcProceedCustomView?.viewBalanced.mainText.text = String(self.totalPrice)
                    self.viewExcProceedCustomView?.balanceAmount = Double(self.totalPrice)
                    self.viewExcProceedCustomView?.viewTotalAmount.mainText.text = String(self.totalPrice)
                    self.viewExcProceedCustomView?.voucherNo = self.createVoucher
                    self.viewExcProceedCustomView?.totalAmount = self.totalPrice
                    self.viewExcursionView.viewContentView.addSubview(viewExcProceedCustomView!)
                    self.viewExcProceedCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }else{
                self.viewExcProceedCustomView?.isHidden = false
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcSearchCustomView?.isHidden = true
            }
        }
        else{
            
            print("default")
        }
    }
    
    func homePageTapped(ischosen: Int) {
        self.viewFooterViewCustomView.viewSendVoucher.isHidden = true
        if self.changeNumber != userDefaultsData.getTourList()?.count {
            self.isTourChange = true
            self.changeNumber = userDefaultsData.getTourList()?.count ?? 0
        }else{
            self.isTourChange = false
        }
        
        self.viewPaxCustomView?.isHidden = true
        if Connectivity.isConnectedToInternet {
            print("Connected")
            self.isConnectedInternet = true
        } else {
            print("No Internet")
            self.isConnectedInternet = false
        }
        
        if self.viewFooterViewCustomView.counter == ischosen {
            return
        }
        self.viewFooterViewCustomView.counter = ischosen
        
        if ischosen == 0 {
            self.buttonhide()
            self.viewFooterViewCustomView.commonInit()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = false
            self.viewFooterViewCustomView.printButton.isHidden = true
            //  self.viewFooterViewCustomView.buttonHiding(hidePrintbutton: true, hideButton: false)
            if self.viewExcSearchCustomView == nil {
                // self.lastUIView.removeFromSuperview()
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.stepsPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
                self.animatedCustomView(customView: ExcSearchCustomView())
            }else {
                self.viewExcSearchCustomView?.isHidden = false
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.stepsPageCustomView?.isHidden = true
                //self.proceedPageCustomView?.isHidden = true
            }
            
        }
        else if ischosen == 1 {
            self.buttonhide()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
            self.constraintOnSelectfunc()
            let getTourSearchRequestModel = GetTourSearchRequestModel.init(guide: String(userDefaultsData.getGuideId()), market: self.viewExcSearchCustomView?.marketIdStringType ?? "", hotel: self.viewExcSearchCustomView?.hotelIdStringType ?? "", area: self.viewExcSearchCustomView?.areaIdStringType ?? "", tourdatestart: self.viewExcSearchCustomView?.beginDateString ??  "", tourdateend: self.viewExcSearchCustomView?.endDateString ?? "", saledate: userDefaultsData.getSaleDate())
            
            let getInHouseListRequestModel = GetInHouseListRequestModel(hotelId: String(userDefaultsData.getHotelId()), marketId: String(userDefaultsData.getMarketId()))
            
            if  self.isConnectedInternet == true {
                NetworkManager.sendRequestArray(url: NetworkManager.BASEURL, endPoint: .GetTourSaleSearchTour, requestModel: getTourSearchRequestModel) { (response : [GetSearchTourResponseModel]) in
                    if response.count > 0 {
                        self.tourList = response
                        print(self.tourList[0])
                        self.viewExcSelectCustomView?.excursionList = self.tourList
                        for index in 0...self.tourList.count - 1 {
                            self.viewExcSelectCustomView?.excursionList[index].isTapped = false
                            self.viewExcSelectCustomView?.checkList.append(self.viewExcSelectCustomView?.excursionList[index].isTapped ?? false)
                        }
                        self.viewExcSelectCustomView?.tableView.reloadData()
                    }else{
                        let alert = UIAlertController.init(title: "Error", message: "Tour Data has not Recived", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetInHouseList, method: .get, parameters: getInHouseListRequestModel.requestPathString()) { (response : [GetInHoseListResponseModel] ) in
                    if response.count > 0 {
                        //   let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                        self.paxesList = response
                        
                        /* userDefaultsData.saveHotelId(hotelId: 0)
                         userDefaultsData.saveMarketId(marketId: 0)*/
                    }else{
                        print("data has not recived")
                    }
                }
            }else{
            }
            // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.viewExcSearchCustomView?.excurSearchDelegate = self
            if self.viewExcSelectCustomView == nil || self.isHotelorMarketChanged == true{
                userDefaultsData.saveTourList(tour: [])
                userDefaultsData.savePaxesList(tour: [])
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
                // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcSelectCustomView = ExcSelectCustomView()
                    self.viewExcSelectCustomView?.excSelectDelegate = self
                    self.viewExcursionView.viewContentView.addSubview(viewExcSelectCustomView!)
                    self.viewExcSelectCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
                // self.lastUIView = self.paxPageCustomView!
                self.isHotelorMarketChanged = false
            }else {
                self.viewExcSelectCustomView?.isHidden = false
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
            
        }else if ischosen == 2 {
            self.viewFooterViewCustomView.printButton.isHidden = true
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
            self.viewFooterViewCustomView.labelAmount.isHidden = false
            self.viewFooterViewCustomView.buttonSaveButton.isHidden = false
            self.viewFooterViewCustomView.buttonAddButton.isHidden = true
            self.viewFooterViewCustomView.buttonView.isHidden = false
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnAddFunc()
            self.viewExcSelectCustomView?.excSelectDelegate = self
            if self.viewExcAddCustomView == nil || self.isTourChange == true{
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcAddCustomView = ExcAddCustomView()
                    self.viewExcAddCustomView?.excAddCustomViewDelegate = self
                    // self.viewExcAddCustomView?.extrasList = self.tourList
                    //  self.viewExcAddCustomView?.tableView.reloadData()
                    self.viewExcursionView.viewContentView.addSubview(viewExcAddCustomView!)
                    self.viewExcAddCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
                // self.lastUIView = self.paxPageCustomView!
                self.isHotelorMarketChanged = false
            }else {
                self.viewExcAddCustomView?.isHidden = false
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcProceedCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
            
            //total amount counting
            self.tourListSaved = userDefaultsData.getTourList() ?? self.tourListSaved
            self.paxesListSaved = userDefaultsData.getPaxesList() ?? self.paxesListSaved
            self.totalPrice = 0.00
            if self.tourListSaved.count > 0 &&  self.paxesListSaved.count > 0 {
                for i in 0...self.tourListSaved.count - 1{
                    // Per Person Price calculation
                    if self.tourListSaved[i].priceType == 35 {
                        // Özgeye sor getinforesponse mu yoksa direk gethouselisten dönen agegrup mu alınacak
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
                        for index in 0...paxesListSaved.count - 1 {
                            switch self.paxesListSaved[index].ageGroup {
                            case "INF":
                                self.totalPrice += self.tourListSaved[i].infantPrice ?? 0.00
                            case "TDL":
                                self.totalPrice += self.tourListSaved[i].toodlePrice ?? 0.00
                            case "CHD":
                                self.totalPrice += self.tourListSaved[i].childPrice ?? 0.00
                            default:
                                self.totalPrice += self.tourListSaved[i].adultPrice ?? 0.00
                            }
                        }
                    }
                    //Flat Price calculation
                    else if self.tourListSaved[i].priceType == 36{
                        self.totalPrice += self.tourListSaved[i].flatPrice ?? 0.00
                    }
                    
                    else if self.tourListSaved[i].priceType == 37{
                        self.minPerson = Int(self.tourListSaved[i].minPax ?? 0.00)
                        if self.minPerson > 0 {
                            for index in 0...self.paxesListSaved.count - 1{
                                if  self.paxesListSaved[index].ageGroup == "ADL" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "CHD" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "TDL" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "INF" {
                                    self.minPriceTotal = self.tourListSaved[i].minPrice ?? 0.00
                                    self.minPerson -= 1
                                }
                            }
                        }else {
                            for index in 0...self.paxesListSaved.count - 1{
                                if  self.paxesListSaved[index].ageGroup == "ADL" {
                                    self.totalPrice += tourListSaved[i].adultPrice ?? 0.00
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "CHD" {
                                    self.totalPrice += tourListSaved[i].childPrice ?? 0.00
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "TDL" {
                                    self.totalPrice += tourListSaved[i].toodlePrice ?? 0.00
                                }else if self.minPerson > 0 && self.paxesListSaved[index].ageGroup == "INF" {
                                    self.totalPrice += tourListSaved[i].infantPrice ?? 0.00
                                }
                            }
                        }
                        self.totalPrice += self.minPriceTotal
                        self.tourListSaved.removeAll()
                        self.paxesListSaved.removeAll()
                    }
                }
            }
            self.showToast(message: "\(self.totalPrice)")
            
        }else if ischosen == 3 {
            self.viewFooterViewCustomView.viewSendVoucher.isHidden = false
            let gesture = UITapGestureRecognizer(target: self, action: #selector(viewSendTapped))
            self.viewFooterViewCustomView.viewSendVoucher.isUserInteractionEnabled = true
            self.viewFooterViewCustomView.viewSendVoucher.addGestureRecognizer(gesture)
            
            // Create VOucher
            var shortyear = ""
            let year =  Calendar.current.component(.year, from: Date())
            shortyear = String(year)
            shortyear = shortyear.replacingOccurrences(of: "20", with: "", options: String.CompareOptions.literal, range: nil)
            print(shortyear)
            let month = Calendar.current.component(.month, from: Date())
            let day = Calendar.current.component(.day, from: Date())
            let hour = Calendar.current.component(.hour, from: Date())
            let minute = Calendar.current.component(.minute, from: Date())
            
            let mergeDate = String(format: "%02d%02d%02d%02d", month, day, hour, minute)
            print(mergeDate)
            
            let getMaxVoucherRequestModel = GetMaxGuideVoucherNumberRequestModel(guideId: userDefaultsData.getGuideId(), saleDate: userDefaultsData.getSaleDate())
         
                NetworkManager.sendGetRequestInt(url: NetworkManager.BASEURL, endPoint: .GetMaxGuideVoucherNumber, method: .get, parameters: getMaxVoucherRequestModel.requestPathString()) { (response : Int) in
                    if response != 0 {
                        self.counter = 0
                        print(response)
                        self.maxVoucherNo = String(response)
                        let startIndex = self.maxVoucherNo.index(self.maxVoucherNo.startIndex, offsetBy: 3)
                        let endIndex = self.maxVoucherNo.index(self.maxVoucherNo.startIndex, offsetBy: 4)
                        self.maxVoucherNo = String(self.maxVoucherNo[startIndex...endIndex])
                        print(self.maxVoucherNo)
                        if let maxVoucherInt = Int(self.maxVoucherNo) {
                            print(maxVoucherInt)
                            self.counter = maxVoucherInt
                            self.counter += 1
                        }
                        self.addedVoucher = String(format: "%02d", self.counter)
                        if userDefaultsData.getDay() != day {
                            self.createVoucher = "\(userDefaultsData.geUserNAme() ?? "")\(shortyear)\(month)\(day)\(hour)\(minute)\(self.addedVoucher)"
                            userDefaultsData.saveDay(day: day)
                        }else if userDefaultsData.getDay() == day {
                            self.counter = 1
                            self.createVoucher = "\(userDefaultsData.geUserNAme() ?? "")\(shortyear)\(mergeDate)\(self.addedVoucher)"
                            userDefaultsData.saveDay(day: day)
                        }
                        print(self.createVoucher)
                        self.viewExcProceedCustomView?.voucherNo = self.createVoucher
                        userDefaultsData.saveMaxVoucher(voucher: self.createVoucher)
                       
                    }else {
                        print("error")
                    }
                }
            
            ///
            self.buttonhide()
            self.viewFooterViewCustomView.buttonView.isHidden = true
            self.viewFooterViewCustomView.printButton.isHidden = false
            if let transferNumber = userDefaultsData.getTransfersList()?.count {
                if  self.changeTransferNumber != transferNumber {
                    self.isExcOrTransChange = true
                    self.changeTransferNumber = transferNumber
                }else{
                    self.isExcOrTransChange = false
                }
            }
            
            if let extraNumber = userDefaultsData.getExtrasList()?.count {
                if  self.changeExcNumber != extraNumber {
                    self.isExcOrTransChange = true
                    self.changeExcNumber = extraNumber
                }else{
                    self.isExcOrTransChange = false
                }
            }
            
            if self.isExcOrTransChange == true || self.viewExcProceedCustomView == nil {
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcSearchCustomView?.isHidden = true
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcProceedCustomView = ExcProceedCustomView()
                    self.viewExcProceedCustomView?.viewAmount.mainText.text = String(self.totalPrice)
                    self.viewExcProceedCustomView?.viewBalanced.mainText.text = String(self.totalPrice)
                    self.viewExcProceedCustomView?.viewTotalAmount.mainText.text = String(self.totalPrice)
                    self.viewExcProceedCustomView?.balanceAmount = Double(self.totalPrice)
                    self.viewExcProceedCustomView?.totalAmount = self.totalPrice
                   
                    self.viewExcursionView.viewContentView.addSubview(viewExcProceedCustomView!)
                    self.viewExcProceedCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }else{
                self.viewExcProceedCustomView?.isHidden = false
                self.viewExcAddCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                self.viewExcSearchCustomView?.isHidden = true
            }
        }
        else{
            print("default")
        }
    }
    
    func animatedCustomView( customView : UIView ){
        //  self.lastUIView.removeFromSuperview()
        UIView.animate(withDuration: 0, animations: { [self] in
            // self.paxPageCustomView?.paxesListDelegate = self
            self.viewExcursionView.viewContentView.addSubview(customView)
            customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
        }, completion: { (finished) in
            if finished{
                
            }
        })
        self.lastUIView = customView
    }
    
    func buttonhide(){
        self.viewFooterViewCustomView.buttonAddButton.isHidden = true
        self.viewFooterViewCustomView.labelAmount.isHidden = true
        self.viewFooterViewCustomView.buttonSaveButton.isHidden = true
        self.viewFooterViewCustomView.printButton.isHidden = true
        self.viewFooterViewCustomView.buttonView.isHidden = false
        self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
    }
}

extension ExcursionViewController : ExcSearchDelegate {
    func hotelorMarketChange(isChange: Bool) {
        self.isHotelorMarketChanged = isChange
    }
}

extension ExcursionViewController : ExcSelectDelegate {
    func exSelectDelegateInf(paxButtonTapped: Bool?) {
        if paxButtonTapped == true {
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnPaxFunc()
            self.viewExcSelectCustomView?.isHidden = true
            self.viewFooterViewCustomView.buttonAddButton.isHidden = false
            // self.viewFooterViewCustomView.buttonView.isHidden = false
            if viewPaxCustomView == nil {
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewPaxCustomView = ExcPaxCustomView()
                    self.viewPaxCustomView?.excPaxPageDelegate = self
                    self.viewPaxCustomView?.paxesList = self.paxesList
                    if self.paxesList.count > 0 {
                        for index in 0...self.paxesList.count - 1 {
                            self.paxesList[index].isTapped = false
                            self.viewPaxCustomView?.checkList.append(self.paxesList[index].isTapped ?? false)
                        }
                    }
                    self.viewPaxCustomView?.tableView.reloadData()
                    self.viewExcursionView.viewContentView.addSubview(self.viewPaxCustomView!)
                    self.viewPaxCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.bounds.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }else{
                self.viewPaxCustomView?.isHidden = false
                self.viewExcSelectCustomView?.isHidden = true
            }
            
        }else {
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnSelectfunc()
            //self.constraintOnSelectfunc()
            self.viewPaxCustomView?.isHidden = true
            if viewExcSelectCustomView == nil {
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcSelectCustomView = ExcSelectCustomView()
                    // self.paxPageCustomView?.paxesListDelegate = self
                    self.viewExcursionView.viewContentView.addSubview(viewExcSelectCustomView!)
                    self.viewExcSelectCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }else{
                self.viewExcSelectCustomView?.isHidden = false
                self.viewPaxCustomView?.isHidden = true
            }
        }
    }
}

extension ExcursionViewController : ExcPaxPageDelegate {
    func excPaxInfo(tourButtonTapped: Bool?) {
        if tourButtonTapped == false {
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnPaxFunc()
            self.viewExcSelectCustomView?.isHidden = true
            if viewPaxCustomView == nil {
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewPaxCustomView = ExcPaxCustomView()
                    self.viewExcursionView.viewContentView.addSubview(self.viewPaxCustomView!)
                    self.viewPaxCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.bounds.size.height)
                }, completion: { (finished) in
                    if finished{
                    }
                })
            }else{
                self.viewPaxCustomView?.isHidden = false
                self.viewExcSelectCustomView?.isHidden = true
            }
        }else {
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnSelectfunc()
            // self.constraintOnSelectfunc()
            self.viewFooterViewCustomView.buttonAddButton.isHidden = true
            self.viewFooterViewCustomView.buttonView.isHidden = false
            self.viewPaxCustomView?.isHidden = true
            if viewExcSelectCustomView == nil{
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcSelectCustomView = ExcSelectCustomView()
                    self.viewExcSelectCustomView?.excSelectDelegate = self
                    self.viewExcursionView.viewContentView.addSubview(viewExcSelectCustomView!)
                    self.viewExcSelectCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
            }else{
                self.viewExcSelectCustomView?.isHidden = false
                self.viewPaxCustomView?.isHidden = true
                
            }
        }
    }
}

extension ExcursionViewController : ExcAddCustomViewDelegate {
    func excurAddCustomDelegate(changeTransferNumber: Int, changeExtraNumber: Int, extrasTotalPrice: Double, transfersTotalPrice: Double, extraButtonTapped: Bool) {
        self.changeExcNumber = changeExtraNumber
        self.changeTransferNumber = changeTransferNumber
        if extraButtonTapped == true {
            self.viewFooterViewCustomView.labelAmount.text = String(extrasTotalPrice)
        }else{
            self.viewFooterViewCustomView.labelAmount.text = String(transfersTotalPrice)
        }
        self.extraAndTransTotalPrice = extrasTotalPrice + transfersTotalPrice
        
        if  self.viewFooterViewCustomView.totalPriceIsSaved == true {
            userDefaultsData.saveTotalPrice(totalPrice: self.totalPrice)
        }else{
            userDefaultsData.saveTotalPrice(totalPrice: 0.00)
        }
    }
}




