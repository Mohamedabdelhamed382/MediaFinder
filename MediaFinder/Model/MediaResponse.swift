//
//  MediaResponse.swift
//  MediaFinder
//
//  Created by Mohamed Abdelhamed Ahmed on 1/7/21.
//  Copyright © 2021 Mohamed Abdelhamed Ahmed. All rights reserved.
//
import Foundation
struct MediaResponse : Codable {
    var resultCount: Int
    var results: [Media]
}
enum MediaType: String {
    case movie = "movie"
    case music = "music"
    case tvShow = "tvShow"
}
