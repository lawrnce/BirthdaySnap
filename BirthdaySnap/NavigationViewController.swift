//
//  NavigationViewController.swift
//  BirthdaySnap
//
//  Created by lola on 4/30/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    var photosViewController: PhotosViewController!
    var detailViewController: DetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosViewController = PhotosViewController()
        self.detailViewController = DetailViewController()
        self.viewControllers = [self.photosViewController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
