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
    var homePageTapped = true // işlevi yok silinecek
    var paxPageTapped = false //işlevi yok silinecek
    var isHere = false
    var paxesListinShopView : [Paxes] = []
    var stepsListinShopView : [Steps] = []
    var adultCount = 0
    var childCount = 0
    var infantCount = 0
    var isHotelChange = false
    var isPaxesListChange = false
    var isStepListChange = false
    var procedPageIsSuccess = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.appointmentBarCustomView.collectionList = ["Hotel","Pax","Steps","Proceed"]
        self.headerDetailCustomView.labelHeaderDetailView.text = "Ind. Shop Appointment"
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
        self.lastUIView = self.hotelPageCustomView!
        self.footerView.addSubview(self.footerView.buttonView)
        self.footerView.buttonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        self.footerView.buttonView.centerXAnchor.constraint(equalTo: self.footerView.viewHeader.centerXAnchor),
                                        self.footerView.buttonView.centerYAnchor.constraint(equalTo: self.footerView.viewHeader.centerYAnchor),
                                        self.footerView.buttonView.widthAnchor.constraint(equalToConstant: 320),
                                        self.footerView.buttonView.heightAnchor.constraint(equalToConstant: 50)])
        
        self.footerView.addSubview(self.footerView.printButton)
        self.footerView.printButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                                        self.footerView.printButton.centerXAnchor.constraint(equalTo: self.footerView.viewHeader.centerXAnchor),
                                        self.footerView.printButton.centerYAnchor.constraint(equalTo: self.footerView.viewHeader.centerYAnchor),
                                        self.footerView.printButton.widthAnchor.constraint(equalToConstant: 320),
                                        self.footerView.printButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

extension ShopAppointmentView : HomePageTappedDelegate , ContinueButtonTappedDelegate {
    
    func continueButtonTappedDelegate(tapped: Int) {
        
        self.appointmentBarCustomView.collectionView(appointmentBarCustomView.collectionView, didSelectItemAt: IndexPath.init(item: tapped, section: 0))
        
        self.footerView.counter = tapped
        if tapped == 0 {
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
            }
        }else if tapped == 1 {
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
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
            }   
        }else if tapped == 2 {
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
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
            
        }else if tapped == 3 {
            
            self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
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
            }
            
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
            }
            
        }
        else if ischosen == 1 {
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
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
            }
            
        }else if ischosen == 2 {
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
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
            }
            
        }else if ischosen == 3 {
            self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
            
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
            // self.animatedCustomView(customView: ProceedPageCustomView())
        }
        else{
            
            print("default")
        }
    }
    
    func animatedCustomView( customView : UIView ){
        //  self.lastUIView.removeFromSuperview()
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


extension ShopAppointmentView : HotelPageDelegate {
    func hotelPage(isChange: Bool) {
        self.isHotelChange = isChange
    }
}

extension ShopAppointmentView : PaxesListDelegate {
    func paxesList(ischosen: Bool, sendingPaxesLis: [Paxes], isChange: Bool) {
        self.isPaxesListChange = isChange
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
    func stepsPageList(listofsteps: [Steps], isChange: Bool) {
        self.isStepListChange = isChange
        self.stepsListinShopView.removeAll()
        for listarray in listofsteps {
            self.stepsListinShopView.append(listarray)
        }
    }
}

extension ShopAppointmentView : ProceedPageDelegate {
    func proceedPage(isSuccsess: Bool) {
        self.procedPageIsSuccess = isSuccsess
        if self.procedPageIsSuccess == true {
            self.footerView.printButton.isEnabled = true
            self.footerView.printButton.backgroundColor = UIColor.greenColor
        }else {
            self.footerView.printButton.isEnabled = false
            self.footerView.printButton.backgroundColor = UIColor.clear
        }
    }
}



