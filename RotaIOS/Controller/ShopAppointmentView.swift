//
//  ShopAppointmentView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 18.04.2021.
//

import Foundation
import UIKit

final class ShopAppointmentView : UIView {
    
    @IBOutlet weak var headerDetailCustomView: HeaderDetailCustomView!
    @IBOutlet weak var appointmentBarCustomView: AppointmentBarCustomView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var footerView: FooterCustomView!
    var hotelPageCustomView : HotelPageCustomView?
    var paxPageCustomView : PaxPageCustomView?
    var stepsPageCustomView : StepsPageCustomView?
    var proceedPageCustomView : ProceedPageCustomView?
    var appontmentBarCell : ApponintmentBarCollectionViewCell?
    var lastUIView = UIView()
    var homePageTapped = true
    var paxPageTapped = false
    var isHere = false
    var paxesListinShopView : [Paxes] = []
  
    var stepsListinShopView : [Steps] = []
    
    var adultCount = 0
    var childCount = 0
    var infantCount = 0
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headerDetailCustomView.labelHeader.text = "Ind. Shop Appointment"
        
        self.appointmentBarCustomView.homePageTappedDelegate = self
        self.footerView.continueButtonTappedDelegate = self
        
        self.lastUIView = UIView ()
        UIView.animate(withDuration: 0, animations: { [self] in
            self.hotelPageCustomView = HotelPageCustomView()
            self.contentView.addSubview(hotelPageCustomView!)
            self.hotelPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
        }, completion: { (finished) in
            if finished{
                
            }
        })
        self.lastUIView = hotelPageCustomView!
        
        
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
}

extension ShopAppointmentView : HomePageTappedDelegate , ContinueButtonTappedDelegate{
    
    func continueButtonTappedDelegate(tapped: Int) {
        
    self.appointmentBarCustomView.collectionView(appointmentBarCustomView.collectionView, didSelectItemAt: IndexPath.init(item: tapped, section: 0))
        
        
        self.footerView.counter = tapped
        if tapped == 0 {
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            // self.lastUIView.removeFromSuperview()
            self.animatedCustomView(customView: HotelPageCustomView())
            
            
        }else if tapped == 1 {
            
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.lastUIView.removeFromSuperview()
            //  self.animatedCustomView(customView: PaxPageCustomView())
            
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
            self.lastUIView = self.paxPageCustomView!
         
            
        }else if tapped == 2 {
            
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.lastUIView.removeFromSuperview()
            self.animatedCustomView(customView: StepsPageCustomView())
        }else if tapped == 3 {
            
            self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
            self.lastUIView.removeFromSuperview()
          //  self.animatedCustomView(customView: ProceedPageCustomView())
            
            self.lastUIView.removeFromSuperview()
            self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
            UIView.animate(withDuration: 0, animations: { [self] in
                self.proceedPageCustomView = ProceedPageCustomView()
             self.proceedPageCustomView?.paxListinProceedPage = self.paxesListinShopView
                self.contentView.addSubview(proceedPageCustomView!)
                proceedPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
            self.lastUIView = self.proceedPageCustomView!
        }
        else{
            
            print("default")
        }
    }
    
    func homePageTapped(ischosen: Int) {
        
        if self.footerView.counter == ischosen {
            return
        }
        self.footerView.counter = ischosen
        
        if ischosen == 0 {
            self.lastUIView.removeFromSuperview()
            
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.animatedCustomView(customView: HotelPageCustomView())
            
        }
        else if ischosen == 1 {
            
            self.lastUIView.removeFromSuperview()
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
         // self.animatedCustomView(customView: PaxPageCustomView())
            UIView.animate(withDuration: 0, animations: { [self] in
                self.paxPageCustomView = PaxPageCustomView()
                self.paxPageCustomView?.paxesListDelegate = self
                self.contentView.addSubview(paxPageCustomView!)
                paxPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
            self.lastUIView = self.paxPageCustomView!
           
        }else if ischosen == 2 {
            
            self.lastUIView.removeFromSuperview()
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
          //  self.animatedCustomView(customView: StepsPageCustomView())
            
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
            self.lastUIView = self.stepsPageCustomView!
           
            
        }else if ischosen == 3 {
            
            self.lastUIView.removeFromSuperview()
            self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
            UIView.animate(withDuration: 0, animations: { [self] in
                self.proceedPageCustomView = ProceedPageCustomView()
                self.proceedPageCustomView?.paxListinProceedPage = self.paxesListinShopView
                self.proceedPageCustomView?.stepsListinProceedPage = self.stepsListinShopView
                self.proceedPageCustomView?.adultCountinProceedPage = self.adultCount
                self.proceedPageCustomView?.childCountinProceedPage = self.childCount
                self.proceedPageCustomView?.infantCountinProceedPage = self.infantCount
                self.contentView.addSubview(proceedPageCustomView!)
                proceedPageCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
            self.lastUIView = self.proceedPageCustomView!
            
      // self.animatedCustomView(customView: ProceedPageCustomView())
        }
        else{
            
            print("default")
        }
    }
    
    func animatedCustomView( customView : UIView ){
        self.lastUIView.removeFromSuperview()
        UIView.animate(withDuration: 0, animations: { [self] in
           // self.paxPageCustomView?.paxesListDelegate = self
           
            self.contentView.addSubview(customView)
            customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
        }, completion: { (finished) in
            if finished{
                
            }
        })
        self.lastUIView = customView
    }
}

extension ShopAppointmentView : PaxesListDelegate {
    func paxesList(ischosen: Bool, sendingPaxesLis: [Paxes]) {
        self.paxesListinShopView.removeAll()
            for listarray in sendingPaxesLis {
                self.paxesListinShopView.append(listarray)
            }
        
        var adultList : [String] = []
        adultList.removeAll()
        
        for listarray in self.paxesListinShopView{
            adultList.append(listarray.pAX_AGEGROUP ?? "")
        }
        if paxesListinShopView.count > 0 {
            self.adultCount = 0
            self.childCount = 0
            self.infantCount = 0
            for i in 0...self.paxesListinShopView.count - 1 {
                if adultList[i] == "ADL" {
                    self.adultCount += 1
                }else if adultList[i] == "CHD" {
                    self.childCount += 1
                }else if adultList[i] == "INF" {
                    self.infantCount += 1
                }
            }
        }
       
        
        
    }
   
}

extension ShopAppointmentView : StepsPageListDelegate {
    func stepsPageList(listofsteps: [Steps]) {
        self.stepsListinShopView.removeAll()
        for listarray in listofsteps {
            self.stepsListinShopView.append(listarray)
        }
    }
}


