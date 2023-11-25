//
//  PhotoAsset.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import Foundation

struct PhotoAsset: Decodable, Identifiable, Hashable {
    let id: Int
    let albumId: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
    
    static func dummy(id: Int) -> PhotoAsset  {
        return .init(id: id, albumId: 1, title: "caksndflknsadfklnsadlkfnasldkfnklsdanfl", url: URL(string: "https://via.placeholder.com/150/771796")!, thumbnailUrl: URL(string: "https://via.placeholder.com/150/771796")!)
    }
}
