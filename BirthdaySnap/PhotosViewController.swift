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
    
    // Flickr API
    var flickr = Flickr()
    
    // Array of URLS of Flickr photos
    var photosURL: [NSURL]!
    
    // The total number of pages of photos
    var totalPages: Int!
    
    // The image cache to store the photos
    var cache: Cache<UIImage>!
    
    // Subview elements
    var navigationBar: UINavigationBar!
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    
    // Auto layout variables
    private var navigationBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupFlowLayout()
        setupCollectionView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBar()
        layoutCollectionView()
        getBirthdayImagesForPage(1, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
        MARK: - Data
     */
    
    /**
        Fetch data from Flikr API. If first page then create new 
        data model. If not first page, add new page to current model.
        If there's any error then notify the user.
     
        - Parameter page: The page to be fetched.
        - Parameter completion: The block to be executed after fetching data.
     */
    private func getBirthdayImagesForPage(page: Int, completion:(() -> Void)?) {
        if (page == 1) {
            self.photosURL = nil
            self.photosURL = [NSURL]()
            self.totalPages = 0
        }
        
        self.flickr.searchBirthdayPhotos(page) { (json, error) -> Void in
            
            // Success
            if (error == nil) {
                // Increment page
                self.totalPages = self.totalPages + 1
                
                // Append to model
                self.photosURL! += self.flickr.parseData(json!)
                
                // Reload collection view
                self.collectionView.reloadData()
                

                
            // Network Error
            } else {

            }
            
            if completion != nil {
                completion!()
            }
        }
    }
    
    /**
        Fetch data for next page.
     */
    private func getNextPage() {
        getBirthdayImagesForPage(self.totalPages + 1, completion: nil)
    }
     
    /**
        Pull to refresh for the collection view.
     
        - Parameter refreshControl: The refresh control from the collection view.
     */
    func refreshCollectionView(refreshControl: UIRefreshControl) {
        getBirthdayImagesForPage(1) { (error) -> Void in
           refreshControl.endRefreshing()
        }
    }
    
    /**
        MARK: - User Notifications
     */
    
    
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
        Setup the flow layout.
     */
    private func setupFlowLayout() {
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.minimumInteritemSpacing = kPHOTO_CELL_SPACING
        self.flowLayout.minimumLineSpacing = kPHOTO_LINE_SPACING
        self.flowLayout.itemSize = kPHOTO_PORTRAIT_ITEM_SIZE
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
        self.collectionView.registerClass(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: kPhotosCellReuseIdentifier)
        self.view.addSubview(self.collectionView)
        
        // add a refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: "refreshCollectionView:", forControlEvents: .ValueChanged)
        self.collectionView.addSubview(refreshControl)
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
            self.flowLayout.itemSize = kPHOTO_PORTRAIT_ITEM_SIZE
        } else {
            self.navigationBarHeightConstraint.constant = kNAV_BAR_LANDSCAPE_HEIGHT
            self.flowLayout.itemSize = kPHOTO_LANDSCAPE_ITEM_SIZE
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
    
    /**
        Fetch the photo for index path and add it to the cell's image view. 
        Catch the photos when fetched.
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kPhotosCellReuseIdentifier, forIndexPath: indexPath) as! PhotosCollectionViewCell
        // Use Haneke to fetch the photo and catch it
        cell.imageView.hnk_setImageFromURL(self.photosURL[indexPath.row])
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}
