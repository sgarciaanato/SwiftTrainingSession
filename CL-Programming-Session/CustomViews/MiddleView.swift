//
//  MiddleView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import UIKit

class MiddleView: UIView, CustomViewContainer {
    var products: [Product]? {
        didSet {
            for view in containerStackView.arrangedSubviews {
                view.removeFromSuperview()
            }
            for (index, product) in (products ?? []).enumerated() {
                if index % 2 == 0 {
                    containerStackView.addArrangedSubview(rowStackView)
                    rowStackView = UIStackView()
                    rowStackView.axis = .vertical
                    rowStackView.distribution = .fillProportionally
                }
                let productView = ProductView(product: product)
                productView.updateWidth(frame.size.width * 0.4)
                rowStackView.addArrangedSubview(productView)
                if (index == products?.count) {
                    containerStackView.addArrangedSubview(rowStackView)
                }
            }
        }
    }

    var rowStackView = UIStackView()

    lazy var containerStackView: UIStackView = {
        let scrollView = UIScrollView()
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        return stackView
    }()

    func viewRotated(to orientation: ViewOrientation) {
        if orientation == .portrait {
            for view in containerStackView.arrangedSubviews {
                guard let view = view as? ProductView else { return }
                view.updateWidth(frame.size.width * 0.4)
            }
            return
        }
        for view in containerStackView.arrangedSubviews {
            guard let view = view as? ProductView else { return }
            view.updateWidth(frame.size.width * 0.3)
        }
        return
    }
}
