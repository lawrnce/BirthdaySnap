//
//  DetailViewController.swift
//  BirthdaySnap
//
//  Created by lola on 4/30/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // Data models
    var photosURL: [NSURL]!
    var initialIndexPath: NSIndexPath!
    
    // Subview elements
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout()
        setupCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        layoutCollectionView()
        scrollToSelectedIndex()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
        Called during animation to scroll to index.
     */
    func scrollToSelectedIndex() {
        self.view.layoutIfNeeded()
        self.collectionView.scrollToItemAtIndexPath(self.initialIndexPath, atScrollPosition: .None, animated: false)
    }
    
    /**
        MARK: - Setup
     */
    
    /**
        Setup the flow layout.
     */
    private func setupFlowLayout() {
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.scrollDirection = .Horizontal
        self.flowLayout.minimumInteritemSpacing = 0.0
        self.flowLayout.minimumLineSpacing = 0.0
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        if (orientation == .PortraitUpsideDown || orientation == .Portrait) {
            self.flowLayout.itemSize = kDETAIL_PORTRAIT_ITEM_SIZE
        } else {
            self.flowLayout.itemSize = kDETAIL_LANDSCAPE_ITEM_SIZE
        }
    }
    
    /**
     The collection view were we preview photos.
     */
    private func setupCollectionView() {
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.bounces = true
        self.collectionView.alwaysBounceVertical = false
        self.collectionView.pagingEnabled = true
        self.collectionView.registerClass(DetailCollectionViewCell.self, forCellWithReuseIdentifier: kDetailCellReuseIdentifier)
        self.view.addSubview(self.collectionView)
        self.collectionView.reloadData()
    }

    /**
        MARK: - Auto Layout
     */
    
    /**
        Layout collection view under navigation bar.
     */
    private func layoutCollectionView() {
        let topLayout = NSLayoutConstraint(item: self.collectionView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: self.collectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([topLayout, leadingConstraint, trailingConstraint, bottomConstraint])
    }
    
    /**
        
     */
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//        updateCollectionViewLayoutWithSize(size)
//    }
//    
//    private func updateCollectionViewLayoutWithSize(size: CGSize) {
//        self.flowLayout.itemSize = (size.width < size.height) ? kDETAIL_PORTRAIT_ITEM_SIZE : kDETAIL_LANDSCAPE_ITEM_SIZE
//        self.flowLayout.invalidateLayout()
//    }

}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.photosURL != nil else {
            return 0
        }
        return self.photosURL.count
    }
    
    /**
        Fetch the photo for index path and add it to the cell's image view.
        Catch the photos when fetched.
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kDetailCellReuseIdentifier, forIndexPath: indexPath) as! DetailCollectionViewCell
        
        // Set scroll delegate for zoom
        cell.scrollView.delegate = self
        
        // Use Haneke to fetch the photo and catch it
        cell.imageView.frame = cell.bounds
        cell.imageView.hnk_setImageFromURL(self.photosURL[indexPath.row])
        cell.imageView.center = cell.center
        return cell
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        // Check orientation
//        let orientation = UIApplication.sharedApplication().statusBarOrientation
//        if (orientation == .PortraitUpsideDown || orientation == .Portrait) {
//            return kDETAIL_PORTRAIT_ITEM_SIZE
//        } else {
//            return kDETAIL_LANDSCAPE_ITEM_SIZE
//        }
//    }
}