//
//  FavoriteCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 24.05.2021.
//

import Foundation

import UIKit

protocol FavoriteCustomViewDelegate {
    func favoriteTapped(isremember : Bool)
}

class FavoriteCustomView: UIView{
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageFavoriteEmpty: UIImageView!
    @IBOutlet weak var imageFavoriteFull: UIImageView!
    var favoriteCustomViewDelegate : FavoriteCustomViewDelegate?
    var isCheckRemember = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: FavoriteCustomView.self), owner: self, options: nil)
        self.contentView.addCustomContainerView(self)
        self.imageFavoriteFull.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTabFavorite))
        self.contentView.addGestureRecognizer(gesture)
        self.imageFavoriteEmpty.image = UIImage(named: "favoriteempty")
        self.imageFavoriteFull.image = UIImage(named: "favoritefiiled")
    }
    
    @objc func didTabFavorite() {
        self.isCheckRemember = !isCheckRemember
        if self.isCheckRemember{
            self.imageFavoriteFull.isHidden = false
            self.favoriteCustomViewDelegate?.favoriteTapped(isremember: true)
        }else {
            self.imageFavoriteFull.isHidden = true
            self.favoriteCustomViewDelegate?.favoriteTapped(isremember: false)
        }
    }
}
