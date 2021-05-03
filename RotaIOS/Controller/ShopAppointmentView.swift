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
            self.animatedCustomView(customView: PaxPageCustomView())
            
        }else if tapped == 2 {
            
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.lastUIView.removeFromSuperview()
            self.animatedCustomView(customView: StepsPageCustomView())
        }else if tapped == 3 {
            
            self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
            self.lastUIView.removeFromSuperview()
            self.animatedCustomView(customView: ProceedPageCustomView())
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
            self.animatedCustomView(customView: HotelPageCustomView())
        }
        else if ischosen == 1 {
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.animatedCustomView(customView: PaxPageCustomView())
          
        }else if ischosen == 2 {
            self.footerView.buttonHiding(hidePrintbutton: true, hideButton: false)
            self.lastUIView.removeFromSuperview()
            self.animatedCustomView(customView: StepsPageCustomView())
        }else if ischosen == 3 {
            self.footerView.buttonHiding(hidePrintbutton: false, hideButton: true)
            self.lastUIView.removeFromSuperview()
            self.animatedCustomView(customView: ProceedPageCustomView())
        }
        else{
            
            print("default")
        }
    }
    
    func animatedCustomView( customView : UIView ){
        self.lastUIView.removeFromSuperview()
        UIView.animate(withDuration: 0, animations: { [self] in
            self.contentView.addSubview(customView)
            customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: self.contentView.frame.size.height)
        }, completion: { (finished) in
            if finished{
                
            }
        })
        self.lastUIView = customView
        
    }
}


