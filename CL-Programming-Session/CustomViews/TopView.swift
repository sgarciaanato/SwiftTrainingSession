//
//  TopView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import UIKit

class TopView: UIView, CustomViewContainer {
    var products: [Product]? {
        didSet {
            label.text = ""
            guard let products else {
                label.text = "Error"
                return
            }
            for product in products {
                label.text = "\(label.text ?? "")\(product.title)\n"
            }
        }
    }

    // TODO: remove
    lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        return label
    }()
}
