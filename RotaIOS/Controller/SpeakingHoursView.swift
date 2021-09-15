//
//  SpeakingHoursView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 11.09.2021.
//

import Foundation
import UIKit

final class SpeakingHoursView : UIView {
    @IBOutlet weak var viewHeaderView: HeaderDetailCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewRegion: MainTextCustomView!
    @IBOutlet weak var viewHotel: MainTextCustomView!
    @IBOutlet weak var viewDate: MainTextCustomView!
    @IBOutlet weak var viewGuide: MainTextCustomView!
    @IBOutlet weak var buttonSearchButton: UIButton!
    @IBOutlet weak var searchHotel: UISearchBar!
    @IBOutlet weak var searchGuide: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderView.labelHeaderDetailView.text = "Speaking Hours"
        self.viewContentView.layer.cornerRadius = 10
        self.viewContentView.backgroundColor = UIColor.grayColor
        self.viewRegion.headerLAbel.text = "Area"
        self.viewHotel.headerLAbel.text = "Hotel"
        self.viewDate.headerLAbel.text = "Date"
        self.viewGuide.headerLAbel.text = "Guide"
        self.viewDate.mainLabel.isHidden = true
        self.viewDate.imageMainText.isHidden = true
        self.viewDate.mainText.isHidden = false
        self.buttonSearchButton.layer.cornerRadius = 10
        self.buttonSearchButton.backgroundColor = UIColor.greenColor
        self.searchHotel.setImage(UIImage(), for: .search, state: .normal)
        self.searchHotel.layer.cornerRadius = 10
        self.searchHotel.compatibleSearchTextField.textColor = UIColor.white
        self.searchHotel.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
        self.searchGuide.setImage(UIImage(), for: .search, state: .normal)
        self.searchGuide.layer.cornerRadius = 10
        self.searchGuide.compatibleSearchTextField.textColor = UIColor.white
        self.searchGuide.compatibleSearchTextField.backgroundColor = UIColor.mainTextColor
    }
 
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
