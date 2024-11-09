import SwiftUI
import Combine

struct UserListView: View {
    @StateObject private var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // Vista de la tarjeta individual
    struct CardView: View {
        let user: User
        
        var body: some View {
            HStack(alignment: .top, spacing: 16) {
                if let pictureUrl = user.picture?.large, let url = URL(string: pictureUrl) {
                    AsyncImageViewSD(url: url)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 3)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    if let name = user.name {
                        // Nombre y Apellidos
                        Text("\(name.first ?? "") \(name.last ?? "")")
                            .font(.headline)
                    }
                    
                    Text(user.email ?? "Email no disponible")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(user.phone ?? "Teléfono no disponible")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack {
                    if let gender = user.gender {
                        Text(gender.capitalized)
                            .font(.caption)
                            .padding(4)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    
                    if let location = user.location {
                        Text(location.city ?? "")
                            .font(.caption)
                            .padding(4)
                            .background(Color.green.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Campo de búsqueda
                TextField("Search by name or surname", text: $viewModel.searchText)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                List {
                    ForEach(viewModel.filteredUsers) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            CardView(user: user)
                        }
                        .onAppear {
                            if user == viewModel.users.last {
                                viewModel.fetchUsers()
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Random Users")
            .onAppear {
                if viewModel.users.isEmpty {
                    viewModel.fetchUsers()
                }
            }
        }
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}
