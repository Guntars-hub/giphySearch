//
//  CollectionViewController.swift
//  giphySearch
//
//  Created by guntars.grants on 20/04/2021.
//

import UIKit

private let reuseIdentifier = "gifCell"

class CollectionViewController: UICollectionViewController {
    var searchBar = UISearchBar()
    
    var network = GifNetwork()
    var gifs = [Gif]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
            
        collectionView!.register(UINib(nibName: "gifCell", bundle: nil), forCellWithReuseIdentifier: "gifCell")
        setup()
        awakeFromNib()
        
        // Do any additional setup after loading the view.
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        //Search
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Whats your favorite gif?"
        searchBar.returnKeyType = .search
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
       gifs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GifCell
    
        cell.gif = gifs[indexPath.row]
        return cell
    
    }
    
    func searchGifs(for searchText: String) {
        network.fetchGifs(searchTerm: searchText) { gifArray in
            if gifArray != nil {
                self.gifs = gifArray!.gifs
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Search bar functions
extension CollectionViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
                searchGifs(for: textField.text!)
        }
        return true
    }
}

