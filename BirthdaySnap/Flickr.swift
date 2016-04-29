//
//  Flickr.swift
//  BirthdaySnap
//
//  Created by lola on 4/28/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let API_ENDPOINT = "https://api.flickr.com/services/rest/"
let apiKey = "01351a08b752df306279c93cdea62aba"
let apiSecret = "4f1469c14f2cf902"

class Flickr {
    
    /**
     Calls the Flickr API with paramaters for birthday photos.
     
     - Parameter competion: The block to execute after the HTTP call. This block returns a JSON or an error.
     */
    func searchBirthdayPhotos(completion:(json: JSON?, error: ErrorType?) -> Void) {
        
        let params =    ["method": "flickr.photos.search",
            "api_key": apiKey,
            "text": "birthday",
            "per_page": "30",
            "format": "json",
            "nojsoncallback": "1"]
        
        Alamofire.request(.GET, API_ENDPOINT, parameters: params)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    completion(json: JSON(data: response.data!), error: nil)
                case .Failure(let error):
                    completion(json: nil, error: error)
                }
        }
    }

}