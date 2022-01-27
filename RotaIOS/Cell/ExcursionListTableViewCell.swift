//
//  ExcursionListTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 3.12.2021.
//

import UIKit

protocol ExcursionListTableViewCellDelegate {
    func checkBoxTapped(checkCounter : Bool, tourid : Int, tourDate : String, tempPaxes : GetSearchTourResponseModel, priceTypeDesc : Int, pickUpTime : String)
}

class ExcursionListTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var imageCheckBox: UIImageView!
    @IBOutlet weak var labelExcursion: UILabel!
    @IBOutlet weak var labelTourdate: UILabel!
    @IBOutlet weak var labelPriceType: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var labelAdultPrice: UILabel!
    @IBOutlet weak var labelChildPrice: UILabel!
    @IBOutlet weak var labelInfantPrice: UILabel!
    @IBOutlet weak var labelToodlePrice: UILabel!
    @IBOutlet weak var labelMinPrice: UILabel!
    @IBOutlet weak var labelMinPax: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    @IBOutlet weak var labelFlatPricw: UILabel!
    @IBOutlet weak var labelPickUpTime: UILabel!
    var excursionListInCell : GetSearchTourResponseModel?
    var excursionListTableViewCellDelegate : ExcursionListTableViewCellDelegate?
    var isTappedCheck = false
    var tourid = 0
    var priceTypeDesc = 0
    var pickuptime = ""
    var tourDate = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.imageCheckBox.image = UIImage(named: "square")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedChecBox))
        self.imageCheckBox.isUserInteractionEnabled = true
        self.imageCheckBox.addGestureRecognizer(gesture)
    }
    
    @objc func tappedChecBox(){
        self.isTappedCheck = !self.isTappedCheck
        self.excursionListTableViewCellDelegate?.checkBoxTapped(checkCounter: self.isTappedCheck, tourid: self.tourid, tourDate: self.tourDate, tempPaxes: self.excursionListInCell!, priceTypeDesc : self.priceTypeDesc, pickUpTime: self.pickuptime)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.isTappedCheck == true {
            print(tourid)
            self.imageCheckBox.image = UIImage(named: "check")
        }else {
            self.imageCheckBox.image = UIImage(named: "square")
        }
    }
}
