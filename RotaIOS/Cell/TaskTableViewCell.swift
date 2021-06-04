//
//  TaskTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 3.06.2021.
//

import UIKit

class TaskTableViewCell: BaseTableViewCell {

    @IBOutlet weak var labelNAme: UILabel!
    @IBOutlet weak var checkBox: CheckBoxView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
