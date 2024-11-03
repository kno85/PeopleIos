//
//  AsyncImageView.swift
//  People
//
//  Created by AntonioCano on 06/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct AsyncImageViewSD: View {
    let url: URL?

    var body: some View {
        WebImage(url: url)
            .resizable()
            .indicator(.activity) // Activity Indicator while loading
            .transition(.fade(duration: 0.5)) // Fade Transition when loading completes
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 0.8))
            .frame(height: 250)
            .background(Color.gray.opacity(0.3))
            .aspectRatio(contentMode: .fill)
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: 200) // Ancho completo y altura de 200
            .clipped()
            .cornerRadius(15) // Esquinas redondeadas
            .padding(.top, 6)
    }
}
