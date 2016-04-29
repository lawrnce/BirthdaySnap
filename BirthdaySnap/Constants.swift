//
//  Constants.swift
//  BirthdaySnap
//
//  Created by lola on 4/29/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import Foundation
import UIKit

/**
    Flickr API
 */
let API_ENDPOINT = "https://api.flickr.com/services/rest/"
let apiKey = "01351a08b752df306279c93cdea62aba"
let apiSecret = "4f1469c14f2cf902"

/**
    Global ui constants
 */
let kSCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let kSCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

/**
    Collection view ui constants
 */
let kPHOTOS_PER_ROW_PORTRAIT = 3
let kPHOTOS_PER_ROW_LANDSCAPE = 4
let kPHOTO_CELL_SPACING = CGFloat(1.0)
let kPHOTO_LINE_SPACING = kPHOTO_CELL_SPACING * 2.0
let kPHOTO_PORTRAIT_ITEM_SIZE = CGSize(width: kSCREEN_WIDTH / 3.0 - kPHOTO_CELL_SPACING, height: kSCREEN_WIDTH / 3.0 - kPHOTO_CELL_SPACING)
let kPHOTO_LANDSCAPE_ITEM_SIZE = CGSize(width: kSCREEN_HEIGHT / 4.0 - kPHOTO_CELL_SPACING, height: kSCREEN_HEIGHT / 4.0 - kPHOTO_CELL_SPACING)

/** 
    Photos cell constants
 */
let kPhotosCellReuseIdentifier = "com.lawrnce.PhotosCellReuseIdentifier"

/**
    Autolayout constants
 */
let kNAV_BAR_PORTRAIT_HEIGHT = CGFloat(64.0)
let kNAV_BAR_LANDSCAPE_HEIGHT = CGFloat(44.0)