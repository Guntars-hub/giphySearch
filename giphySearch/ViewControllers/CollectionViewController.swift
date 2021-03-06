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
    var fetchingMore = false
    
    var network = GifNetwork()
    var gifs = [Gif]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(UINib(nibName: "gifCell", bundle: nil), forCellWithReuseIdentifier: "gifCell")
        setup()
        // Do any additional setup after loading the view.
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // Search
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Whats your favorite gif?"
        searchBar.returnKeyType = .search
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       gifs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GifCell
    
        cell.configure(gif: gifs[indexPath.row])
            print("configured cell at \(indexPath)")
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch(gif: gifs)
            }
        }
    }
    
    func beginBatchFetch(gif: [Gif]) {
        fetchingMore = true
        let newItems = gif
        self.gifs.append(contentsOf: newItems)
        
        self.fetchingMore = false
        self.collectionView.reloadData()
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



