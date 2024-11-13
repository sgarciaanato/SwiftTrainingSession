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

    let topView: CustomViewContainer = {
        let view = TopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()

    let middleView: CustomViewContainer = {
        let view = MiddleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    let botView: CustomViewContainer = {
        let view = BotView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground

        configureViews()
        networkManager.getProducts() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products = products
                DispatchQueue.main.async {
                    self.topView.products = products
                    self.middleView.products = products
                    self.botView.products = products
                }
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }

    func configureViews() {
        configureTopView()
        configureMiddleView()
        configureBotView()
    }

    func configureTopView() {
        view.addSubview(topView)

        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3)
        ])
    }

    func configureMiddleView() {
        view.addSubview(middleView)

        NSLayoutConstraint.activate([
            middleView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            middleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            middleView.heightAnchor.constraint(equalTo: topView.heightAnchor)
        ])
    }

    func configureBotView() {
        view.addSubview(botView)

        NSLayoutConstraint.activate([
            botView.topAnchor.constraint(equalTo: middleView.bottomAnchor),
            botView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            botView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            botView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                if(self.view.frame.size.height > self.view.frame.size.width){
                    self.topView.viewRotated(to: .portrait)
                }
                else{
                    self.topView.viewRotated(to: .landscape)
                }
            }
        }
    }
}
