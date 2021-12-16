//
//  ExcAddCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.12.2021.
//

import Foundation
import UIKit
import DropDown

class ExcAddCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var buttonExtras: UIButton!
    @IBOutlet weak var buttonTransfers: UIButton!
    @IBOutlet weak var viewExcursions: MainTextCustomView!
    @IBOutlet weak var labelExtorTransf: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var extrasList : [Extras] = []
    var transfersList : [Transfers] = []
    var buttonExtraTapped = true
    var excursionMenu = DropDown()
    var excursionListInAddMenu : [GetSearchTourResponseModel] = []
    var tempExcurionMenu : [String] = []
    var filteredExcursionList : [GetSearchTourResponseModel] = []
    var transferChecklist : [Bool] = []
    var extrasChecklist : [Bool] = []
    var saveExtrasList : [Extras] = []
    var saveTransferList : [Transfers] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ExcAddCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        
        self.excursionListInAddMenu = userDefaultsData.getTourList() ?? self.excursionListInAddMenu
        
        self.labelExtorTransf.addLine(position: .bottom, color: .lightGray, width: 1.0)
        self.tableView.backgroundColor = UIColor.tableViewColor
        self.viewMainView.backgroundColor = UIColor.grayColor
        
        self.buttonExtras.clipsToBounds = true
        self.buttonExtras.layer.cornerRadius = 10
        self.buttonExtras.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        self.buttonExtras.backgroundColor = UIColor.greenColor
        
        self.buttonTransfers.clipsToBounds = true
        self.buttonTransfers.layer.cornerRadius = 10
        self.buttonTransfers.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        self.buttonTransfers.layer.borderWidth = 1
        self.buttonTransfers.backgroundColor = UIColor.clear
        self.buttonTransfers.layer.borderColor = UIColor.green.cgColor
        
        self.viewExcursions.layer.cornerRadius = 10
        self.viewExcursions.backgroundColor = UIColor.mainTextColor
      
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddMenuTableViewCell.nib, forCellReuseIdentifier: AddMenuTableViewCell.identifier)
        
        self.viewExcursions.headerLAbel.text = "Excursion"
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedExcursionMenu))
        gesture.numberOfTouchesRequired = 1
        self.viewExcursions.addGestureRecognizer(gesture)
        
        for listofArray in self.excursionListInAddMenu {
            self.tempExcurionMenu.append(listofArray.tourName ?? "")
        }
        
        self.excursionMenu.dataSource = self.tempExcurionMenu
        self.excursionMenu.dataSource.insert("", at: 0)
        self.excursionMenu.backgroundColor = UIColor.grayColor
        self.excursionMenu.separatorColor = UIColor.gray
        self.excursionMenu.textColor = .white
        self.excursionMenu.anchorView = self.viewExcursions
        self.excursionMenu.topOffset = CGPoint(x: 0, y:-(self.excursionMenu.anchorView?.plainView.bounds.height)!)
        
        self.excursionMenu.selectionAction = { index, title in
            if title != self.viewExcursions.mainLabel.text {
            }
            self.viewExcursions.mainLabel.text = title
            let filtered = self.excursionListInAddMenu.filter{($0.tourName?.contains(title) ?? false)}
            self.filteredExcursionList = filtered
            for listofArray in self.filteredExcursionList {
                self.extrasList = listofArray.extras ?? self.extrasList
                self.transfersList = listofArray.transfers ?? self.transfersList
            }
            if self.extrasList.count > 0 {
                for index in 0...self.extrasList.count - 1 {
                    self.extrasList[index].isTapped = false
                    self.extrasChecklist.append(self.extrasList[index].isTapped ?? false)
                }
            }
            
            if self.transfersList.count > 0  {
                for index in 0...self.transfersList.count - 1 {
                    self.transfersList[index].isTapped = false
                    self.transferChecklist.append(self.transfersList[index].isTapped ?? false)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func tappedExcursionMenu() {
        self.excursionMenu.show()
        self.excursionMenu.direction = .bottom
    }

    
    @IBAction func transfersButtonTapped(_ sender: Any) {
        self.buttonExtraTapped = false
        self.buttonTransfers.backgroundColor = UIColor.greenColor
        self.buttonExtras.layer.borderWidth = 1
        self.buttonExtras.backgroundColor = UIColor.clear
        self.buttonExtras.layer.borderColor = UIColor.greenColor.cgColor
        self.labelExtorTransf.text = "Transfers"
        self.tableView.reloadData()
    }
    
    @IBAction func extrasButtonTapped(_ sender: Any) {
        self.buttonExtraTapped = true
        self.buttonExtras.backgroundColor = UIColor.greenColor
        self.buttonTransfers.layer.borderWidth = 1
        self.buttonTransfers.backgroundColor = UIColor.clear
        self.buttonTransfers.layer.borderColor = UIColor.greenColor.cgColor
        self.labelExtorTransf.text = "Extras"
        self.tableView.reloadData()
    }
}

extension ExcAddCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonExtraTapped == true {
            return self.extrasList.count
        }else {
            return self.transfersList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddMenuTableViewCell.identifier ) as! AddMenuTableViewCell
        cell.addMenuTableViewCellDelegate = self
        if self.buttonExtraTapped == true {
            cell.labelTransforExtraName.text = self.extrasList[indexPath.row].tourName
            cell.labelPriceType.text = self.extrasList[indexPath.row].priceTypeDesc
            cell.extraListInAddMenuCell = self.extrasList[indexPath.row]
            cell.transExtrDesc = self.extrasList[indexPath.row].desc ?? ""
            cell.isTappedCheck = self.extrasList[indexPath.row].isTapped ?? false
            return cell
        }else{
            cell.labelTransforExtraName.text = self.transfersList[indexPath.row].tourName
            cell.labelPriceType.text = self.transfersList[indexPath.row].priceTypeDesc
            cell.transferListInAddMenuCell = self.transfersList[indexPath.row]
            cell.transExtrDesc = self.transfersList[indexPath.row].desc ?? ""
            cell.isTappedCheck = self.transfersList[indexPath.row].isTapped ?? false
            return cell
        }
    }
}

extension ExcAddCustomView : AddMenuTableViewCellDelegate {
    func checkBoxTapped(checkCounter: Bool, transExtrDesc : String) {
        if let index = self.extrasList.firstIndex(where: {$0.desc == transExtrDesc}){
            self.extrasList[index].isTapped = checkCounter
            self.extrasChecklist[index] = checkCounter
        }
        
        if let index = self.transfersList.firstIndex(where: {$0.desc == transExtrDesc}){
            self.transfersList[index].isTapped = checkCounter
            self.transferChecklist[index] = checkCounter
        }
        self.tableView.reloadData()
        
        if checkCounter == true {
            let filterExtras = extrasList.filter{ $0.desc == transExtrDesc}
            let filterTransfers = transfersList.filter{ $0.desc == transExtrDesc}
           // let filter = self.excursionList.filter{($0.tourId?.elementsEqual(tourid) ?? false)}
            for index in filterExtras {
                self.saveExtrasList.append(index)
            }
            
            for index in filterTransfers {
                self.saveTransferList.append(index)
            }
            
        }else{
           // let filter = self.excursionList.filter{($0.tourName?.elementsEqual(tourid) ?? false)}
            let filterExtras = extrasList.filter{ $0.desc == transExtrDesc}
            let filterTransfers = transfersList.filter{ $0.desc == transExtrDesc}
            
            if filterExtras.count > 0 {
                if let insideIndex = self.saveExtrasList.firstIndex(where: {$0.desc == filterExtras[0].desc}){
                    self.saveExtrasList.remove(at: insideIndex)
                }
            }else if filterTransfers.count > 0 {
                if let insideIndex = self.saveTransferList.firstIndex(where: {$0.desc == filterTransfers[0].desc}){
                    self.saveTransferList.remove(at: insideIndex)
                }
            }else{
                return
            }
        }
        userDefaultsData.saveExtrasList(tour: self.saveExtrasList)
        userDefaultsData.saveTransfersList(tour: self.transfersList)
    }
}
