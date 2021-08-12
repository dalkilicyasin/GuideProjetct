//
//  MyTourStatusTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.08.2021.
//

import UIKit

class MyTourStatusTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewContetView: UIView!
    @IBOutlet weak var viewCheckBoxView: CheckBoxView!
    @IBOutlet weak var labelStatusText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewContetView.backgroundColor = UIColor.grayColor
        self.labelStatusText.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
