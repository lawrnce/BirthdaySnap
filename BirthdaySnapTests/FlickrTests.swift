//
//  FlickrTests.swift
//  BirthdaySnap
//
//  Created by lola on 4/28/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import XCTest
import Nimble
@testable import BirthdaySnap

class FlickrTests: XCTestCase {
    
    var flickr: Flickr!
    
    override func setUp() {
        super.setUp()
        self.flickr = Flickr()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_flickr_api_returns_no_error() {
        self.flickr.searchBirthdayPhotos(1) { (json, error) -> Void in
            expect(error).toEventually(beNil(), timeout: 5)
        }
    }
    
    func test_flickr_parses_response_to_url_array() {
        self.flickr.searchBirthdayPhotos(1) { (json, error) -> Void in
            let urls = self.flickr.parseData(json!)
            expect(urls).toEventually(beAKindOf([NSURL].self), timeout: 5)
        }
    }
}
