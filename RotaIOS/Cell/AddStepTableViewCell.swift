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
    @IBOutlet weak var viewFavorite: FavoriteCustomView!
    @IBOutlet weak var labelText: UILabel!
    var touchDelegate : TouchFavoriteDelegate?
    var isCheckRemember = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.viewFavorite.favoriteCustomViewDelegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AddStepTableViewCell : FavoriteCustomViewDelegate {
    func favoriteTapped(isremember: Bool) {
        print(isremember)
        self.touchDelegate?.touchfavoriteTapped(favoriteİsremember: isremember, touch: self.labelText.text ?? "")
    }
}


