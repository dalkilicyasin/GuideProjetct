//
//  TouristAddCustomView.swift
//  Rota
//
//  Created by Yasin Dalkilic on 24.04.2021.
//

import Foundation

import UIKit

class TouristAddCustomView : UIView {
 
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var addManuelButton: UIButton!
    var nameList : [String] = []
    var addManuelTourist : AddManuelTouristCustomView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: TouristAddCustomView.self), owner: self, options: nil)
        self.headerView.addCustomContainerView(self)
        self.contentView.backgroundColor = UIColor.grayColor
        self.contentView.layer.cornerRadius = 10
        self.tableView.backgroundColor = UIColor.grayColor
        
        self.addManuelButton.layer.borderWidth = 1
        self.addManuelButton.layer.borderColor = UIColor.green.cgColor
        self.addManuelButton.layer.cornerRadius = 10
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PaxPageTableViewCell.nib, forCellReuseIdentifier: PaxPageTableViewCell.identifier)
        
    }
   
    @IBAction func addManuelButtonClicked(_ sender: Any) {
        //self.removeFromSuperview()
        if let topVC = UIApplication.getTopViewController() {
            UIView.animate(withDuration: 0, animations: {
                self.addManuelTourist = AddManuelTouristCustomView()
            
                self.addManuelTourist!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1200)
                topVC.view.addSubview(self.addManuelTourist!)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
        }
        
    }
    
}

extension TouristAddCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: PaxPageTableViewCell.identifier) as! PaxPageTableViewCell
        cell.imageUserName.isHidden = false
        cell.checkBoxView.isHidden = true
        cell.labelPaxNameListCell.text = nameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.nameList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }

}
    

