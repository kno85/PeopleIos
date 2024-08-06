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
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
      
                    AsyncImageViewSD(url: URL(string: user.picture.large))
                    Text("\(user.name.first) \(user.name.last)")
                        .font(.headline)
                    Text(user.email ??  "")
                        .font(.subheadline)
                }
                .onAppear {
                    if user == viewModel.users.last {
                        viewModel.fetchUsers()
                    }
                }
            }
            .navigationTitle("Random Users")
            .onAppear {
                if viewModel.users.isEmpty {
                    viewModel.fetchUsers()
                }
            }
        }
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

}   
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id // <-- here, whatever is appropriate for you
    }
}
