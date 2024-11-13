//
//  CustomCellContainer.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import UIKit

protocol CustomCellContainer: UICollectionViewCell {
    static var reusableIdentifier: String { get }
    var product: Product? { get set }
}
