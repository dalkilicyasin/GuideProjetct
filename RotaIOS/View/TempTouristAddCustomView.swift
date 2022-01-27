//
//  TempTouristAddCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.05.2021.
//

import Foundation

import UIKit

protocol TempAddPaxesListDelegate {
    func tempAddList( listofpaxes : [Paxes] , manuellist : [String], changeValue : Int )
}

class TempTouristAddCustomView : UIView{
    var addManuelTouristAddCustomView : AddManuelTouristCustomView?
    @IBOutlet var headerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var viewRemoveView: UIView!
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
    var tempPaxesList : [Paxes] = []
    var getInTouristInfoRequestModel : [GetTouristInfoRequestModel] = []
    var temppAddPaxesListDelegate : TempAddPaxesListDelegate?
    var changeCounterValue = 0
    var lastAddedPax : Paxes?
    
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
        
        self.viewRemoveView.roundCorners(.allCorners, radius: 10)
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
        self.temppAddPaxesListDelegate?.tempAddList(listofpaxes: self.tempPaxesList, manuellist: self.paxnameFromaddManuelList, changeValue: self.changeCounterValue)
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
        return self.tempPaxesList.count
        // return self.nameListed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaxPageTableViewCell.identifier) as! PaxPageTableViewCell
        cell.imageUserName.isHidden = false
        cell.imageCheckBox.isHidden = true
        let model : Paxes?
        model = tempPaxesList[indexPath.row]
        cell.labelPaxNameListCell.text = model?.pAX_NAME
        //   cell.labelPaxNameListCell.text = nameListed[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.tempPaxesList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            self.changeCounterValue -= 1
        }
    }  
}

extension TempTouristAddCustomView : SaveManuelListProtocol {
    func saveManuelList(manuelList: Paxes) {
        self.changeCounterValue += 1
        self.tempPaxesList.append( manuelList)
        self.lastAddedPax = manuelList
        self.paxnameFromaddManuelList.append(manuelList.pAX_NAME)
       // self.nameListed.append(manuelList.pAX_NAME)
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
