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
    
    // Rotation 
    private var contentOffsetAfterRotation: CGPoint!
    
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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
        self.flowLayout.itemSize = kDETAIL_PORTRAIT_ITEM_SIZE
    }
    
    /**
     The collection view were we preview photos.
     */
    private func setupCollectionView() {
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.blackColor()
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
        return cell
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
}