//
//  MyTourSaleViewController.swift
//  Rota
//
//  Created by Yasin Dalkilic on 18.04.2021.
//

import UIKit

class MyTourSaleViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func backButton(_ sender: Any) {
        self.otiPushViewController(viewController: MainPAgeViewController())
    }
    

}
