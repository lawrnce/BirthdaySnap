//
//  PhotosCollectionViewCell.swift
//  BirthdaySnap
//
//  Created by lola on 4/29/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
 
    var imageView: UIImageView!
    var activityIndicatorView: UIActivityIndicatorView!

    /**
        Setup the image view in the cell's frame.
     */
    private func setupImageView() {
        self.imageView = UIImageView(frame: self.bounds)
        self.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = .ScaleAspectFill
        self.contentMode = .ScaleAspectFill
        self.contentView.addSubview(self.imageView)
        
        // Autolayout image view
        let topLayout = NSLayoutConstraint(item: self.imageView, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let bottomLayout = NSLayoutConstraint(item: self.imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let leadingLayout = NSLayoutConstraint(item: self.imageView, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingLayout = NSLayoutConstraint(item: self.imageView, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([topLayout, bottomLayout, leadingLayout, trailingLayout])
    }
    
    private func setupActivityIndicatorView() {
        self.activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.activityIndicatorView.activityIndicatorViewStyle = .Gray
        self.activityIndicatorView.center = self.contentView.center
        self.contentView.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActivityIndicatorView()
        setupImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityIndicatorView()
        setupImageView()
    }
    
    override func prepareForReuse() {
        if (self.imageView.image != nil) {
            self.imageView.image = nil
        }
    }
}
