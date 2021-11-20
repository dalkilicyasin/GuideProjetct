//
//  ExcursionViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 17.11.2021.
//

import UIKit

class ExcursionViewController: UIViewController {
    @IBOutlet var viewExcursionView: ExcursionView!
    @IBOutlet weak var viewAppointMentBarCutomView: AppointmentBarCustomView!
    @IBOutlet weak var viewFooterViewCustomView: FooterCustomView!
    var viewExcSearchCustomView : ExcSearchCustomView?
    var lastUIView = UIView()
    
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
    }
}

extension ExcursionViewController : HomePageTappedDelegate , ContinueButtonTappedDelegate {
    
    func continueButtonTappedDelegate(tapped: Int) {
        self.viewAppointMentBarCutomView.collectionView(viewAppointMentBarCutomView.collectionView, didSelectItemAt: IndexPath.init(item: tapped, section: 0))
        
        self.viewFooterViewCustomView.counter = tapped
        if tapped == 0 {
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
            self.viewFooterViewCustomView.addSubview(self.viewFooterViewCustomView.buttonGetOfflineData)
            self.viewFooterViewCustomView.buttonGetOfflineData.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                viewFooterViewCustomView.buttonGetOfflineData.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                viewFooterViewCustomView.buttonGetOfflineData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                viewFooterViewCustomView.buttonGetOfflineData.widthAnchor.constraint(equalToConstant: 100),
                viewFooterViewCustomView.buttonGetOfflineData.heightAnchor.constraint(equalToConstant:50)])
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
