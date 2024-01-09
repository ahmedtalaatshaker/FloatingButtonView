//
//  FloatingButtonView+ScrollingHandler.swift
//  SharedUI
//
//  Created by Ahmed Talaat on 18/10/2022.
//  Copyright © 2022 BanqueMisr. All rights reserved.
//

import UIKit

public extension FloatingButtonView {
    func handleScrollingOf(scrollView: UIScrollView) {
        expandButton(value: lastContentOffset > scrollView.contentOffset.y)
        lastContentOffset = scrollView.contentOffset.y
    }
}
