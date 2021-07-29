//
//  AnnoucmentsDetailTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.07.2021.
//

import UIKit

class AnnoucmentsDetailTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewAnnoucmentDetailView: UIView!
    @IBOutlet weak var labelSenderName: UILabel!
    @IBOutlet weak var labelAnnoucmentsDetailDate: UILabel!
    @IBOutlet weak var imageUp: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewContentView.backgroundColor = UIColor.mainViewColor
        self.imageUp.image = UIImage(named: "up")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        self.viewAnnoucmentDetailView.clipsToBounds = true
        self.viewAnnoucmentDetailView.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            self.viewAnnoucmentDetailView.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            self.viewAnnoucmentDetailView.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
