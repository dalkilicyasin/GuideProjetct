//
//  AddStepTableViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//

import UIKit

protocol TouchFavoriteDelegate {
    func touchfavoriteTapped( favoriteİsremember : Bool, touch : String)
}

class AddStepTableViewCell: BaseTableViewCell {
 
    @IBOutlet weak var imageFavoriteIcon: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    var touchDelegate : TouchFavoriteDelegate?
    var isTappedFavorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code 
        self.imageFavoriteIcon.image = UIImage(named: "favoriteempty")
        self.selectionStyle = .none
       // self.viewFavorite.favoriteCustomViewDelegate = self
        let gestureFavorite = UITapGestureRecognizer(target: self, action: #selector(touchFavorite))
        self.imageFavoriteIcon.isUserInteractionEnabled = true
        self.imageFavoriteIcon.addGestureRecognizer(gestureFavorite)
    }
    
    @objc func touchFavorite() {
        self.isTappedFavorite = !self.isTappedFavorite
        self.touchDelegate?.touchfavoriteTapped(favoriteİsremember: self.isTappedFavorite, touch: self.labelText.text ?? "")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isTappedFavorite == true {
            self.imageFavoriteIcon.image = UIImage(named: "favoritefiiled")
        }else {
            self.imageFavoriteIcon.image = UIImage(named: "favoriteempty")
        }
    }
}

extension AddStepTableViewCell : FavoriteCustomViewDelegate {
    func favoriteTapped(isremember: Bool) {
        print(isremember)
    }
}


