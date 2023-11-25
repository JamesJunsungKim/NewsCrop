//
//  PhotoListRequest.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import Foundation

struct PhotoListRequest: APIRequestType {
    typealias Response = PhotoAsset
    
    var path: String { return "/photos" }
}

