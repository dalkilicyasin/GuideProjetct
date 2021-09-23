//
//  ZReportTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 21.09.2021.
//

import UIKit

class ZReportTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewDetailContentView: UIView!
    @IBOutlet weak var labelGuideName: UILabel!
    @IBOutlet weak var labelZreportNo: UILabel!
    @IBOutlet weak var labelZreportDay: UILabel!
    @IBOutlet weak var labelCollectionStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewDetailContentView.layer.cornerRadius = 10
        self.viewDetailContentView.backgroundColor = UIColor.mainTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
