//
//  SwiftDetailView.swift
//  People
//
//  Created by AntonioCano on 19/08/2024.
//

import SwiftUI


struct UserDetailView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageViewSD(url: URL(string: user.picture.large))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 16)

                Text("\(user.name.first) \(user.name.last)")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(user.email ?? "")
                    .font(.title2)
                    .foregroundColor(.gray)

                Text(user.phone ?? "")
                    .font(.title3)
                    .foregroundColor(.gray)

            }
            .padding(.horizontal)
        }
        .navigationTitle("User Detail")
    }
}
