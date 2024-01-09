//
//  FloatingButtonView.swift
//
//
//  Created by Ahmed Talaat on 09/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

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
       fromNib(viewType: Self.self)
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


//extension UIView {
//    @discardableResult
//    func fromNib<T: UIView>(viewType: T.Type, frombunde : Bundle? = nil) -> UIView? {
//        let nibName = String(describing: viewType)
//        guard let bundleName = frombunde else { return nil}
//        guard let view = bundleName.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
//            fatalError("Failed to instantiate nib \(nibName)")
//        }
//        self.addSubview(view)
//        view.frame = self.bounds
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        return view
//    }
//}
