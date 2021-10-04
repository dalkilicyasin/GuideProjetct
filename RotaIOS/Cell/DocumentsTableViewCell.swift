//
//  DocumentsTableViewCell.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 28.07.2021.
//

import UIKit

class DocumentsTableViewCell: BaseTableViewCell {

    @IBOutlet weak var buttonFileUrl: UIButton!
    @IBOutlet weak var viewDocumentsContentView: UIView!
    @IBOutlet weak var viewDocumentsView: UIView!
    @IBOutlet weak var labelDocumentsHeader: UILabel!
    @IBOutlet weak var labelDocumentsDescription: UILabel!
    var fileURL = ""
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.viewDocumentsContentView.backgroundColor = UIColor.mainViewColor
        self.viewDocumentsView.backgroundColor = UIColor.mainTextColor
        self.viewDocumentsView.layer.cornerRadius = 10
        self.viewDocumentsView.clipsToBounds = true
        print(self.fileURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func fileUrlClickedButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: self.fileURL )! as URL , options: [:], completionHandler: nil)
    }
}
