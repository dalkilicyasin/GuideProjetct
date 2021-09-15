//
//  SpeakingHoursTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 15.09.2021.
//

import UIKit

class SpeakingHoursTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewDetailContentView: UIView!
    @IBOutlet weak var labelGuideName: UILabel!
    @IBOutlet weak var labelHotel: UILabel!
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var labelStartTime: UILabel!
    @IBOutlet weak var labelSpeakingDays: UILabel!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var labelEndTime: UILabel!
    
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
