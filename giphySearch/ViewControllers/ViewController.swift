//
//  ViewController.swift
//  giphySearch
//
//  Created by guntars.grants on 16/04/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var network = GifNetwork()
    var gifs = [Gif]()
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Whats your favorite gif?"
        searchBar.returnKeyType = .search
    }
    
    /**
        Fetches gifs based on the search term and populates collectionView
        - Parameter searchTerm: The string to search gifs of
        */
        func searchGifs(for searchText: String) {
            network.fetchGifs(searchTerm: searchText) { gifArray in
                if gifArray != nil {
                    self.gifs = gifArray!.gifs
                    self.tableView.reloadData()
                }
            }
        }
}


// MARK: - Search bar functions
extension ViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
                searchGifs(for: textField.text!)
        }
        return true
    }
}
