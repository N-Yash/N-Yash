//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yash Vipul Naik on 2025-03-14.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingManager.shared.getAllCitiesFromAPI(searchTerm: "tor")
        // Do any additional setup after loading the view.
    }


}

