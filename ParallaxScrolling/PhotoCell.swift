//
//  PhotoCell.swift
//  ParallaxScrolling
//
//  Created by Joan Disho on 09.06.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    var imageView: UIImageView!
    var maxParallaxOffset: CGFloat!

    private var imageViewHeightConstraint: NSLayoutConstraint!
    private var imageViewCenterYConstraint: NSLayoutConstraint!

    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true
        layer.cornerRadius = 10

        setupImageView()
        setupConstraint()

        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        super.updateConstraints()

        imageViewHeightConstraint.constant = 2 * maxParallaxOffset
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        guard let parallaxAttr = layoutAttributes as? ParallaxLayoutAttributes else { return }
        imageViewCenterYConstraint.constant = parallaxAttr.parallaxOffset.y
    }

    // MARK: Helpers

    private func setupImageView() {
        imageView = UIImageView(frame: contentView.frame)
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }

    private func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let left = NSLayoutConstraint(
            item: imageView,
            attribute: NSLayoutConstraint.Attribute.left,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: contentView,
            attribute: NSLayoutConstraint.Attribute.left,
            multiplier: 1,
            constant: 0
        )

        let right = NSLayoutConstraint(
            item: imageView,
            attribute: NSLayoutConstraint.Attribute.right,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: contentView,
            attribute: NSLayoutConstraint.Attribute.right,
            multiplier: 1,
            constant: 0
        )

        imageViewHeightConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: contentView,
            attribute: NSLayoutConstraint.Attribute.height,
            multiplier: 1,
            constant: 0
        )

        imageViewCenterYConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: contentView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1,
            constant: 0
        )

        contentView.addConstraint(left)
        contentView.addConstraint(right)
        contentView.addConstraint(imageViewHeightConstraint)
        contentView.addConstraint(imageViewCenterYConstraint)
    }
}
