//
//  BaseCollectionViewCell.swift
//  Rota
//
//  Created by Yasin Dalkilic on 20.04.2021.
//

import Foundation

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
