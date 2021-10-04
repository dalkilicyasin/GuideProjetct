//
//  DocumentsView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 28.07.2021.
//

import Foundation
import UIKit

final class DocumentsView : UIView {
    @IBOutlet weak var viewHeaderDetailCustomView: HeaderDetailCustomView!
    @IBOutlet weak var tableView: UITableView!
    var announcementsDetail : [Record] = []
    var fileURLInView = ""
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderDetailCustomView.labelHeaderDetailView.text = "Documents"
        self.tableView.backgroundColor = UIColor.grayColor
        self.tableView.layer.cornerRadius = 10
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        let getGuideAnnoucementsRequestModel = GetGuideAnnouncementsRequestModel(GuideId: userDefaultsData.getGuideId(), MainType: 369)
        NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .GetGuideAnnoucemenstAndDocuments, method: .get, parameters: getGuideAnnoucementsRequestModel.requestPathString()) { (response : GetGuideAnnouncementsAndDocumentsResponseModel) in
            if response.isSuccesful == true {
                self.announcementsDetail = response.record ?? []
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.register(DocumentsTableViewCell.nib, forCellReuseIdentifier: DocumentsTableViewCell.identifier)
                self.tableView.reloadData()
            }else{
                print("hata")
            }
        }
    }
    
    required init(customParamArg: String) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DocumentsView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announcementsDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocumentsTableViewCell.identifier) as! DocumentsTableViewCell
        cell.labelDocumentsHeader.text = self.announcementsDetail[indexPath.row].header
        cell.labelDocumentsDescription.text = self.announcementsDetail[indexPath.row].description
        cell.buttonFileUrl.setTitle(self.announcementsDetail[indexPath.row].fileUrl, for: .normal)
        //self.fileURLInView = self.announcementsDetail[0].fileUrl ?? ""
        let stringWithoutSpaces = (self.announcementsDetail[indexPath.row].fileUrl ?? "www.google.com").replacingOccurrences(of: " ", with: "%20")
        cell.fileURL = stringWithoutSpaces
        print(stringWithoutSpaces)
        return cell
    }
}
