//
//  PreviewViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 15.10.2021.
//

import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var touchView: UIView!
    var nameList = ["a","a","a","a","a","a","a","a","a","a","a","a","a","a","a","a"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddStepTableViewCell.nib, forCellReuseIdentifier: AddStepTableViewCell.identifier)
        self.tableView.estimatedRowHeight = 200
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touchIcon))
        self.touchView.addGestureRecognizer(gesture)
    }
    
    @objc func touchIcon() {
        print("touch")
    }
}

extension PreviewViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddStepTableViewCell.identifier) as! AddStepTableViewCell
        cell.labelText.text = self.nameList[indexPath.row]
        return cell
    }  
}
