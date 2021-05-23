//
//  TempTouristAddCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.05.2021.
//

import Foundation

import UIKit

protocol TempAddPaxesListDelegate {
    func tempAddList( listofpaxes : [Paxes] )
}

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
    
    var paxID : [String] = [] 
    var oprID : [Int] = []
    var oprName : [String] = []
    
    var reservationNo : [String] = []
    var hotelName : [String] = []
    var paxRoom  : [String] = []
    var ageGroup : [String] = []
    var name : [String] = []
    var birthDay : [String] = []
    var passport : [String] = []
    var touristIdRef : [Int] = []
    var paxnameFromaddManuelList : [String] = []
   
    var sendingListofPaxes : [Paxes] = []
    
    var getInTouristInfoRequestModel : [GetTouristInfoRequestModel] = []
    var temppAddPaxesListDelegate : TempAddPaxesListDelegate?
    
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
        
        self.filteredPaxesList.removeAll()
        
        for filtername in self.paxnameFromaddManuelList {
            let filter = self.nameListed.filter{($0.elementsEqual(filtername) )}
            self.nameListed.remove(object: filter[0])
        }
        
        if nameListed.count != 0 {
          
            for updateList in self.nameListed {
                let filter = self.paxesNameList.filter{($0.text?.elementsEqual(updateList) ?? false)}
                self.filteredPaxesList.append(filter[0])
                // let filter = paxesNameList.filter{($0.text?.contains(updateList) ?? false)}
            }
            print("list:\(self.filteredPaxesList)")
            
            var touristId : [Int] = []
            var resNo : [String] = []
            var tempGetInTouristInfoRequestModel : [GetTouristInfoRequestModel] = []
            
            touristId.removeAll()
            resNo.removeAll()
            
            for listarray in self.filteredPaxesList {
                touristId.append(listarray.value ?? 0)
                resNo.append(listarray.resNo ?? "")
            }
            
            tempGetInTouristInfoRequestModel.removeAll()
            
            for i in 0...filteredPaxesList.count - 1 {
                tempGetInTouristInfoRequestModel.append(GetTouristInfoRequestModel(touristId: touristId[i], resNo: resNo[i]))
            }
            
            self.getInTouristInfoRequestModel = tempGetInTouristInfoRequestModel
            
           
            for i in 0...(self.getInTouristInfoRequestModel.count) - 1 {
                NetworkManager.sendGetRequestArray(url:NetworkManager.BASEURL, endPoint: .GetTouristInfo, method: .get, parameters: getInTouristInfoRequestModel[i].requestPathString()) { (response : [GetTouristInfoResponseModel] ) in
                    
                    if response.count > 0 {
                        print(response)
                        // let filter = response.filter{($0.text?.contains("ADONIS HOTEL ANTALYA") ?? false)}
                        
                        self.touristInfoList = response
                        
                        for listarray in self.touristInfoList {
                           // self.paxID.append(listarray.id ?? "")
                            self.oprID.append(listarray.oprId ?? 0)
                            self.oprName.append(listarray.operator ?? "")
                            self.reservationNo.append(listarray.resNo ?? "")
                            self.hotelName.append(listarray.hotelName ?? "")
                            self.paxRoom.append(listarray.room ?? "")
                            self.ageGroup.append(listarray.ageGroup ?? "")
                            self.name.append(listarray.name ?? "")
                            self.birthDay.append(listarray.birthDay ?? "")
                            self.passport.append(listarray.passport ?? "")
                            self.touristIdRef.append(listarray.touristIdRef ?? 0)
                            
                        }
                        
                        for i in 0...(self.touristInfoList.count) - 1 {
                            
                            self.paxesList.append(Paxes( pAX_CHECKOUT_DATE: "",  pAX_OPRID: self.oprID[i], pAX_OPRNAME: self.oprName[i], pAX_PHONE: "", hotelname: self.hotelName[i], pAX_GENDER: "MRS.", pAX_AGEGROUP: self.ageGroup[i], pAX_NAME: self.name[i], pAX_BIRTHDAY: self.birthDay[i], pAX_RESNO: self.reservationNo[i], pAX_PASSPORT: self.passport[i], pAX_ROOM: self.paxRoom[i], pAX_TOURISTREF:self.touristIdRef[i], pAX_STATUS: 1 ))
                            
                            self.sendingListofPaxes.append(self.paxesList[i])
                        }
                        self.temppAddPaxesListDelegate?.tempAddList(listofpaxes: self.sendingListofPaxes)
                        self.removeFromSuperview()
                        
                    }else{
                        print("data has not recived")
                    }
                }
            }
                
         
        }else if paxnameFromaddManuelList.count > 0{
            self.temppAddPaxesListDelegate?.tempAddList(listofpaxes: self.sendingListofPaxes)
        }
        
        self.removeFromSuperview()
    }
    
    
    
    
    @IBAction func addManuelButton(_ sender: Any) {
        
        if let topVC = UIApplication.getTopViewController() {
            UIView.animate(withDuration: 0, animations: {
                
                self.addManuelTouristAddCustomView = AddManuelTouristCustomView()
                self.addManuelTouristAddCustomView?.saveMAnuelListDelegate = self
                self.addManuelTouristAddCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1200)
                topVC.view.addSubview(self.addManuelTouristAddCustomView!)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
            
        }
      
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

extension TempTouristAddCustomView : SaveManuelListProtocol {
    func saveManuelList(manuelList: Paxes) {
        self.sendingListofPaxes.append( manuelList)
        self.paxnameFromaddManuelList.append(manuelList.pAX_NAME)
        self.nameListed.append(manuelList.pAX_NAME)
        self.tableView.reloadData()
    }
}


/*
 let filter = paxesNameList.filter{($0.text?.elementsEqual(touristName) ?? false)}
 self.filteredPaxesList.append(filter[0])
 print(filteredPaxesList)
 
 */

extension Array where Element: Equatable {

 // Remove first collection element that is equal to the given `object`:
 mutating func remove(object: Element) {
     guard let index = firstIndex(of: object) else {return}
     remove(at: index)
 }

}
