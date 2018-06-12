//
//  ParallaxLayoutAttributes.swift
//  ParallaxScrolling
//
//  Created by Joan Disho on 09.06.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import UIKit

class ParallaxLayoutAttributes: UICollectionViewLayoutAttributes {

    var parallaxOffset: CGPoint!

    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ParallaxLayoutAttributes
        copy.parallaxOffset = self.parallaxOffset
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if !(object is ParallaxLayoutAttributes) {
            return false
        }

        guard let otherObject = object as? ParallaxLayoutAttributes else { return false }
        
        if !self.parallaxOffset.equalTo(otherObject.parallaxOffset) {
            return false
        }

        return super.isEqual(otherObject)
    }

}
