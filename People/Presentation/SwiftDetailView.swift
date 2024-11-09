import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let pictureUrl = user.picture?.large, let url = URL(string: pictureUrl) {
                    AsyncImageViewSD(url: url)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 16)
                }

                if let name = user.name {
                    Text("\(name.title ?? "") \(name.first ?? "") \(name.last ?? "")")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                if let email = user.email {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.blue)
                        Text(email)
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }

                if let phone = user.phone {
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.green)
                        Text(phone)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }

                if let gender = user.gender {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.purple)
                        Text("Gender: \(gender.capitalized)")
                            .font(.headline)
                    }
                }

                if let location = user.location {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.red)
                            Text("Location:")
                                .font(.headline)
                        }
                        Text("\(location.city ?? ""), \(location.state ?? ""), \(location.country ?? "")")
                        HStack {
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                            Text("Coordinates: \(location.coordinates?.latitude ?? ""), \(location.coordinates?.longitude ?? "")")
                        }
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.orange)
                            Text("Timezone: \(location.timezone?.description ?? "") (\(location.timezone?.offset ?? ""))")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("User Detail")
    }
}
