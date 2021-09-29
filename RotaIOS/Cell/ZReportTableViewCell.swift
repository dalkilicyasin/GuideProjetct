//
//  ZReportTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 21.09.2021.
//

import UIKit

class ZReportTableViewCell: BaseTableViewCell {
    @IBOutlet weak var viewDetailContentView: UIView!
    @IBOutlet weak var labelGuideName: UILabel!
    @IBOutlet weak var labelZreportNo: UILabel!
    @IBOutlet weak var labelZreportDay: UILabel!
    @IBOutlet weak var labelCollectionStatus: UILabel!
    var viewZReportLongClickMenu : ZReportLongClickMenu?
    var clicked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewDetailContentView.layer.cornerRadius = 10
        self.viewDetailContentView.backgroundColor = UIColor.mainTextColor
 
        let longPressOnContentView = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(gestureReconizer:)))
        longPressOnContentView.minimumPressDuration = 2.0
        longPressOnContentView.delaysTouchesBegan = true
        longPressOnContentView.delegate = self
        self.contentView.addGestureRecognizer(longPressOnContentView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func longPressed(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state == .began {
            self.clicked = !self.clicked
            if let topVC = UIApplication.getTopViewController() {
                UIView.animate(withDuration: 0, animations: {
                    self.viewZReportLongClickMenu = ZReportLongClickMenu()
                    self.viewZReportLongClickMenu?.zReportNo = Int(self.labelZreportNo.text ?? "") ?? 0
                    self.viewZReportLongClickMenu!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    topVC.view.addSubview(self.viewZReportLongClickMenu!)
                }, completion: { (finished) in
                    if finished{
                    }
                })
            }
        }
        else {
            //When lognpress is finish
            print("finish")
        }
    }
}

