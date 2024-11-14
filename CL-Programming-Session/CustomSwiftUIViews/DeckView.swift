//
//  DeckView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import SwiftUI

struct DeckView: View {

    @State private var scrollPosition: Int? = nil
    @State var products: [Product] = [] {
        didSet {
            debugPrint("Pasa")
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(products, id: \.self) { product in
                    ProductCardView(product: product)
                        .frame(width: 200, height: 200)
                        .cornerRadius(10)
                        .id(product)
                        .visualEffect { content, proxy in
                            content
                                .scaleEffect(scale(proxy, scale: 0.1), anchor: .trailing)
                                .rotationEffect(rotation(proxy))
                                .offset(x: minX(proxy))
                                .offset(x: excessMinX(proxy, offset: 10))
                        }
                        .zIndex(products.zIndex(product))
                }
                .shadow(radius: 1)
                .foregroundStyle(.black)
            }
            .padding(.vertical, 40)
        }
        .safeAreaPadding(.horizontal, 100)
        .scrollTargetLayout()
        .scrollTargetBehavior(.viewAligned)
        .scrollBounceBehavior(.basedOnSize)
        .scrollPosition(id: Binding($products), anchor: .center)
        .animation(.smooth, value: products)
    }

    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }

    func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        // converting into progress
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        return cappedProgress
    }

    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)

        return 1 - (progress * scale)
    }

    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)

        return progress * offset
    }

    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)

        return .init(degrees: progress * rotation)
    }
}

#Preview {
    DeckView(products: [])
}
