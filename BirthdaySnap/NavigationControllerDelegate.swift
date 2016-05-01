//
//  NavigationControllerDelegate.swift
//  BirthdaySnap
//
//  Created by lola on 4/30/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
 
    /**
        Determines which animation to use depending on the view controllers.
     */
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (toVC.classForCoder == DetailViewController.self) {
            return DetailTransitionAnimator()
        } else {
            return PhotosTransitionAnimator()
        }
    }
}
