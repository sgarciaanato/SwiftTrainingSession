//
//  ProductImageView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import SwiftUI

struct ProductImageView: View {
    @State var imageUrlString: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)){ image in
            image.resizable()
        } placeholder: {
            Color.red
        }
        .frame(width: 120, height: 120)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    ProductImageView(imageUrlString: "")
}
