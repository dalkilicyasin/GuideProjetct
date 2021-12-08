//
//  ExcSelectCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 30.11.2021.
//

import Foundation
import UIKit

class ExcSelectCustomView : UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var buttonTour: UIButton!
    @IBOutlet weak var buttonPaxes: UIButton!
    @IBOutlet weak var buttonDefault: UIButton!
    @IBOutlet weak var buttonPromotion: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelExcursion: UILabel!
    var excursionList : [GetSearchTourResponseModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        if Connectivity.isConnectedToInternet {
           print("connect")
         } else {
            self.excursionList = userDefaultsData.getSearchTourOffline() ?? [GetSearchTourResponseModel]()
        }
        Bundle.main.loadNibNamed(String(describing: ExcSelectCustomView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.buttonTour.clipsToBounds = true
        self.buttonTour.layer.cornerRadius = 10
        self.buttonTour.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
        self.buttonPaxes.clipsToBounds = true
        self.buttonPaxes.layer.cornerRadius = 10
        self.buttonPaxes.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
        self.buttonDefault.clipsToBounds = true
        self.buttonDefault.layer.cornerRadius = 10
        self.buttonDefault.layer.maskedCorners = [.layerMinXMinYCorner]
        self.buttonPromotion.clipsToBounds = true
        self.buttonPromotion.layer.cornerRadius = 10
        self.buttonPromotion.layer.maskedCorners = [.layerMaxXMinYCorner]
        self.buttonPromotion.layer.borderWidth = 1
        self.buttonPromotion.backgroundColor = UIColor.clear
        self.buttonPromotion.layer.borderColor = UIColor.greenColor.cgColor
        self.viewMainView.backgroundColor = UIColor.grayColor
        self.buttonTour.backgroundColor = UIColor.greenColor
        self.buttonDefault.backgroundColor = UIColor.greenColor
        self.buttonPaxes.layer.borderWidth = 1
        self.buttonPaxes.backgroundColor = UIColor.clear
        self.buttonPaxes.layer.borderColor = UIColor.greenColor.cgColor
        self.tableView.backgroundColor = UIColor.tableViewColor
        self.labelExcursion.addLine(position: .bottom, color: .lightGray, width: 1.0)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ExcursionListTableViewCell.nib, forCellReuseIdentifier: ExcursionListTableViewCell.identifier)
    }
}

extension ExcSelectCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.excursionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExcursionListTableViewCell.identifier) as! ExcursionListTableViewCell
        cell.labelExcursion.text = self.excursionList[indexPath.row].tourName
        cell.labelPickupTime.text = self.excursionList[indexPath.row].pickUpTime
       // cell.labelSeat.text = self.excursionList[indexPath.row] // yok
        cell.labelPriceType.text = String(self.excursionList[indexPath.row].priceType ?? 0) // pricetypedesc mi yoksa pricetype mı?
        cell.labelCurrency.text = self.excursionList[indexPath.row].currencyDesc // currencyy mi yoksa currencyDesc mi?
        cell.labelAdultPrice.text = String(self.excursionList[indexPath.row].adultPrice ?? 0)
        cell.labelChildPrice.text = String(self.excursionList[indexPath.row].childPrice ?? 0)
        cell.labelInfantPrice.text = String(self.excursionList[indexPath.row].infantPrice ?? 0)
        cell.labelToodlePrice.text = String(self.excursionList[indexPath.row].toodlePrice ?? 0)
        cell.labelMinPrice.text = String(self.excursionList[indexPath.row].minPrice ?? 0)
        cell.labelMinPax.text = String(self.excursionList[indexPath.row].minPax ?? 0)
        cell.labelTotalPrice.text = String(self.excursionList[indexPath.row].totalPrice ?? 0)
        cell.labelFlatPricw.text = String(self.excursionList[indexPath.row].flatPrice ?? 0)
        return cell
    }
}


