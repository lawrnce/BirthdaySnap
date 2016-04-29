//
//  WaterfallLayout.swift
//  BirthdaySnap
//
//  Created by lola on 4/29/16.
//  Copyright © 2016 LawrenceTran. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
}

class WaterfallLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight: CGFloat = 0.0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! WaterfallLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributes = object as? WaterfallLayoutAttributes {
            if (attributes.photoHeight == photoHeight) {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class WaterfallLayout: UICollectionViewLayout {
    
    var delegate: WaterfallLayoutDelegate?
    var columns = 2
    
    private var cache = [WaterfallLayoutAttributes]()
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override class func layoutAttributesClass() -> AnyClass {
        return WaterfallLayoutAttributes.self
    }
    
    override func prepareLayout() {
        if self.cache.isEmpty {
            
            var xOffset = [CGFloat]()
            xOffset.append(0.0)
            xOffset.append(kSCREEN_WIDTH / 2.0)
            var yOffset = [CGFloat](count: 2, repeatedValue: 0.0)
            
            var columnIndex = 0
            
            for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let photoHeight = delegate?.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: kPHOTO_WIDTH)
                let height = photoHeight! + kPHOTO_CELL_PADDING * 2.0
                let frame = CGRect(x: xOffset[columnIndex],
                    y: yOffset[columnIndex], width: kSCREEN_WIDTH/2.0, height: height)
                let insetFrame = CGRectInset(frame, kPHOTO_CELL_PADDING, kPHOTO_CELL_PADDING)
                
                let attributes = WaterfallLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.photoHeight = photoHeight!
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                yOffset[columnIndex] = yOffset[columnIndex] + height
                
                columnIndex = columnIndex >= 2 ? 0 : ++columnIndex
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}