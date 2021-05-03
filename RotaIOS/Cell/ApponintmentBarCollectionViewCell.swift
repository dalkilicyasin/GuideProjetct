//
//  ApponintmentBarCollectionViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 20.04.2021.
//

import UIKit

class ApponintmentBarCollectionViewCell : BaseCollectionViewCell{

   
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var topView: UIView!
    var barBackgrounView = UIView()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.topView.layer.cornerRadius = 10

      /* self.barBackgrounView.backgroundColor = UIColor.greenColor
        selectedBackgroundView = barBackgrounView */
    }

}


