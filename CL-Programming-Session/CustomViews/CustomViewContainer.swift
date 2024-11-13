//
//  CustomViewContainer.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import UIKit

enum ViewOrientation {
    case landscape
    case portrait
}

protocol CustomViewContainer: UIView {
    var products: [Product]? { get set }
    func viewRotated(to orientation: ViewOrientation)
}

protocol CustomView: UIView {
    var product: Product { get set }
}
