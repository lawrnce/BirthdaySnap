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

class Flickr {
    
    /**
        Calls the Flickr API with paramaters for birthday photos.
     
        - Parameter competion: The block to be executed after the HTTP call. This block returns a JSON or an error.
     */
    func searchBirthdayPhotos(page: Int, completion:(json: JSON?, error: ErrorType?) -> Void) {
        
        let params =    ["method": "flickr.photos.search",
            "api_key": apiKey,
            "text": "brithday party boy",
            "per_page": "30",
            "page": page,
            "format": "json",
            "nojsoncallback": "1"]
        
        Alamofire.request(.GET, API_ENDPOINT, parameters: (params as! [String : AnyObject]))
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
    
    /**
        Parses the raw JSON from Flickr API into an array of URLs.
    
        - Parameter data: JSON output from a Flickr API call.
        - Returns: An array of photo urls.
     */
    func parseData(data: JSON) -> [NSURL] {
        var urls = [NSURL]()
        for (_, subJson) in data["photos"]["photo"] {
            urls.append(flickrImageURL(subJson))
        }
        return urls
    }
    
    /**
        Helper method to parse raw photo data into a url.
     
        - Parameter photo: The data for a single flickr photo to be parses into a url.
        - Returns: A url of a flickr photo.
     */
    private func flickrImageURL(photo: JSON) -> NSURL {
        return NSURL(string: "http://farm\(photo["farm"]).staticflickr.com/\(photo["server"])/\(photo["id"])_\(photo["secret"]).jpg")!
    }
}