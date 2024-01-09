//
//  FloatingButtonView.swift
//
//
//  Created by Ahmed Talaat on 09/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

public class FloatingButtonView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var buttonLable: UILabel!
    @IBOutlet weak public var actionButton: UIButton!

    private var shouldExpand = false
    private let bag = DisposeBag()
    var lastContentOffset: CGFloat = 0

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        loadViewFromNib()
    }

    private func loadViewFromNib() {
        fromNib(viewType: Self.self, frombunde: Bundle.module)
    }

    public func setupUI(image: UIImage, title: String, BGColor: UIColor, buttonAction: @escaping () -> Void) {
        buttonImage.image = image
        buttonLable.text = title
        contentView.backgroundColor = BGColor
        contentView.layer.cornerRadius = 16
        expandButton(value: true)
        setupBinding(buttonAction: buttonAction)
    }

    private func setupBinding(buttonAction: @escaping () -> Void) {
        actionButton.rx.tap.asDriver().drive(onNext: {
            buttonAction()
        }).disposed(by: bag)
    }

    public func expandButton(value: Bool) {
        if shouldExpand == value { return }
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.shouldExpand = value
            self.buttonLable.isHidden = !value
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.setNeedsLayout()
            self.setNeedsDisplay()
        })
    }
}
