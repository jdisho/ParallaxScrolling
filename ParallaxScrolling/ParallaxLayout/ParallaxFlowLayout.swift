//
//  ParallaxFlowLayout.swift
//  ParallaxScrolling
//
//  Created by Joan Disho on 09.06.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import UIKit

class ParallaxFlowLayout: UICollectionViewFlowLayout {

    let maxParallaxOffset: CGFloat = 30.0

    private var parallaxLayoutAttributesCache = [ParallaxLayoutAttributes]()

    override class var layoutAttributesClass: AnyClass {
        return ParallaxLayoutAttributes.self
    }

    override func prepare() {
        guard parallaxLayoutAttributesCache.isEmpty, let collectionView = collectionView else { return }

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            guard let attributes = super.layoutAttributesForItem(at: indexPath) as? ParallaxLayoutAttributes else { return }
            parallaxLayoutAttributesCache.append(attributes)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributesArray = super.layoutAttributesForElements(in: rect) as? [ParallaxLayoutAttributes] else { return nil }

        for layoutAttributes in layoutAttributesArray where layoutAttributes.representedElementCategory == UICollectionView.ElementCategory.cell {
                layoutAttributes.parallaxOffset = parallaxOffset(for: layoutAttributes)
        }

        return layoutAttributesArray
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layoutAttributes = parallaxLayoutAttributesCache[indexPath.row]
        layoutAttributes.parallaxOffset = parallaxOffset(for: layoutAttributes)
        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    private func parallaxOffset(for layoutAttributes: ParallaxLayoutAttributes) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }
        let bounds = collectionView.bounds
        let boundsCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let cellCenter = layoutAttributes.center
        let offsetFromCenter = CGPoint(x: boundsCenter.x - cellCenter.x, y: boundsCenter.y - cellCenter.y)
        let cellSize = layoutAttributes.size
        let maxVerticalOffsetWhereCellIsStillVisible = bounds.size.height / 2 + cellSize.height / 2
        let scaleFactor = maxParallaxOffset / maxVerticalOffsetWhereCellIsStillVisible

        return CGPoint(x: 0.0, y: offsetFromCenter.y * scaleFactor)
    }
}
