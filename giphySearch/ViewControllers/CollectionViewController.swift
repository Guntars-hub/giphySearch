//
//  CollectionViewController.swift
//  giphySearch
//
//  Created by guntars.grants on 20/04/2021.
//

import UIKit

private let reuseIdentifier = "gifCell"

class CollectionViewController: UICollectionViewController {

   
    @IBOutlet var searchBar: UISearchBar!
    
    

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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return gifs.count
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
