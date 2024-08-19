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
                            HStack(spacing: 16) {                            AsyncImageViewSD(url: URL(string: user.picture.large))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 100)
                                    .clipShape(Circle())
                                    .padding(.top, 16)
                                VStack(alignment: .leading) {
                                    Text("\(user.name.first) \(user.name.last)")
                                        .font(.headline)
                                }
                                .padding(.horizontal) // Padding alrededor del HStack
                            }
                            .onAppear {
                                if user == viewModel.users.last {
                                    viewModel.fetchUsers()
                                }
                            }
                        }}}
                .padding(.horizontal) // Padding alrededor del HStack
            }            .navigationTitle("Random Users")
                .onAppear {
                    if viewModel.users.isEmpty {
                        viewModel.fetchUsers()
                    }
                }
        }}
    }
    


    struct CardView<Content: View>: View {
        let content: Content
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            content
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
    }
    
                               class ImageLoader: ObservableObject {
        enum LoadState {
            case loading, success(UIImage), failure
        }
        
        @Published var state = LoadState.loading
        
        private let url: URL?
        private var cancellable: AnyCancellable?
        
        init(url: URL?) {
            self.url = url
        }
        
        func load() {
            guard let url = url else {
                state = .failure
                return
            }
            
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] image in
                    if let image = image {
                        self?.state = .success(image)
                    } else {
                        self?.state = .failure
                    }
                }
        }
        
        deinit {
            cancellable?.cancel()
        }

}   
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id // <-- here, whatever is appropriate for you
    }
}
