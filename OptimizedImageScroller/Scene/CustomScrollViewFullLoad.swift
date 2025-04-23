//
//  CustomScrollView.swift
//  OptimizedImageScroller
//
//  Created by SCC-PC on 2025/04/21.
//

import Foundation
import UIKit

final class CustomScrollViewFullLoad: UIView {
    
    var images: [UIImage] = []
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

        for (index, image) in images.enumerated() {
            let y = CGFloat(index) * (thumbLength + spacing) - contentOffset

            let origin = CGPoint(x: (rect.width - thumbLength) / 2, y: y)
            let thumbRect = CGRect(origin: origin, size: thumbSize)

            let borderRect = thumbRect.insetBy(dx: -6, dy: -6)
            let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 12)
            context.setLineWidth(4)
            UIColor.systemGreen.setStroke()
            borderPath.stroke()

            image.draw(in: thumbRect)
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
