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
    /// ImageView to contain our gif.
    var gifView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        // Make sure cell has a gif object
        if gif != nil {
            // Grab gif from gif object and display it inside the imageview
            let gifURL = gif!.getGifURL()
            gifView.image = UIImage.gif(url: gifURL)
            gifView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            addSubview(gifView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
