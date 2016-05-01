//
//  DetailTransitionAnimator.swift
//  BirthdaySnap
//
//  Created by lola on 4/30/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

class DetailTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    /**
        Fade in the next view controller
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        _ = transitionContext.viewControllerForKey(
            UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(
            UITransitionContextToViewControllerKey) as! DetailViewController
        
        containerView!.addSubview(toVC.view)
        toVC.view.alpha = 0.0
        
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            toVC.view.alpha = 1.0
            
            }, completion: { finished in
                let cancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!cancelled)
        })
    }
}
