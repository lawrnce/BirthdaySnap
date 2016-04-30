//
//  DetailCollectionViewCell.swift
//  BirthdaySnap
//
//  Created by lola on 4/30/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    /**
        Add a scroll view to the cell and place an image view inside of it
     */
    private func setup() {
        setupScrollView()
        setupImageView()
        self.clipsToBounds = true
    }
    
    private func setupScrollView() {
        self.scrollView = UIScrollView(frame: self.bounds)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.scrollView)
        
        // Autolayout scroll view
        let topLayout = NSLayoutConstraint(item: self.scrollView, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let bottomLayout = NSLayoutConstraint(item: self.scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let leadingLayout = NSLayoutConstraint(item: self.scrollView, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingLayout = NSLayoutConstraint(item: self.scrollView, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([topLayout, bottomLayout, leadingLayout, trailingLayout])
    }
    
    private func setupImageView() {
        self.imageView = UIImageView(frame: self.bounds)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.imageView)
        
        // Autolayout scroll view
        let topLayout = NSLayoutConstraint(item: self.imageView, attribute: .Top, relatedBy: .Equal, toItem: self.scrollView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let bottomLayout = NSLayoutConstraint(item: self.imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self.scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let leadingLayout = NSLayoutConstraint(item: self.imageView, attribute: .Leading, relatedBy: .Equal, toItem: self.scrollView, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let trailingLayout = NSLayoutConstraint(item: self.imageView, attribute: .Trailing, relatedBy: .Equal, toItem: self.scrollView, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        
        self.scrollView.addConstraints([topLayout, bottomLayout, leadingLayout, trailingLayout])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForReuse() {
        if (self.imageView.image != nil) {
            self.imageView.image = nil
        }
    }
}
