//
//  DetailViewController.swift
//  BirthdaySnap
//
//  Created by lola on 4/30/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var photosURL: [NSURL]!
    var initialIndexPath: NSIndexPath!
    
    var navigationBar: UINavigationBar!
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupFlowLayout()
        setupCollectionView()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.scrollToItemAtIndexPath(self.initialIndexPath, atScrollPosition: .None, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationBar.translucent = false
        self.navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.navigationBar)
    }
    
    /**
        Setup the flow layout.
     */
    private func setupFlowLayout() {
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.minimumInteritemSpacing = kPHOTO_CELL_SPACING
        self.flowLayout.minimumLineSpacing = kPHOTO_LINE_SPACING
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
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.bounces = true
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.registerClass(DetailCollectionViewCell.self, forCellWithReuseIdentifier: kDetailCellReuseIdentifier)
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
        let heightConstraint = NSLayoutConstraint(item: self.navigationBar, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: kNAV_BAR_LANDSCAPE_HEIGHT)
        self.view.addConstraints([topLayout, leadingConstraint, trailingConstraint, heightConstraint])
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
            self.flowLayout.itemSize = kDETAIL_PORTRAIT_ITEM_SIZE
        } else {
            self.flowLayout.itemSize = kDETAIL_LANDSCAPE_ITEM_SIZE
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
//        cell.imageView.hnk_setImageFromURL(self.photosURL[indexPath.row])
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
}
