//
//  ExcursionView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 17.11.2021.
//
import Foundation
import UIKit

final class ExcursionView : UIView {
    @IBOutlet weak var viewHeaderDetailView: HeaderDetailCustomView!
    @IBOutlet weak var viewAppointmentView: AppointmentBarCustomView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewFooterCustomView: FooterCustomView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewOfflineLabel: UIView!
    
    override func awakeFromNib() {
        self.viewAppointmentView.collectionList = ["Search","Select","Add","Proceed" ]
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Excursion Sale"
        self.viewOfflineLabel.isHidden = true
    }
    
    func buttonAddButtonChange(){
        self.viewFooterCustomView.buttonAddButton.isHidden = false
        self.viewFooterCustomView.buttonAddButton.setTitle("SAVE", for: .normal)
        self.viewFooterCustomView.buttonAddButton.backgroundColor = UIColor.clear
        self.viewFooterCustomView.buttonAddButton.layer.borderWidth = 1
        self.viewFooterCustomView.buttonAddButton.layer.borderColor = UIColor.greenColor.cgColor
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
