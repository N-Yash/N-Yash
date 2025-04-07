//
//  ViewController.swift
//  Assignment4
//
//  Created by Yash on 2025-04-06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let call = NetworkManager.shared
        call.fetchJobData()
        // Do any additional setup after loading the view.
    }


}

