//
//  GifCell.swift
//  giphySearch
//
//  Created by guntars.grants on 16/04/2021.
//

import UIKit
class GifCell: UICollectionViewCell {
    /// Gif to be displayed.
    var gif: Gif?
    
    @IBOutlet var gifView: UIImageView!
    /// ImageView to contain our gif.
    override func layoutSubviews() {
        super.layoutSubviews()
        // Make sure cell has a gif object
        if let gif = gif {
            // Grab gif from gif object and display it inside the imageview
            let gifURL = gif.getGifURL()
            gifView.image = UIImage.gif(url: gifURL)
            gifView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            addSubview(gifView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
