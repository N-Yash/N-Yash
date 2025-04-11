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
    var selectedDrinkId: String? // Store the selected drink ID

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
        tableView.reloadData()
    }

    func drinksLoaded(_ drinks: [DrinkPreviewModel]) {
        self.drinks = drinks
        print(self.drinks.count)
        tableView.reloadData()
    }

    func drinkDetailsLoaded(_ drinkDetails: DrinkDetailsModel) {
        tableView.reloadData()
    }

    func imageDownloaded(_ image: UIImage?, for url: String) {
        tableView.reloadData()
    }

    func dataFetchFailed(with error: NetworkError) {
        print("Error fetching data: \(error)")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as? DrinkTableViewCell
        let drink = drinks[indexPath.row]
        print(drink.strDrink)
        cell!.drinkNameLabel?.text = drink.strDrink
        cell!.drinkImageView?.image = nil

        NetworkManager.shared.downloadImage(from: drink.strDrinkThumb) { image in
            DispatchQueue.main.async {
                cell!.drinkImageView?.image = image
                cell?.setNeedsLayout()
            }
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDrinkId = drinks[indexPath.row].idDrink // Store the ID
        performSegue(withIdentifier: "ShowDrinkDetails", sender: self) // Trigger the segue
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDrinkDetails",
           let destinationVC = segue.destination as? DrinkDetailsViewController,
           let drinkId = selectedDrinkId {
            destinationVC.drinkId = drinkId
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
