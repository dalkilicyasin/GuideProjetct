//
//  ShopAppointmentViewController.swift
//  Rota
//
//  Created by Yasin Dalkilic on 18.04.2021.
//

import UIKit

class ShopAppointmentViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        

       let userId = userDefaultsData.getUserId()
        print(userId)
        

    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
   
    }

    @IBAction func backButton(_ sender: Any) {
        self.otiPushViewController(viewController: MainPAgeViewController())
    }
    
}




