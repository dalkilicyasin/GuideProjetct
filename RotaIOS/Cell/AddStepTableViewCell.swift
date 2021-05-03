//
//  AddStepTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//

import UIKit

protocol FavoriteViewDelegate {
    func favoriteBoxTapped(isremember : Bool)
}

class AddStepTableViewCell: BaseTableViewCell {
    
    var favoriteViewDelegate : FavoriteViewDelegate?

    
    @IBOutlet weak var cornerImage: UIImageView!
    @IBOutlet weak var labelText: UILabel!
   
    @IBOutlet weak var imageFavorite: UIImageView!
    var isCheckRemember = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.cornerImage.addGestureRecognizer(tap)
        self.cornerImage.isUserInteractionEnabled = true
        
        self.imageFavorite.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    
        
      
    }
    


/*  override func layoutSublayers(of layer: CALayer) {
    searchBar.clipsToBounds = true
    searchBar.layer.cornerRadius = 10
    if #available(iOS 11.0, *) {
        searchBar.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    } else {
        // Fallback on earlier versions
    }
}*/


@objc func handleTap(_ sender: UITapGestureRecognizer) {
        
    self.isCheckRemember = !isCheckRemember
    if self.isCheckRemember{
       imageFavorite.isHidden = false
    }else {
       imageFavorite.isHidden = true
    }
    self.favoriteViewDelegate?.favoriteBoxTapped(isremember: true)
    }
 
}
