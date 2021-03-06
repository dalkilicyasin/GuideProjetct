//
//  MyShoppingSaleView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import Foundation
import UIKit

final class MyShoppingSaleView : UIView {
    @IBOutlet weak var viewHeaderDetail: HeaderDetailCustomView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var viewBeginDate: MainTextCustomView!
    @IBOutlet weak var viewEndDate: MainTextCustomView!
    @IBOutlet weak var buttonSearchButton: UIButton!
    @IBOutlet weak var viewHotelListView: MainTextCustomView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.searchBar.setImage(UIImage(), for: .search, state: .normal)
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.compatibleSearchTextField.textColor = UIColor.white
        self.searchBar.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
        self.viewHeaderDetail.labelHeaderDetailView.text = "My Shopping Sales"
        self.contentView.backgroundColor = UIColor.grayColor
        self.contentView.layer.cornerRadius = 10
        self.buttonSearchButton.layer.cornerRadius = 10
        self.buttonSearchButton.backgroundColor = UIColor.greenColor
        self.viewBeginDate.headerLAbel.text = "Begin Date"
        self.viewEndDate.headerLAbel.text = "End Date"
        self.viewHotelListView.headerLAbel.text = "Hotel"
        self.viewBeginDate.imageMainText.isHidden = true
        self.viewEndDate.imageMainText.isHidden = true
        self.viewBeginDate.mainLabel.isHidden = true
        self.viewEndDate.mainLabel.isHidden = true
        self.viewBeginDate.mainText.isHidden = false
        self.viewEndDate.mainText.isHidden = false
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
