//
//  AnnoucmentsTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.07.2021.
//

import UIKit

class AnnoucmentsTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewAnnoucmentsView: UIView!
    @IBOutlet weak var labelAnnoucmentsCellHeader: UILabel!
    @IBOutlet weak var labelAnnoucmentsCellDate: UILabel!
    @IBOutlet weak var labelAnnoucmentsCellDateHeader: UILabel!
    @IBOutlet weak var imageDown: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewContentView.backgroundColor = UIColor.mainViewColor
        self.imageDown.image = UIImage(named: "down")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        self.viewAnnoucmentsView.clipsToBounds = true
        self.viewAnnoucmentsView.layer.cornerRadius = 10
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
