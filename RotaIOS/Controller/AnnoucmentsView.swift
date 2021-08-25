//
//  AnnoucmentsView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.07.2021.
//

import Foundation
import UIKit

final class AnnoucmentsView : UIView {
    @IBOutlet weak var tableView: UITableView!
    var announcementsDetail : [Record] = []
    @IBOutlet weak var viewHeaderDetailCustomView: HeaderDetailCustomView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewHeaderDetailCustomView.labelHeaderDetailView.text = "Announcements"
        self.tableView.backgroundColor = UIColor.grayColor
        self.tableView.layer.cornerRadius = 10
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        let getGuideAnnoucementsRequestModel = GetGuideAnnouncementsRequestModel(GuideId: userDefaultsData.getGuideId(), MainType: 368)
        NetworkManager.sendGetRequest(url:NetworkManager.BASEURL, endPoint: .GetGuideAnnoucemenstAndDocuments, method: .get, parameters: getGuideAnnoucementsRequestModel.requestPathString()) { (response : GetGuideAnnouncementsAndDocumentsResponseModel) in
            if response.isSuccesful == true {
                self.announcementsDetail = response.record ?? []
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.register(AnnoucmentsTableViewCell.nib, forCellReuseIdentifier: AnnoucmentsTableViewCell.identifier)
                self.tableView.register(AnnoucmentsDetailTableViewCell.nib, forCellReuseIdentifier: AnnoucmentsDetailTableViewCell.identifier)
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

extension AnnoucmentsView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.announcementsDetail.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.announcementsDetail[section].opened == true {
            return 2
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AnnoucmentsTableViewCell.identifier) as! AnnoucmentsTableViewCell
            cell.labelAnnoucmentsCellDateHeader.text = "Date Time"
            cell.labelAnnoucmentsCellDate.text = announcementsDetail[indexPath.section].sentDateTime
            cell.labelAnnoucmentsCellHeader.text = announcementsDetail[indexPath.section].header
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AnnoucmentsDetailTableViewCell.identifier) as! AnnoucmentsDetailTableViewCell
            cell.labelSenderName.text = announcementsDetail[indexPath.section].sender
            cell.labelAnnoucmentsDetailDate.text = announcementsDetail[indexPath.section].sentDateTime
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.announcementsDetail[indexPath.section].opened == true {
            self.announcementsDetail[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            if let cell = tableView.cellForRow(at: indexPath) as? AnnoucmentsTableViewCell {
                cell.labelAnnoucmentsCellDateHeader.text = "Date Time"
                cell.labelAnnoucmentsCellDate.text = self.announcementsDetail[indexPath.section].sentDateTime
            }
        }else {
            self.announcementsDetail[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            if let cell = tableView.cellForRow(at: indexPath) as? AnnoucmentsTableViewCell {
                cell.labelAnnoucmentsCellDateHeader.text = "Description"
                cell.labelAnnoucmentsCellDate.text = self.announcementsDetail[indexPath.section].description
                cell.imageDown.isHidden = true
                cell.viewAnnoucmentsView.layer.cornerRadius = 10
                if #available(iOS 11.0, *) {
                    cell.viewAnnoucmentsView.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
                } else {
                    cell.viewAnnoucmentsView.layer.cornerRadius = 10
                }
            }
        }
    }
}


