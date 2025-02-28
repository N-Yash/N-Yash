//
//  ViewController.swift
//  Yash_Naik_MidTermTest
//
//  Created by Yash Vipul Naik on 2025-02-28.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items : [Item] = [
        Item(name: "Tomato", isNecessary: false),
        Item(name: "Milk", isNecessary: false),
        Item(name: "Juice", isNecessary: true),
        Item(name: "Apple", isNecessary: true)
    ]
    
    @IBOutlet weak var newItemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var isNecessary: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let newItem = newItemTextField.text, !newItem.isEmpty {
            let newItemObejct = Item(name: newItem, isNecessary: isNecessary.isOn)
            items.append(newItemObejct)
            newItemTextField.text = ""
            tableView.reloadData()
            let alert = UIAlertController(title: "Item Added", message: "Name: \(newItem)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            
        }
        else {
            let alert = UIAlertController(title: "Enter Item", message: "Please Enter an Item", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        if item.isNecessary {
            cell.textLabel?.textColor = .red
        }
        else {
            cell.textLabel?.textColor = .green
        }
        return cell
    }
    
}
