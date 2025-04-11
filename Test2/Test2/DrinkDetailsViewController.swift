//
//  DrinkDetailsViewController.swift
//  Test2
//
//  Created by Yash Vipul Naik on 2025-04-11.
//

//
//  DrinkDetailsViewController.swift
//
import UIKit

class DrinkDetailsViewController: UIViewController, NetworkManagerDelegate {

    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var alcoholicLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!

    var drinkId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.delegate = self
        loadDrinkDetails()
    }

    func loadDrinkDetails() {
        guard let drinkId = drinkId else { return }
        NetworkManager.shared.fetchDrinkDetails(drinkId: drinkId)
    }

    // MARK: - NetworkManagerDelegate

    func drinksLoaded(_ drinks: [DrinkPreviewModel]) {
        // Not used in this ViewController, but required by the protocol
    }

    func drinkDetailsLoaded(_ drink: DrinkDetailsModel) {
        drinkNameLabel.text = drink.strDrink
        categoryLabel.text = "Category: \(drink.strCategory)"
        alcoholicLabel.text = "Alcoholic: \(drink.strAlcoholic)"

        if let instructions = drink.strInstructions, !instructions.isEmpty {
            instructionsLabel.text = "Instructions: \(instructions)"
        } else if let instructionsES = drink.strInstructionsES, !instructionsES.isEmpty {
            instructionsLabel.text = "Instructions (ES): \(instructionsES)"
        } else if let instructionsDE = drink.strInstructionsDE, !instructionsDE.isEmpty{
            instructionsLabel.text = "Instructions (DE): \(instructionsDE)"
        } else{
            instructionsLabel.text = "Instructions: Not available"
        }

        NetworkManager.shared.downloadImage(from: drink.strDrinkThumb) { image in
            DispatchQueue.main.async {
                self.drinkImageView.image = image
            }
        }
    }

    func imageDownloaded(_ image: UIImage?, for url: String) {
        // Handled directly in drinkDetailsLoaded
    }

    func dataFetchFailed(with error: NetworkError) {
        print("Error fetching drink details: \(error)")
        // Handle error (e.g., show an alert)
    }
}
