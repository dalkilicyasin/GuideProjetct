//
//  MyTourStatusView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 6.08.2021.
//

import UIKit
import Foundation

protocol MyTourStatusViewDelegate {
    func myTourStatusSelectedIdList(selectedStatusIdList : [String])
}

class MyTourStatusView: UIView {
    @IBOutlet var viewMainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var statusList : [String] = ["Approved","Waiting Approval","Canceled","Rejected"]
    var selectedStatusIdList : [String] = []
    var newStatus = ""
    var myTourStatusViewDelegate : MyTourStatusViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: MyTourStatusView.self), owner: self, options: nil)
        self.viewMainView.addCustomContainerView(self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MyTourStatusTableViewCell.nib, forCellReuseIdentifier: MyTourStatusTableViewCell.identifier)
        self.tableView.allowsSelection = true
    }
}

extension MyTourStatusView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTourStatusTableViewCell.identifier) as! MyTourStatusTableViewCell
        cell.labelStatusText.text = self.statusList[indexPath.row]
        cell.myTourStatusTableViewCellDelegate = self
        return cell
    }
}

extension MyTourStatusView : MyTourStatusTableViewCellDelegate {

    func myTourStatusId(selectedStatusId: String, isremove: Bool) {
            if isremove == false {
                self.selectedStatusIdList.append(selectedStatusId)
            }else {
                self.selectedStatusIdList.remove(object: selectedStatusId)
            }
        self.myTourStatusViewDelegate?.myTourStatusSelectedIdList(selectedStatusIdList: self.selectedStatusIdList)
    }
}

