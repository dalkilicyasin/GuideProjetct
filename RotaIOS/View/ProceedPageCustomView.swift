//
//  ProceedCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 25.04.2021.
//


import Foundation

import UIKit



class ProceedPageCustomView : UIView {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var shopDateMainText: MainTextCustomView!
    @IBOutlet weak var roomMainText: MainTextCustomView!
    @IBOutlet weak var notesMainText: MainTextCustomView!
    @IBOutlet weak var pickUpTimeMainText: MainTextCustomView!
    @IBOutlet weak var sendButton: UIButton!
    var dateString = ""
    var timeString = ""
    
    var paxFilteredList : [String] = []
    
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let dateToolBar = UIToolbar()
    let timeToolBar = UIToolbar()
    
    var paxListinProceedPage : [Paxes] = []
    var stepsListinProceedPage : [Steps] = []
    
    var paxListStringType : [String : Any] = [:]
    var stepListStringType : [String : Any] = [:]
    
    var adultCountinProceedPage = 0
    var childCountinProceedPage = 0
    var infantCountinProceedPage = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ProceedPageCustomView.self), owner: self, options: nil)
        headerView.addCustomContainerView(self)
        
        self.headerView.backgroundColor = UIColor.mainViewColor
        
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.borderColor = UIColor.green.cgColor
        self.sendButton.layer.cornerRadius = 10
        
        self.shopDateMainText.headerLAbel.text = "Shop Date"
        self.pickUpTimeMainText.headerLAbel.text = "Pick Up Time"
        self.roomMainText.headerLAbel.text = "Room"
        self.notesMainText.headerLAbel.text = "Notes"
        
        self.shopDateMainText.mainLabel.isHidden = true
        self.shopDateMainText.mainText.isHidden = false
        self.shopDateMainText.imageMainText.isHidden = true
        self.pickUpTimeMainText.mainLabel.isHidden = true
        self.pickUpTimeMainText.mainText.isHidden = false
        self.pickUpTimeMainText.imageMainText.isHidden = true
        self.roomMainText.mainLabel.isHidden = true
        self.roomMainText.mainText.isHidden = false
        self.roomMainText.imageMainText.isHidden = true
        self.notesMainText.mainLabel.isHidden = true
        self.notesMainText.mainText.isHidden = false
        self.notesMainText.imageMainText.isHidden = true
        
        self.createDatePicker()
        self.createTimePicker()
    
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        
        print("\(userDefaultsData.getMarketGruopId()),\(userDefaultsData.getMarketId() ?? ""),\(userDefaultsData.getHotelArea() ?? ""),\(userDefaultsData.getHotelId() ?? "")")
        print(self.paxListinProceedPage)
        print(self.stepsListinProceedPage)
        print(self.adultCountinProceedPage)
        
        var pax = [String : Any]()
        for i in 0...self.paxListinProceedPage.count - 1 {
        
        pax = [ "Action": self.paxListinProceedPage[i].action,"ID": 0,"PAX_AGEGROUP": self.paxListinProceedPage[i].pAX_AGEGROUP ?? "","PAX_BIRTHDAY":self.paxListinProceedPage[i].pAX_BIRTHDAY ?? "","PAX_CHECKOUT_DATE":self.paxListinProceedPage[i].pAX_CHECKOUT_DATE ?? "","PAX_GENDER":self.paxListinProceedPage[i].pAX_GENDER ?? "","PAX_ID":0,"PAX_NAME":self.paxListinProceedPage[i].pAX_NAME ?? "","PAX_OPRID":self.paxListinProceedPage[i].pAX_OPRID ?? 0 ,"PAX_OPRNAME":self.paxListinProceedPage[i].pAX_OPRNAME ?? "","PAX_OPRTYPE":1,"PAX_PASSPORT":self.paxListinProceedPage[i].pAX_PASSPORT ?? "","PAX_PHONE": "","PAX_RESNO":self.paxListinProceedPage[0].pAX_RESNO ?? "","PAX_ROOM":self.paxListinProceedPage[i].pAX_ROOM ?? "","PAX_ROWVERSION" :1,"PAX_SOURCEREF":0,"PAX_STATUS":1,"PAX_TOURISTREF":self.paxListinProceedPage[i].pAX_TOURISTREF ?? 0,"hotelname":self.paxListinProceedPage[i].hotelname ?? ""]
        }
        
        print(pax)
        
     /*   if self.paxListinProceedPage.count > 0 && self.stepsListinProceedPage.count > 0{
            self.paxListStringType.removeAll()
            self.stepListStringType.removeAll()
         for i in 0...self.paxListinProceedPage.count - 1 {
                
            var pax = [String : Any]()
            pax = [ "Action": self.paxListinProceedPage[i].action,"ID": 0,"PAX_AGEGROUP": self.paxListinProceedPage[i].pAX_AGEGROUP ?? "","PAX_BIRTHDAY":self.paxListinProceedPage[i].pAX_BIRTHDAY ?? "","PAX_CHECKOUT_DATE":self.paxListinProceedPage[i].pAX_CHECKOUT_DATE ?? "","PAX_GENDER":self.paxListinProceedPage[i].pAX_GENDER ?? "","PAX_ID":0,"PAX_NAME":self.paxListinProceedPage[i].pAX_NAME ?? "","PAX_OPRID":self.paxListinProceedPage[i].pAX_OPRID ?? 0 ,"PAX_OPRNAME":self.paxListinProceedPage[i].pAX_OPRNAME ?? "","PAX_OPRTYPE":1,"PAX_PASSPORT":self.paxListinProceedPage[i].pAX_PASSPORT ?? "","PAX_PHONE": "","PAX_RESNO":self.paxListinProceedPage[0].pAX_RESNO ?? "","PAX_ROOM":self.paxListinProceedPage[i].pAX_ROOM ?? "","PAX_ROWVERSION" :1,"PAX_SOURCEREF":0,"PAX_STATUS":1,"PAX_TOURISTREF":self.paxListinProceedPage[i].pAX_TOURISTREF ?? 0,"hotelname":self.paxListinProceedPage[i].hotelname ?? ""]
             
               self.paxListStringType.append(pax)
                
            }
            
            for i in 0...self.stepsListinProceedPage.count - 1 {
                
                let step = "{\"STP_ADULTCOUNT\":\(self.adultCountinProceedPage),\"STP_CHILDCOUNT\":\(self.childCountinProceedPage),\"STP_COMPANY\":\(self.stepsListinProceedPage[i].sTP_COMPANY ?? 0),\"STP_ID\":\(0),\"PAX_ID\":\(0),\"STP_INFANTCOUNT\":\(self.infantCountinProceedPage),\"STP_NOTE\":\"\",\"STP_ORDER\":\(self.stepsListinProceedPage[i].sTP_ORDER ?? 0),\"STP_SHOPREF\":\(0),\"STP_STATE\":\(self.stepsListinProceedPage[i].sTP_STATE ?? 0),\"name\":\"\(self.stepsListinProceedPage[i].name ?? "")\"}"
               
                self.stepListStringType.append(step)
            }
            
         
           print(self.paxListStringType)
           print(self.stepListStringType)
           
        } */
        
        
   
        let saveForMobileRequestModel = GetSaveForMobileRequestList.init( iND_SHOPDATE: self.dateString , iND_GUIDEREF: userDefaultsData.getGuideId(), iND_MARKETGROUPREF: userDefaultsData.getMarketGruopId(), iND_MARKETREF: Int(userDefaultsData.getMarketId()) ?? 0, iND_AREAREF: Int(userDefaultsData.getHotelArea()) ?? 0, iND_HOTELREF: Int(userDefaultsData.getHotelId()) ?? 0, iND_NOTE: self.notesMainText.mainText.text ?? "", iND_SHOPPICKUPTIME: self.timeString, strPaxes: "", strSteps: "")
            
        NetworkManager.sendRequest(url: NetworkManager.BASEURL, endPoint: .GetSaveForMobile, requestModel: saveForMobileRequestModel ) { (response: GetSaveForMobileResponseList) in
            if response != nil {
                print(response)
            }else{
                let alert = UIAlertController(title: "Errror", message: "Token has not recived", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            }
        }
        
  
     
        
      //  for i in 0...self.paxListinProceedPage.count
  
}
    
    func createDatePicker() {
        
        self.shopDateMainText.mainText.textAlignment = .center
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        self.dateToolBar.setItems([doneButton], animated: true)
        self.dateToolBar.sizeToFit()
        self.shopDateMainText.mainText.inputAccessoryView = dateToolBar
        self.shopDateMainText.mainText.inputView = datePicker
        self.datePicker.datePickerMode = .date
    }
    
    
    @objc func datePickerDonePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "MM-dd-yyyy"
        
        self.shopDateMainText.mainText.text = formatter.string(from: datePicker.date)
        self.headerView.endEditing(true)
        
        print(formatter.string(from: datePicker.date))
        
        self.dateString = formatter.string(from: datePicker.date)
    }
    
    
    func createTimePicker() {
        
        self.pickUpTimeMainText.mainText.textAlignment = .center
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePickerDonePressed))
        self.timeToolBar.setItems([doneButton], animated: true)
        self.timeToolBar.sizeToFit()
        self.pickUpTimeMainText.mainText.inputAccessoryView = timeToolBar
        self.pickUpTimeMainText.mainText.inputView = timePicker
        self.timePicker.datePickerMode = .time
    }
    
    
    @objc func timePickerDonePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "HH:dd a"
        
        self.pickUpTimeMainText.mainText.text = formatter.string(for: timePicker.date)
        self.headerView.endEditing(true)
        print(formatter.string(from: timePicker.date))
        self.timeString = formatter.string(from: datePicker.date)
    }
}



