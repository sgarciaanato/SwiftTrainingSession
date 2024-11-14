//
//  ProductCardView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import SwiftUI

struct ProductCardView: View {
    @State var product: Product

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.green)
                VStack {
                    ProductImageView(imageUrlString: product.image)
                    ProductTitleView(title: product.title)
                }
            }
        }
    }
}

#Preview {
    ProductCardView(product: Product(id: -1,
                                     title: "",
                                     price: 0.0,
                                     description: "", 
                                     category: "", 
                                     image: "",
                                     rating: Rating(rate: 0.0, count: 0.0)))
}
