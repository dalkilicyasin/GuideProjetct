//
//  TempTouristAddCustomView.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.05.2021.
//

import Foundation

import UIKit

class TempTouristAddCustomView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var addManuelTouristAddCustomView : AddManuelTouristCustomView?
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var buttonManuelAdd: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var nameListed : [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        self.slideIdicator.roundCorners(.allCorners, radius: 10)
        self.buttonManuelAdd.layer.cornerRadius = 10
        self.buttonManuelAdd.layer.masksToBounds = true
        self.buttonManuelAdd.layer.borderWidth = 1
        self.buttonManuelAdd.layer.borderColor = UIColor.green.cgColor
   
        self.contentView.backgroundColor = UIColor.grayColor
        self.contentView.layer.cornerRadius = 10
        self.tableView.backgroundColor = UIColor.grayColor
     
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(PaxPageTableViewCell.nib, forCellReuseIdentifier: PaxPageTableViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @IBAction func addManuelButton(_ sender: Any) {
       
        if let topVC = UIApplication.getTopViewController() {
            UIView.animate(withDuration: 0, animations: {
                self.addManuelTouristAddCustomView = AddManuelTouristCustomView()
                self.addManuelTouristAddCustomView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1200)
                topVC.view.addSubview(self.addManuelTouristAddCustomView!)
            }, completion: { (finished) in
                if finished{
                    
                }
            })
        }

        
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

extension TempTouristAddCustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameListed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaxPageTableViewCell.identifier) as! PaxPageTableViewCell
        cell.imageUserName.isHidden = false
        cell.checkBoxView.isHidden = true
        cell.labelPaxNameListCell.text = nameListed[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.nameListed.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }  
}

extension TempTouristAddCustomView : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}


