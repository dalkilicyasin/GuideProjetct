//
//  MyShopingSalesDetailTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import UIKit

class MyShopingSalesDetailTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var labelShopDate: UILabel!
    @IBOutlet weak var labelTourName: UILabel!
    @IBOutlet weak var labelHotelName: UILabel!
    @IBOutlet weak var labelOperatorNAme: UILabel!
    @IBOutlet weak var labelPickUpTime: UILabel!
    @IBOutlet weak var labelPlates: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelShoppingGuideNote: UILabel!
    @IBOutlet weak var labelPaxes: UILabel!
    @IBOutlet weak var labelRoom: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTotalPax: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewContentView.layer.cornerRadius = 10
        self.viewContentView.backgroundColor = UIColor.mainTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
