//
//  CollectionModel.swift
//  DynamicCollectionTask
//
//  Created by subramanyam on 26/11/18.
//  Copyright © 2018 nanda. All rights reserved.
//

import Foundation

typealias CollectionData = [CollectionDatum]

class CollectionDatum: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
    
    init(albumID: Int, id: Int, title: String, url: String, thumbnailURL: String) {
        self.albumID = albumID
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailURL = thumbnailURL
    }
}

