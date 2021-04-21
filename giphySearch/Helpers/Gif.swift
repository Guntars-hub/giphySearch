//
//  Gif.swift
//  giphySearch
//
//  Created by guntars.grants on 16/04/2021.
//

import Foundation
/// Array of Gif objects.
public struct GifArray: Decodable {
    var gifs: [Gif]
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}
/// Contains giph properties
struct Gif: Decodable {
    var gifSources: GifImages
    enum CodingKeys: String, CodingKey {
        case gifSources = "images"
    }
    /// Returns download url of the originial gif
    func getGifURL() -> String{
        return gifSources.original.url
    }
}
/// Stores the original Gif
struct GifImages: Decodable {
    var original: original
    enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}
/// URL to data of Gif
struct original: Decodable {
    var url: String
}
