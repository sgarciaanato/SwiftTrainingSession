//
//  ViewController.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 12-11-24.
//

import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager()
    var products = [Product]()

    // TODO: remove
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leftAnchor.constraint(equalTo: view.leftAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        networkManager.getProducts() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products = products
                for product in self.products {
                    DispatchQueue.main.async {
                        self.label.text = "\(self.label.text ?? "")\n\(product.title)"
                    }
                }
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
}

