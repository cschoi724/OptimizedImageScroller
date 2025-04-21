//
//  CustomScrollView.swift
//  OptimizedImageScroller
//
//  Created by SCC-PC on 2025/04/21.
//

import Foundation
import UIKit

final class CustomScrollViewFullLoad: UIView {

    var contentOffset: CGFloat = 0
    var images: [UIImage] = [] // sample1~sample50

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        
        // 💡 1. 썸네일 크기 계산 (높이 기준 1/4 - spacing 포함 고려)
        let spacing: CGFloat = 20
        let totalSpacing = spacing * 3
        let thumbnailLength = (rect.height - totalSpacing) / 4

        let thumbnailSize = CGSize(width: thumbnailLength, height: thumbnailLength)

        for (index, image) in images.enumerated() {
            // 💡 2. 각 썸네일의 y 좌표 계산
            let y = CGFloat(index) * (thumbnailLength + spacing) - contentOffset

            // 💡 3. 썸네일 중앙 정렬
            let origin = CGPoint(x: (rect.width - thumbnailLength) / 2, y: y)
            let thumbRect = CGRect(origin: origin, size: thumbnailSize)

            // 💡 4. 테두리
            let borderRect = thumbRect.insetBy(dx: -6, dy: -6)
            let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 12)
            context.setLineWidth(4)
            UIColor.systemGreen.setStroke()
            borderPath.stroke()

            // 💡 5. 이미지 렌더링
            image.draw(in: thumbRect)
        }
    }


    // MARK: - 터치 스크롤 구현
    private var lastTouchPoint: CGPoint = .zero

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPoint = touches.first?.location(in: self) ?? .zero
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }

        let dy = point.y - lastTouchPoint.y
        contentOffset -= dy
        contentOffset = max(0, contentOffset) // 위로 넘침 방지
        lastTouchPoint = point
        setNeedsDisplay()
    }
}
