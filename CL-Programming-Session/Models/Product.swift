//
//  Product.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import SwiftUI

struct Product: Codable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating

    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(price, forKey: .price)
        try container.encode(description, forKey: .description)
        try container.encode(category, forKey: .category)
        try container.encode(image, forKey: .image)
        try container.encode(rating, forKey: .rating)
    }
}

struct Rating: Codable {
    let rate: Double
    let count: Double

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rate, forKey: .rate)
        try container.encode(count, forKey: .count)
    }
}

extension [Product] {
    func zIndex(_ product: Product) -> CGFloat {
        if let index = firstIndex(where: { $0.id == product.id }) {
            return CGFloat(count) - CGFloat(CFloat(index))
        }
        return .zero
    }
}
