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
public protocol FloatingButtonViewBuilder {
    func addImage(image: UIImage) -> FloatingButtonView
    func addTitle(title: String) -> FloatingButtonView
    func addBGColor(color: UIColor) -> FloatingButtonView
    func addButtonAction(action: @escaping () -> Void) -> FloatingButtonView
}

extension FloatingButtonView: FloatingButtonViewBuilder {
    public func addImage(image: UIImage) -> FloatingButtonView {
        buttonImage.image = image
        return self
    }
    
    public func addTitle(title: String) -> FloatingButtonView {
        buttonLable.text = title
        return self
    }
    
    public func addBGColor(color: UIColor) -> FloatingButtonView {
        contentView.backgroundColor = color
        return self
    }
    
    public func addButtonAction(action: @escaping () -> Void) -> FloatingButtonView {
        setupBinding(buttonAction: action)
        return self
    }
}

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

    public func setupUI() {
        contentView.layer.cornerRadius = 16
        expandButton(value: true)
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
