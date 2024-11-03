//
//  UserListView.swift
//  People
//
//  Created by AntonioCano on 06/08/2024.
//

import SwiftUI
import Combine

struct UserListView: View {
    @StateObject private var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    // Vista de la tarjeta individual
    struct CardView: View {
        let persona: User
        
        var body: some View {
            VStack(alignment: .leading) {
                // Imagen
                AsyncImageViewSD(url: URL(string: persona.picture.large))
                // Nombre y Apellidos
                VStack(alignment: .leading, spacing: 1) {
                    Text(persona.name.first)
                        .font(.headline)
                    
                    Text(persona.name.last)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding([.top, .leading, .trailing])
            }
                
  
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
                            CardView(persona:user)
                   }       .onAppear {
                                if user == viewModel.users.last {
                                    viewModel.fetchUsers()
                                }
                        }}}
            }            .navigationTitle("Random Users")
                .onAppear {
                    if viewModel.users.isEmpty {
                        viewModel.fetchUsers()
                    }
                }
        }}
    }
    

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id // <-- here, whatever is appropriate for you
    }
}
