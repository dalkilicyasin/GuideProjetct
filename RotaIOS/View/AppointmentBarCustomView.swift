//
//  ShopAppCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 20.04.2021.
//

import Foundation
import UIKit

protocol HomePageTappedDelegate {
    func homePageTapped(ischosen : Int)
}

class  AppointmentBarCustomView : UIView {
  
    var homePageTappedDelegate : HomePageTappedDelegate?
    var selectedIndex = IndexPath(row: 0, section: 0)
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionList : [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        self.collectionView.layer.cornerRadius = 20
        self.collectionView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: AppointmentBarCustomView.self), owner: self, options: nil)
        self.viewHeader.addCustomContainerView(self)
        
       let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left:0 , bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/4, height: 130)
        layout.minimumLineSpacing = 1
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ApponintmentBarCollectionViewCell.nib, forCellWithReuseIdentifier: ApponintmentBarCollectionViewCell.identifier)
    }
}

extension AppointmentBarCustomView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApponintmentBarCollectionViewCell.identifier, for: indexPath) as! ApponintmentBarCollectionViewCell
        cell.labelText.text = collectionList[indexPath.row]
        
        if selectedIndex == indexPath {
            cell.backgroundColor = UIColor.green
            
        }else{
            cell.backgroundColor = UIColor.mainTextColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        self.selectedIndex = indexPath
        switch(indexPath.row) {
        case 0 :
            self.homePageTappedDelegate?.homePageTapped(ischosen: 0)
        case 1 :
            self.homePageTappedDelegate?.homePageTapped(ischosen: 1)
        case 2 :
            self.homePageTappedDelegate?.homePageTapped(ischosen: 2)
        case 3 :
            self.homePageTappedDelegate?.homePageTapped(ischosen: 3)
        
        default :
            print("selected")
            
        }
        self.collectionView.reloadData()
    }
}

