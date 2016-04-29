//
//  PhotosViewController.swift
//  BirthdaySnap
//
//  Created by lola on 4/29/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit
import Haneke

class PhotosViewController: UIViewController {

    var navigationBar: UINavigationBar!
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    
    var photosURL: [NSURL]!
    
    // Auto layout variables
    private var navigationBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBar()
        layoutCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
        MARK: - Setup
     */
    
    /**
        Use a navigation bar at the top. We do not use a navigation controller
        because we will be handling navigation ourselves. The built in navigation
        is inflexible.
     */
    private func setupNavigationBar() {
        self.navigationBar = UINavigationBar(frame: CGRectZero)
        self.navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.navigationBar)
    }
    
    /**
        The collection view were we preview photos.
     */
    private func setupCollectionView() {
        self.layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.layout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.view.addSubview(self.collectionView)
    }
    
    /**
        MARK: - Auto Layout
    */
    
    /**
        Layout navigation bar at top. We don't use a navigation controller because
        we will handle navigation ourselves.
     */
    private func layoutNavigationBar() {
        let topLayout = NSLayoutConstraint(item: self.navigationBar, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: self.navigationBar, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: self.navigationBar, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        self.navigationBarHeightConstraint = NSLayoutConstraint(item: self.navigationBar, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: kNAV_BAR_PORTRAIT_HEIGHT)
        self.view.addConstraints([topLayout, leadingConstraint, trailingConstraint, self.navigationBarHeightConstraint])
    }
    
    /**
        Layout collection view under navigation bar.
     */
    private func layoutCollectionView() {
        let topLayout = NSLayoutConstraint(item: self.collectionView, attribute: .Top, relatedBy: .Equal, toItem: self.navigationBar, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([topLayout, leadingConstraint, trailingConstraint, bottomConstraint])
    }
    
    /**
        Adjust auto layout for orientation.
     */
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if (toInterfaceOrientation == .Portrait || toInterfaceOrientation == .PortraitUpsideDown) {
            self.navigationBarHeightConstraint.constant = kNAV_BAR_PORTRAIT_HEIGHT
        } else {
            self.navigationBarHeightConstraint.constant = kNAV_BAR_LANDSCAPE_HEIGHT
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.photosURL != nil else {
            return 0
        }
        return self.photosURL.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    
}
