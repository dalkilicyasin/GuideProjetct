//
//  TempTouristAddCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.05.2021.
//

import Foundation

import UIKit



class TempTouristAddCustomView : UIView{

    var addManuelTouristAddCustomView : AddManuelTouristCustomView?
    @IBOutlet var headerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var buttonManuelAdd: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var nameListed : [String] = []
    var tempNameListed : [String] = []
    var paxesNameList : [GetInHoseListResponseModel] = []
    var filteredPaxesList : [GetInHoseListResponseModel] = []
    var paxesList : [Paxes] = []
    var touristInfoList : [GetTouristInfoResponseModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: TempTouristAddCustomView.self), owner: self, options: nil)
        self.headerView.addCustomContainerView(self)
        
        let getInHouseListRequestModel = GetInHouseListRequestModel(hotelId: userDefaultsData.getHotelId(), marketId: userDefaultsData.getMarketId())
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetInHouseList, method: .get, parameters: getInHouseListRequestModel.requestPathString()) { (response : [GetInHoseListResponseModel] ) in
            
            if response.count > 0 {
                print(response)
                // let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
     
                self.paxesNameList = response
         
            }else{
                print("data has not recived")
            }
        }
        
      //  self.nameListed.append(self.addManuelTouristAddCustomView?.tempSaveManuelList[0] ?? "")
        
        self.slideIdicator.roundCorners(.allCorners, radius: 10)
        self.buttonManuelAdd.layer.cornerRadius = 10
        self.buttonManuelAdd.layer.masksToBounds = true
        self.buttonManuelAdd.layer.borderWidth = 1
        self.buttonManuelAdd.layer.borderColor = UIColor.green.cgColor
   
        self.contentView.backgroundColor = UIColor.grayColor
        self.contentView.layer.cornerRadius = 10
        self.tableView.backgroundColor = UIColor.grayColor
     
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PaxPageTableViewCell.nib, forCellReuseIdentifier: PaxPageTableViewCell.identifier)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(removeButton))
        self.slideIdicator.addGestureRecognizer(tap)
        self.slideIdicator.isUserInteractionEnabled = true
        
    }
    
    @objc func removeButton(){
        
        
        for updateList in self.nameListed {
           let filter = self.paxesNameList.filter{($0.text?.elementsEqual(updateList) ?? false)}
    
            self.filteredPaxesList.append(filter[0])
           // let filter = paxesNameList.filter{($0.text?.contains(updateList) ?? false)}
        }
        print("list:\(self.filteredPaxesList)")
        
        var touristId : [Int] = []
        var resNo : [Int] = []
      
        for listarray in filteredPaxesList {
            touristId.append(listarray.value ?? 0)
            resNo.append(listarray.value ?? 0)
        }
        
        let getInTouristInfoRequestModel = GetTouristInfoRequestModel(touristId: touristId[0], resNo: resNo[0])
        
        NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetTouristInfo, method: .get, parameters: getInTouristInfoRequestModel.requestPathString()) { (response : [GetTouristInfoResponseModel] ) in
            
            if response.count > 0 {
                print(response)
                // let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
     
                self.touristInfoList = response
         
            }else{
                print("data has not recived")
            }
        }
        
        var paxID : [String] = [] //kullanıp kullanılmayacağı belli değil 0 aldım
        var oprID : [Int] = []
        var oprName : [String] = []
      //  var oprType : [Int] = [] // ne olduğu belli değil 1 aldım
        var reservationNo : [String] = []
        var hotelName : [String] = []
        var ageGroup : [String] = []
        var name : [String] = []
        var birthDay : [String] = []
        var passport : [String] = []
        var touristIdRef : [Int] = []
        
        for listarray in touristInfoList {
            paxID.append(listarray.id ?? "")
            oprID.append(listarray.oprId ?? 0)
            oprName.append(listarray.operator ?? "")
            reservationNo.append(listarray.resNo ?? "")
            hotelName.append(listarray.hotelName ?? "")
            ageGroup.append(listarray.ageGroup ?? "")
            name.append(listarray.name ?? "")
            birthDay.append(listarray.birthDay ?? "")
            passport.append(listarray.passport ?? "")
            
        }
        
        
        
          for i in  0...(self.nameListed.count) - 1 {
            self.paxesList.append(Paxes(action: 1, iD: 0, pAX_CHECKOUT_DATE: "", pAX_ID: 0, pAX_OPRID: oprID[i], pAX_OPRNAME: oprName[i], pAX_OPRTYPE: 1, pAX_ROWVERSION: 1, pAX_PHONE: "", hotelname: hotelName[i], pAX_GENDER: "MRS.", pAX_SOURCEREF: 0 , pAX_AGEGROUP: ageGroup[i], pAX_NAME: name[i], pAX_BIRTHDAY: birthDay[i], pAX_RESNO: reservationNo[i], pAX_PASSPORT: passport[i], pAX_ROOM: "1", pAX_TOURISTREF: touristIdRef[i] , pAX_STATUS: <#T##Int#>))
          }
          

      
        self.removeFromSuperview()
    }
    
 


    @IBAction func addManuelButton(_ sender: Any) {
       
        if let topVC = UIApplication.getTopViewController() {
            UIView.animate(withDuration: 0, animations: {
              
                self.addManuelTouristAddCustomView = AddManuelTouristCustomView()
                self.addManuelTouristAddCustomView?.tempSaveManuelList = self.nameListed
                self.addManuelTouristAddCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1200)
                topVC.view.addSubview(self.addManuelTouristAddCustomView!)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
        
        }
      //  self.removeFromSuperview()
    
    }
}


extension TempTouristAddCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameListed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaxPageTableViewCell.identifier) as! PaxPageTableViewCell
        cell.imageUserName.isHidden = false
        cell.checkBoxView.isHidden = true
        cell.labelPaxNameListCell.text = nameListed[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.nameListed.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }  
}


/*
let filter = paxesNameList.filter{($0.text?.elementsEqual(touristName) ?? false)}
self.filteredPaxesList.append(filter[0])
print(filteredPaxesList)

*/


