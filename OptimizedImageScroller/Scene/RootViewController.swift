//
//  RootViewController.swift
//  OptimizedImageScroller
//
//  Created by SCC-PC on 2025/04/21.
//

import UIKit
import SnapKit
import Then

final class RootViewController: UIViewController {

    let fullLoadView = CustomScrollViewFullLoad()
    let optimizedView = CustomScrollViewOnDemand()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // 전체 이미지 로드 방식
//        view.addSubview(fullLoadView)
//
//        fullLoadView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//        fullLoadView.images = (1...50).compactMap {
//            if let path = Bundle.main.path(forResource: "sample\($0)", ofType: "png") {
//                return UIImage(contentsOfFile: path)
//            }
//            return nil
//        }

        // 메모리 최적화 방식
        view.addSubview(optimizedView)
        optimizedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        optimizedView.imageNames = (1...50).map { "sample\($0)" }
    }
}
