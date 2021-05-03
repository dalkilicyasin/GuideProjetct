//
//  HotelListCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 2.05.2021.
//

import Foundation


import Foundation

import UIKit

class HotelListCustomView : UIView {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    
    var hotelList = ["Xanadu Resort","Otium Family Eco","Seven Seas Hotel","Seven Seas Hotel Life"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: HotelListCustomView.self), owner: self, options: nil)
        self.headerView.addCustomContainerView(self)
        self.headerView.backgroundColor = UIColor.clear

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddStepTableViewCell.nib, forCellReuseIdentifier: AddStepTableViewCell.identifier)

    }

}

extension HotelListCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddStepTableViewCell.identifier) as! AddStepTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
    }

}
