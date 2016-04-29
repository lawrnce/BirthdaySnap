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

    /**
        Setup the image view in the cell's frame.
     */
    private func setupImageView() {
        self.imageView = UIImageView(frame: CGRectZero)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        
        // Autolayout image view
        let topLayout = NSLayoutConstraint(item: self.imageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let bottomLayout = NSLayoutConstraint(item: self.imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let leadingLayout = NSLayoutConstraint(item: self.imageView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingLayout = NSLayoutConstraint(item: self.imageView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([topLayout, bottomLayout, leadingLayout, trailingLayout])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    override func prepareForReuse() {
        if (self.imageView.image != nil) {
            self.imageView.image = nil
        }
    }
}
