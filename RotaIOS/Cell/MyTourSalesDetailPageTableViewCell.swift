//
//  MyTourSalesDetailPageTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.08.2021.
//

import UIKit

class MyTourSalesDetailPageTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewDetailContentView: UIView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var imageToMoreDetailPage: UIImageView!
    @IBOutlet weak var labelTourDate: UILabel!
    @IBOutlet weak var labelTourName: UILabel!
    @IBOutlet weak var labelTourTime: UILabel!
    @IBOutlet weak var labelHotelName: UILabel!
    @IBOutlet weak var labelReelPax: UILabel!
    @IBOutlet weak var labelResNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageToMoreDetailPage.image = UIImage(named: "right")
        self.selectionStyle = .none
        self.viewContentView.backgroundColor = UIColor.clear
        self.viewDetailContentView.backgroundColor = UIColor.mainTextColor
        self.viewDetailContentView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
