//
//  BaseViewController.swift
//  RotaIOS
//
//  Created by Akif Demirezen on 12.06.2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle  = .light
        }
    }

}
