//
//  ViewController.swift
//  Test2
//
//  Created by Yash Vipul Naik on 2025-04-11.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alcoholicSwitch: UISwitch!

    var drinks: [DrinkPreviewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NetworkManager.shared.delegate = self
        loadDrinks(alcoholic: alcoholicSwitch.isOn)
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        loadDrinks(alcoholic: sender.isOn)
    }

    func loadDrinks(alcoholic: Bool) {
        NetworkManager.shared.fetchDrinks(alcoholic: alcoholic)
    }

    // MARK: - NetworkManagerDelegate

    func drinksLoaded(_ drinks: [DrinkPreviewModel]) {
        self.drinks = drinks
        tableView.reloadData()
    }

    func drinkDetailsLoaded(_ drinkDetails: DrinkDetailsModel) {
        // Not used in this ViewController, but required by the protocol
    }

    func imageDownloaded(_ image: UIImage?, for url: String) {
        tableView.reloadData()
    }

    func dataFetchFailed(with error: NetworkError) {
        print("Error fetching data: \(error)")
        // Handle error (e.g., show an alert)
    }

    // MARK: - Table View Delegate & Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath)
        let drink = drinks[indexPath.row]
        cell.textLabel?.text = drink.strDrink

        NetworkManager.shared.downloadImage(from: drink.strDrinkThumb) { image in
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDrink = drinks[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DrinkDetailsViewController") as? DrinkDetailsViewController {
            detailsVC.drinkId = selectedDrink.idDrink
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
