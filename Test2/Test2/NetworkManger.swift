//
//  NetworkManger.swift
//  Test2
//
//  Created by Yash Vipul Naik on 2025-04-11.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate: AnyObject {
    func drinksLoaded(_ drinks: [DrinkPreviewModel])
    func drinkDetailsLoaded(_ drinkDetails: DrinkDetailsModel)
    func imageDownloaded(_ image: UIImage?, for url: String)
    func dataFetchFailed(with error: NetworkError)
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
    case decodingFailed
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    weak var delegate: NetworkManagerDelegate?

    private let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)

    func fetchDrinks(alcoholic: Bool) {
        let category = alcoholic ? "Alcoholic" : "Non_Alcoholic"
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=\(category)"

        guard let url = URL(string: urlString) else {
            delegate?.dataFetchFailed(with: .invalidURL)
            return
        }

        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error)")
                self?.delegate?.dataFetchFailed(with: .requestFailed)
                return
            }

            guard let data = data else {
                self?.delegate?.dataFetchFailed(with: .invalidData)
                return
            }

            do {
                let drinkList = try JSONDecoder().decode(DrinkPreviewList.self, from: data)
                self?.delegate?.drinksLoaded(drinkList.drinks)
            } catch {
                print("Decoding error: \(error)")
                self?.delegate?.dataFetchFailed(with: .decodingFailed)
            }
        }.resume()
    }

    func fetchDrinkDetails(drinkId: String) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(drinkId)"

        guard let url = URL(string: urlString) else {
            delegate?.dataFetchFailed(with: .invalidURL)
            return
        }

        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error)")
                self?.delegate?.dataFetchFailed(with: .requestFailed)
                return
            }

            guard let data = data else {
                self?.delegate?.dataFetchFailed(with: .invalidData)
                return
            }

            do {
                let drinkDetailsList = try JSONDecoder().decode(DrinkDetailsList.self, from: data)
                if let drink = drinkDetailsList.drinks.first {
                    self?.delegate?.drinkDetailsLoaded(drink)
                } else {
                    self?.delegate?.dataFetchFailed(with: .invalidData)
                }
            } catch {
                print("Decoding error: \(error)")
                self?.delegate?.dataFetchFailed(with: .decodingFailed)
            }
        }.resume()
    }

    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            delegate?.imageDownloaded(nil, for: urlString)
            return
        }

        session.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                self?.delegate?.imageDownloaded(nil, for: urlString)
                return
            }
            self?.delegate?.imageDownloaded(image, for: urlString)
        }.resume()
    }
}
