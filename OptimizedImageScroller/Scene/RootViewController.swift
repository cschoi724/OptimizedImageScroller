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

    // 토글할 수 있도록 2개의 뷰 준비
    let fullLoadView = CustomScrollViewFullLoad()
    let optimizedView = CustomScrollViewOnDemand()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//
//        // 한쪽만 보여주기 (비교할 수 있도록 전환 버튼 만들 수도 있음)
//        view.addSubview(fullLoadView)
//
//        fullLoadView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//        // 기존 방식: 모든 이미지를 로드
//        fullLoadView.images = (1...50).compactMap {
//            UIImage(named: "sample\($0)")
//        }

        // 메모리 최적화 방식도 동일하게 구성해두고 숨김처리
        view.addSubview(optimizedView)
        optimizedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        optimizedView.imageNames = (1...50).map { "sample\($0)" }
    }
}
