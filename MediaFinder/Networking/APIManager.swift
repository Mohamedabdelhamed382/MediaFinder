
//
//  APIManager.swift
//  MediaFinder
//
//  Created by Mohamed Abdelhamed Ahmed on 1/5/21.
//  Copyright © 2021 Mohamed Abdelhamed Ahmed. All rights reserved.
//
import Foundation
import Alamofire

class APIManager {

    static func loadMedia(searchQuery: String, mediaType: String, completion: @escaping (_ error: Error?, _ media: [Media]?) -> ()) {
        
        let parameters = [paramKeys.searchQuery: searchQuery, paramKeys.mediaType: mediaType ]
        
        AF.request(URLs.iTunesSearchAPI,method: .post , parameters: parameters , encoding: URLEncoding.default , headers: nil) .response{ response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error,nil)
                return
            }
            guard let data = response.data else{
                print("cannot get any data from API  ")
                return
            }
            // for parsing
            //let decoder = JSONDecoder() // donot need
            // convert to be array from my class
            do {
                let mediaArr = try JSONDecoder().decode(MediaResponse.self, from: data).results
                completion(nil,mediaArr)
                for media in mediaArr{
                    print(media.artistName)
                }
            }catch(let error){
                print(error)
            }
        }
    }
}
