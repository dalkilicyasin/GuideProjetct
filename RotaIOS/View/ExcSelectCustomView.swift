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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
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
    }
}
