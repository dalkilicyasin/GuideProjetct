//
//



import Foundation

import UIKit

protocol SendFavoriteInfoDelegate {
    func sendFavoriteInfo(sendinfo : String)
}

class FavoriteListCustomView : UIView {
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var viewRemoveButton: UIView!
    @IBOutlet weak var viewSlideUp: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var selectList : [GetSelectListResponseModel] = []
    var stepsSelectedNameList : StepsPageCustomView?
    var sendFavoriteInfoDelegate : SendFavoriteInfoDelegate?
    var addedNameList : [String] = []
    var infoList : [String] = []
    var addFavoriteList : [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(String(describing: FavoriteListCustomView.self), owner: self, options: nil)
        self.headerView.addCustomContainerView(self)
        
        if userDefaultsData.getFavorite()?.count ?? 0 > 0 {
            for item in userDefaultsData.getFavorite() {
            
                self.addedNameList.append(item)
            }
            self.addedNameList = userDefaultsData.getFavorite()
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.headerView.backgroundColor = UIColor.mainViewColor
        self.viewRemoveButton.roundCorners(.allCorners, radius: 10)
        self.topView.layer.borderWidth = 1
        self.topView.backgroundColor = UIColor.mainViewColor
        self.topView.layer.cornerRadius = 10
        
        let tappedSlideUp = UITapGestureRecognizer(target: self, action: #selector(slideUpTapped))
        self.viewSlideUp.addGestureRecognizer(tappedSlideUp)
        self.viewSlideUp.isUserInteractionEnabled = true
        self.tableView.register(AddStepTableViewCell.nib, forCellReuseIdentifier: AddStepTableViewCell.identifier)
    }
    
    @objc func slideUpTapped() {
        self.removeFromSuperview()
    }
}

extension FavoriteListCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.addedNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddStepTableViewCell.identifier) as! AddStepTableViewCell
        cell.viewFavorite.isHidden = true
        cell.labelText.text = addedNameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.infoList.append(addedNameList[indexPath.row])
        self.sendFavoriteInfoDelegate?.sendFavoriteInfo(sendinfo: self.infoList[0])
        
        self.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.addedNameList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            userDefaultsData.saveFavorite(id: self.addedNameList)
        }
    }
}
