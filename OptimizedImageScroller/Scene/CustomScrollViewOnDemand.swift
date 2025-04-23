//
//  CustomScrollViewOnDemand.swift
//  OptimizedImageScroller
//
//  Created by SCC-PC on 2025/04/21.
//

import Foundation
import UIKit

final class CustomScrollViewOnDemand: UIView {

    var imageNames: [String] = []
    private var cachedImages: [Int: UIImage] = [:]
    private var contentOffset: CGFloat = 0
    private let spacing: CGFloat = 20
    private var lastTouchPoint: CGPoint = .zero

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        
        let totalSpacing = spacing * 3
        let thumbLength = (rect.height - totalSpacing) / 4
        let thumbSize = CGSize(width: thumbLength, height: thumbLength)

        let unitHeight = thumbLength + spacing
        let startIndex = max(Int(contentOffset / unitHeight), 0)
        let endIndex = min(Int((contentOffset + rect.height) / unitHeight) + 1, imageNames.count - 1)
        
        guard startIndex <= endIndex else { return }

        let visibleIndices = Set(startIndex...endIndex)

        for index in visibleIndices {
            if cachedImages[index] == nil {
                let name = imageNames[index]
                if let path = Bundle.main.path(forResource: name, ofType: "png"),
                   let image = UIImage(contentsOfFile: path) {
                    cachedImages[index] = image
                }
            }
        }

        for index in cachedImages.keys where !visibleIndices.contains(index) {
            cachedImages[index] = nil
        }

        for index in visibleIndices {
            guard let image = cachedImages[index] else { continue }

            let y = CGFloat(index) * unitHeight - contentOffset
            let origin = CGPoint(x: (rect.width - thumbLength) / 2, y: y)
            let frame = CGRect(origin: origin, size: thumbSize)

            let borderRect = frame.insetBy(dx: -6, dy: -6)
            let path = UIBezierPath(roundedRect: borderRect, cornerRadius: 12)
            context.setLineWidth(4)
            UIColor.systemOrange.setStroke()
            path.stroke()

            image.draw(in: frame)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPoint = touches.first?.location(in: self) ?? .zero
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }

        let dy = point.y - lastTouchPoint.y
        contentOffset -= dy
        contentOffset = max(0, contentOffset)
        lastTouchPoint = point
        setNeedsDisplay()
    }
}

