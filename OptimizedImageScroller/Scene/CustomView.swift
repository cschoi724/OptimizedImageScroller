//
//  CustomView.swift
//  OptimizedImageScroller
//
//  Created by SCC-PC on 2025/04/21.
//

import Foundation
import UIKit

final class CustomView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let image = UIImage(named: "sample1"),
              let context = UIGraphicsGetCurrentContext() else { return }

        // 1. 이미지 크기 설정 (1/4 크기)
        let scaleRatio: CGFloat = 0.25
        let originalSize = image.size
        let thumbnailSize = CGSize(width: originalSize.width * scaleRatio,
                                   height: originalSize.height * scaleRatio)
        // 2. 썸네일 위치 (가운데 정렬)
        let thumbOrigin = CGPoint(
            x: (rect.width - thumbnailSize.width) / 2,
            y: (rect.height - thumbnailSize.height) / 2
        )
        let thumbRect = CGRect(origin: thumbOrigin, size: thumbnailSize)

        // 3. 둥근 테두리용 경로 만들기 (썸네일보다 살짝 크게)
        let borderRect = thumbRect.insetBy(dx: -6, dy: -6) // 테두리 두께만큼 확대
        let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 20)
        
        // 4. 윤곽선 색상 및 두께 설정
        context.setLineWidth(4)
        UIColor.systemIndigo.setStroke()
        borderPath.stroke()

        // 5. 이미지 그리기
        image.draw(in: thumbRect)
    }
}

