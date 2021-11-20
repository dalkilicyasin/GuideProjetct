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
    
    override func awakeFromNib() {
        self.viewAppointmentView.collectionList = ["Search","Select","Add","Proceed" ]
        self.viewHeaderDetailView.labelHeaderDetailView.text = "Excursion Sale"
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
