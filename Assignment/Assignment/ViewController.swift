//
//  ViewController.swift
//  Assignment
//
//  Created by Yash Vipul Naik on 2025-02-21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qantity: UILabel!
    @IBOutlet weak var productView: UITableView!
    
    var q = ""
    var p : Int = 0
    
    var productList : [Product] = [
        Product(productName: "Pants", productQuantity: 20, productPrice: 10),
        Product(productName: "Shoes", productQuantity: 60, productPrice: 10),
        Product(productName: "Hats", productQuantity: 10, productPrice: 10),
        Product(productName: "Tshirts", productQuantity: 10, productPrice: 10),
        Product(productName: "Dresses", productQuantity: 24, productPrice: 10)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productView.dataSource = self
        productView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let product = productList[indexPath.row]
        cell.textLabel?.text = "\(product.productName!)          \(product.productQuantity!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        lblProduct.text = product.productName
        p = product.productPrice ?? 0
    }
    
    
    @IBAction func btnQuantityClick(_ sender: UIButton) {
      
        if(lblProduct.text != "Type"){
            qantity.text! += sender.titleLabel?.text ?? ""
        }
        else {
            
        }
    }
}

