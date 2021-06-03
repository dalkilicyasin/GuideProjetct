//
//  MainPageTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 16.04.2021.
//

import UIKit

class MainPageTableViewCell: BaseTableViewCell {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var viewMainPage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMainPage.layer.cornerRadius = 10
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
