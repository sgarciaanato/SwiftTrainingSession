//
//  ProductView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import UIKit

final class ProductView: UIView, CustomView {
    let networkManager = NetworkManager()
    var product: Product
    var widthConstraint: NSLayoutConstraint?

    required init(product: Product) {
        self.product = product
        super.init(frame: .zero)
        self.configureImage(product)
        self.titleLabel.text = product.title
        self.widthConstraint = widthAnchor.constraint(equalToConstant: 100)
        self.widthConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        view.backgroundColor = .tertiarySystemBackground

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        return view
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        containerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
        ])

        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])

        return label
    }()

    func configureImage(_ product: Product) {
        // imageView.image = nil
        networkManager.getImage(from: product.image) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.imageView.image = nil
                }
            }
        }
    }

    func updateWidth(_ size: CGFloat) {
        widthConstraint?.constant = size
    }

}
