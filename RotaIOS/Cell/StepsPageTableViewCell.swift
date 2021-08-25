//
//  StepsPageTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//

import UIKit



class StepsPageTableViewCell: BaseTableViewCell {
    @IBOutlet weak var labelText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}




