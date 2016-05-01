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
    
    var navigationControllerDelegate: NavigationControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init intial view controller
        self.photosViewController = PhotosViewController()
        self.viewControllers = [self.photosViewController]
        
        // Set delegate for animation
        self.navigationControllerDelegate = NavigationControllerDelegate()
        self.delegate = self.navigationControllerDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
