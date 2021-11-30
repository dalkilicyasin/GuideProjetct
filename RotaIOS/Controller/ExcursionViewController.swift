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
    var beginDateStringType = ""
    var endDateStringType = ""
    var tourList : [GetSearchTourResponseModel] = []
    var oflineDataTourList : [GetSearchTourResponseModel] = []
    var lastUIView = UIView()
    var isConnectedInternet : Bool?
    
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
        
        if Connectivity.isConnectedToInternet {
             print("Connected")
            self.isConnectedInternet = true
         } else {
             print("No Internet")
            self.isConnectedInternet = false
        }
    }
    
    @objc func tappedOfflinedataButton() {
        let getOfflineDataRequestModel = GetTourSearchCacheRequestModel.init(guideId: String(userDefaultsData.getGuideId()), hotelIds: self.viewExcSearchCustomView?.hotelIdStringType ?? "")
        NetworkManager.sendGetRequestArray(url: NetworkManager.BASEURL, endPoint: .GetTourSearchCache, method: .get, parameters: getOfflineDataRequestModel.requestPathString()) { (response : [GetSearchTourResponseModel]) in
            if response.count > 0 {
                print(response[0])
                userDefaultsData.saveSearchTourOffline(id: response)
            }else{
                print("data has not recived")
            }
        }
       print("tapped")
        
    }
}

extension ExcursionViewController : HomePageTappedDelegate , ContinueButtonTappedDelegate {
    func continueButtonTappedDelegate(tapped: Int) {
        self.viewAppointMentBarCutomView.collectionView(viewAppointMentBarCutomView.collectionView, didSelectItemAt: IndexPath.init(item: tapped, section: 0))
        self.viewFooterViewCustomView.counter = tapped
        if tapped == 0 {
            self.viewFooterViewCustomView.buttonGetOfflineData.translatesAutoresizingMaskIntoConstraints = true
            self.viewFooterViewCustomView.commonInit()
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = false
          //  self.viewFooterViewCustomView.buttonHiding(hidePrintbutton: true, hideButton: false)
          /*  if self.hotelPageCustomView == nil {
               // self.lastUIView.removeFromSuperview()
                self.paxPageCustomView?.isHidden = true
                self.stepsPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
                self.animatedCustomView(customView: HotelPageCustomView())
            }else {
                self.hotelPageCustomView?.isHidden = false
                self.paxPageCustomView?.isHidden = true
                self.stepsPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
            }*/
        }else if tapped == 1 {
            self.viewFooterViewCustomView.buttonGetOfflineData.isHidden = true
            self.viewFooterViewCustomView.addSubview(self.viewFooterViewCustomView.buttonView)
            self.viewFooterViewCustomView.buttonView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                                            self.viewFooterViewCustomView.buttonView.centerXAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.centerXAnchor),
                                            self.viewFooterViewCustomView.buttonView.centerYAnchor.constraint(equalTo: self.viewFooterViewCustomView.viewHeader.centerYAnchor),
                                            self.viewFooterViewCustomView.buttonView.widthAnchor.constraint(equalToConstant: 320),
                                            self.viewFooterViewCustomView.buttonView.heightAnchor.constraint(equalToConstant: 50)])
            
            let getTourSearchRequestModel = GetTourSearchRequestModel.init(guide: String(userDefaultsData.getGuideId()), market: self.viewExcSearchCustomView?.marketIdStringType ?? "", hotel: self.viewExcSearchCustomView?.hotelIdStringType ?? "", area: self.viewExcSearchCustomView?.areaIdStringType ?? "", tourdatestart: self.viewExcSearchCustomView?.beginDateString ??  "", tourdateend: self.viewExcSearchCustomView?.endDateString ?? "", saledate: userDefaultsData.getSaleDate())
            
            NetworkManager.sendRequestArray(url: NetworkManager.BASEURL, endPoint: .GetTourSaleSearchTour, requestModel: getTourSearchRequestModel) { (response : [GetSearchTourResponseModel]) in
                if response.count > 0 {
                    self.tourList = response
                    print(self.tourList[0])
                }else{
                    let alert = UIAlertController.init(title: "Error", message: "Tour Data has not Recived", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
           
           /* self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.hotelPageCustomView?.hotelPageDlegate = self
            if self.paxPageCustomView == nil || self.isHotelChange == true{
      
              //  self.lastUIView.removeFromSuperview()
                //  self.animatedCustomView(customView: PaxPageCustomView())
                self.stepsPageCustomView?.isHidden = true
                self.hotelPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
                self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
                UIView.animate(withDuration: 0, animations: { [self] in
                    self.paxPageCustomView = PaxPageCustomView()
                  self.paxPageCustomView?.paxesListDelegate = self
                    self.contentView.addSubview(paxPageCustomView!)
                    paxPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
                }, completion: { (finished) in
                    if finished{
                        
                    }
                })
              // self.lastUIView = self.paxPageCustomView!
                self.isHotelChange = false
            }else {
                self.paxPageCustomView?.isHidden = false
                self.stepsPageCustomView?.isHidden = true
                self.hotelPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
            }*/
        }else if tapped == 2 {
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
        if self.viewFooterViewCustomView.counter == ischosen {
            return
        }
        self.viewFooterViewCustomView.counter = ischosen
        
        if ischosen == 0 {
          /*
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            if self.hotelPageCustomView == nil {
               // self.lastUIView.removeFromSuperview()
                self.paxPageCustomView?.isHidden = true
                self.stepsPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
                self.animatedCustomView(customView: HotelPageCustomView())
            }else {
                self.hotelPageCustomView?.isHidden = false
                self.paxPageCustomView?.isHidden = true
                self.stepsPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
            }*/
            
        }
        else if ischosen == 1 {
           /* self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.hotelPageCustomView?.hotelPageDlegate = self
            if self.paxPageCustomView == nil || self.isHotelChange == true{
                 // self.lastUIView.removeFromSuperview()
                // self.animatedCustomView(customView: PaxPageCustomView())
                self.hotelPageCustomView?.isHidden = true
                self.stepsPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
                   UIView.animate(withDuration: 0, animations: { [self] in
                       self.paxPageCustomView = PaxPageCustomView()
                       self.paxPageCustomView?.paxesListDelegate = self
                       self.contentView.addSubview(paxPageCustomView!)
                    self.paxPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
                   }, completion: { (finished) in
                       if finished{
                           
                       }
                   })
                //  self.lastUIView = self.paxPageCustomView!
                
                self.isHotelChange = false
            }else {
                self.paxPageCustomView?.isHidden = false
                self.hotelPageCustomView?.isHidden = true
                self.stepsPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
            }*/
          
        }else if ischosen == 2 {
           /* self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            if self.stepsPageCustomView == nil || self.isPaxesListChange == true {
                // self.lastUIView.removeFromSuperview()
               //  self.animatedCustomView(customView: StepsPageCustomView())
                self.paxPageCustomView?.isHidden = true
                self.hotelPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
                 
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
               // self.lastUIView = self.stepsPageCustomView!
                self.isPaxesListChange = false
                 
            }else {
                self.stepsPageCustomView?.isHidden = false
                self.paxPageCustomView?.isHidden = true
                self.hotelPageCustomView?.isHidden = true
                self.proceedPageCustomView?.isHidden = true
            } */
       
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
}


