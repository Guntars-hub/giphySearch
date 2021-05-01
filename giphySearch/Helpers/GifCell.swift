//
//  GifCell.swift
//  giphySearch
//
//  Created by guntars.grants on 16/04/2021.
//

import UIKit
class GifCell: UICollectionViewCell {
    /// Gif to be displayed.
    
    @IBOutlet var gifView: UIImageView!
    var gifURL = String()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /// ImageView to contain our gif.
    func configure(gif: Gif?) {
        if let gif = gif {
            // Grab gif from gif object and display it inside the imageview
            gifURL = gif.getGifURL()
            //print(gifURL)
            gifView.loadGif(url: gifURL)
            gifView.frame = CGRect(origin: .zero, size: bounds.size)
            addSubview(gifView)
        }
    }
}
