//
//  ProductTitleView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import SwiftUI

struct ProductTitleView: View {
    @State var title: String

    var body: some View {
        Text(title)
    }
}

#Preview {
    ProductTitleView(title: "")
}
