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
    
    var totalAmount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewAppointMentBarCutomView.homePageTappedDelegate = self
        self.viewFooterViewCustomView.continueButtonTappedDelegate = self
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

extension ExcursionViewController : HomePageTappedDelegate , ContinueButtonTappedDelegate {
    func continueButtonTappedDelegate(tapped: Int) {
        if self.changeNumber != userDefaultsData.getTourList()?.count {
            self.isTourChange = true
            self.changeNumber = userDefaultsData.getTourList()?.count ?? 0
        }
        self.viewFooterViewCustomView.buttonAddButton.isHidden = true
        self.viewFooterViewCustomView.labelAmount.isHidden = true
        self.viewFooterViewCustomView.buttonSaveButton.isHidden = true
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
                // self.stepsPageCustomView?.isHidden = true
                //self.proceedPageCustomView?.isHidden = true
            }
        }else if tapped == 1 {
            self.constraintOnSelectfunc()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
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
                        userDefaultsData.saveHotelId(hotelId: 0)
                        userDefaultsData.saveMarketId(marketId: 0)
                    }else{
                        print("data has not recived")
                    }
                }
            }else{
            }
            // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.viewExcSearchCustomView?.excurSearchDelegate = self
            if self.viewExcSelectCustomView == nil || self.isHotelorMarketChanged == true{
                
                //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
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
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
        }else if tapped == 2 {
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
            self.viewFooterViewCustomView.labelAmount.isHidden = false
            self.viewFooterViewCustomView.buttonSaveButton.isHidden = false
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnAddFunc()
            
            self.viewExcSelectCustomView?.excSelectDelegate = self
            if self.viewExcAddCustomView == nil || self.isTourChange == true{
                
                //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
                // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
                    UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcAddCustomView = ExcAddCustomView()
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
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
            /*  self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
             if stepsPageCustomView == nil || self.isPaxesListChange == true {
             self.paxPageCustomView?.isHidden = true
             self.hotelPageCustomView?.isHidden = true
             self.proceedPageCustomView?.isHidden = true
             //self.lastUIView.removeFromSuperview()
             UIView.animate(withDuration: 0, animations: { [self] in
             self.stepsPageCustomView = StepsPageCustomView()
             self.stepsPageCustomView?.adlCount = self.adultCount
             self.stepsPageCustomView?.chldCount = self.childCount
             self.stepsPageCustomView?.infCount = self.infantCount
             self.stepsPageCustomView?.stepsPageListDelegate = self
             self.contentView.addSubview(stepsPageCustomView!)
             stepsPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
             }, completion: { (finished) in
             if finished{
             
             }
             })
             
             self.isPaxesListChange = false
             }else {
             self.stepsPageCustomView?.isHidden = false
             self.paxPageCustomView?.isHidden = true
             self.hotelPageCustomView?.isHidden = true
             self.proceedPageCustomView?.isHidden = true
             }
             */
        }else if tapped == 3 {
            
            /*  self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
             if proceedPageCustomView == nil || self.isPaxesListChange == true || self.isStepListChange == true {
             // self.lastUIView.removeFromSuperview()
             //  self.animatedCustomView(customView: ProceedPageCustomView())
             
             // self.lastUIView.removeFromSuperview()
             self.paxPageCustomView?.isHidden = true
             self.hotelPageCustomView?.isHidden = true
             self.stepsPageCustomView?.isHidden = true
             self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
             UIView.animate(withDuration: 0, animations: { [self] in
             self.proceedPageCustomView = ProceedPageCustomView()
             self.proceedPageCustomView?.paxListinProceedPage = self.paxesListinShopView
             self.proceedPageCustomView?.paxListinProceedPage = self.paxesListinShopView
             self.proceedPageCustomView?.stepsListinProceedPage = self.stepsListinShopView
             self.proceedPageCustomView?.adultCountinProceedPage = self.adultCount // procced page de değer doğru geliyormu görmek için koydum
             self.proceedPageCustomView?.childCountinProceedPage = self.childCount
             self.proceedPageCustomView?.infantCountinProceedPage = self.infantCount
             self.proceedPageCustomView?.proceedPageDelegate = self
             self.contentView.addSubview(proceedPageCustomView!)
             proceedPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
             }, completion: { (finished) in
             if finished{
             
             }
             })
             // self.lastUIView = self.proceedPageCustomView!
             self.isPaxesListChange = false
             }else {
             self.proceedPageCustomView?.isHidden = false
             self.paxPageCustomView?.isHidden = true
             self.stepsPageCustomView?.isHidden = true
             self.hotelPageCustomView?.isHidden = true
             }*/
            
        }
        else{
            
            print("default")
        }
    }
    
    func homePageTapped(ischosen: Int) {
        if self.changeNumber != userDefaultsData.getTourList()?.count {
            self.isTourChange = true
            self.changeNumber = userDefaultsData.getTourList()?.count ?? 0
        }
        self.viewFooterViewCustomView.buttonAddButton.isHidden = true
        self.viewFooterViewCustomView.labelAmount.isHidden = true
        self.viewFooterViewCustomView.buttonSaveButton.isHidden = true
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
            self.viewFooterViewCustomView.commonInit()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = false
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
                // self.stepsPageCustomView?.isHidden = true
                //self.proceedPageCustomView?.isHidden = true
            }
            
        }
        else if ischosen == 1 {
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
                       
                        userDefaultsData.saveHotelId(hotelId: 0)
                        userDefaultsData.saveMarketId(marketId: 0)
                    }else{
                        print("data has not recived")
                    }
                }
            }else{
            }
            // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.viewExcSearchCustomView?.excurSearchDelegate = self
            if self.viewExcSelectCustomView == nil || self.isHotelorMarketChanged == true{
                
                //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcAddCustomView?.isHidden = true
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
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
        }else if ischosen == 2 {
            //total amount counting
            
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
            self.viewFooterViewCustomView.labelAmount.isHidden = false
            self.viewFooterViewCustomView.buttonSaveButton.isHidden = false
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnAddFunc()
            self.viewExcSelectCustomView?.excSelectDelegate = self
            if self.viewExcAddCustomView == nil || self.isTourChange == true{
                
                //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                self.viewExcSearchCustomView?.isHidden = true
                self.viewExcSelectCustomView?.isHidden = true
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
                // self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcAddCustomView = ExcAddCustomView()
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
                // self.hotelPageCustomView?.isHidden = true
                // self.proceedPageCustomView?.isHidden = true
            }
        }else if ischosen == 3 {
            /*  self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
             
             if self.proceedPageCustomView == nil || self.isPaxesListChange == true || self.isStepListChange == true {
             self.paxPageCustomView?.isHidden = true
             self.stepsPageCustomView?.isHidden = true
             self.hotelPageCustomView?.isHidden = true
             //self.lastUIView.removeFromSuperview()
             UIView.animate(withDuration: 0, animations: { [self] in
             self.proceedPageCustomView = ProceedPageCustomView()
             self.proceedPageCustomView?.paxListinProceedPage = self.paxesListinShopView
             self.proceedPageCustomView?.stepsListinProceedPage = self.stepsListinShopView
             self.proceedPageCustomView?.adultCountinProceedPage = self.adultCount // procced page de değer doğru geliyormu görmek için koydum
             self.proceedPageCustomView?.childCountinProceedPage = self.childCount
             self.proceedPageCustomView?.infantCountinProceedPage = self.infantCount
             self.proceedPageCustomView?.proceedPageDelegate = self
             self.contentView.addSubview(proceedPageCustomView!)
             self.proceedPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
             }, completion: { (finished) in
             if finished{
             
             }
             })
             // self.lastUIView = self.proceedPageCustomView!
             self.isPaxesListChange = false
             self.isStepListChange = false
             }else {
             self.proceedPageCustomView?.isHidden = false
             self.paxPageCustomView?.isHidden = true
             self.stepsPageCustomView?.isHidden = true
             self.hotelPageCustomView?.isHidden = true
             }
             // self.animatedCustomView(customView: ProceedPageCustomView()) */
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
            
            UIView.animate(withDuration: 0, animations: { [self] in
                self.viewPaxCustomView = ExcPaxCustomView()
                self.viewPaxCustomView?.excPaxPageDelegate = self
                self.viewPaxCustomView?.paxesList = self.paxesList
                for index in 0...self.paxesList.count - 1 {
                    self.paxesList[index].isTapped = false
                    self.viewPaxCustomView?.checkList.append(self.paxesList[index].isTapped ?? false)
                }
                self.viewPaxCustomView?.tableView.reloadData()
                self.viewExcursionView.viewContentView.addSubview(self.viewPaxCustomView!)
                self.viewPaxCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.bounds.size.height)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
            
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
                return
            }
        }
    }
}

extension ExcursionViewController : ExcPaxPageDelegate {
    func excPaxInfo(tourButtonTapped: Bool?) {
        if tourButtonTapped == false {
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnPaxFunc()
            if viewPaxCustomView == nil {
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.viewExcSelectCustomView?.isHidden = true
                    self.viewPaxCustomView = ExcPaxCustomView()
                    self.viewExcursionView.viewContentView.addSubview(self.viewPaxCustomView!)
                    self.viewPaxCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.bounds.size.height)
                }, completion: { (finished) in
                    if finished{
                    }
                })
            }else{
                return
            }
        }else {
            self.viewFooterViewCustomView.buttonView.removeFromSuperview()
            self.constraintOnSelectfunc()
            // self.constraintOnSelectfunc()
            self.viewFooterViewCustomView.buttonAddButton.isHidden = true
            self.viewFooterViewCustomView.buttonView.isHidden = false
            /*  self.viewFooterViewCustomView.buttonAddButton.isHidden = true
             self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
             
             
             self.viewFooterViewCustomView.addSubview(self.viewFooterViewCustomView.buttonView)
             self.viewFooterViewCustomView.buttonView.translatesAutoresizingMaskIntoConstraints = false
             
             self.constraint.append(self.viewFooterViewCustomView.buttonView.leadingAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.leadingAnchor, constant: 20))
             self.constraint.append(self.viewFooterViewCustomView.buttonView.topAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.topAnchor, constant: 20))
             self.constraint.append(self.viewFooterViewCustomView.buttonView.widthAnchor.constraint(equalToConstant: 300))
             self.constraint.append(self.viewFooterViewCustomView.buttonView.heightAnchor.constraint(equalToConstant: 50))
             
             NSLayoutConstraint.activate( self.constraint) */
            self.viewPaxCustomView?.isHidden = true
            UIView.animate(withDuration: 0, animations: { [self] in
                self.viewExcSelectCustomView = ExcSelectCustomView()
                self.viewExcSelectCustomView?.excSelectDelegate = self
                self.viewExcursionView.viewContentView.addSubview(viewExcSelectCustomView!)
                self.viewExcSelectCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.viewExcursionView.viewContentView.frame.size.height)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
        }
    }
}




