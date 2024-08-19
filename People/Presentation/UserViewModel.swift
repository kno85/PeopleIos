//
//  UserViewModel.swift
//  People
//
//  Created by AntonioCano on 06/08/2024.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    
    private let repository: UserRepository
    private let disposeBag = DisposeBag()
    private var page = 1
    @Published var searchText: String = "" {
        didSet {
            filterUsers()
        }
    }
    @Published var filteredUsers: [User] = []

    init(repository: UserRepository) {
        self.repository = repository
        fetchUsers()
    }

    func fetchUsers() {
        guard !isLoading else { return }
        isLoading = true
        
        repository.fetchUsers(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .success(let users):
                    self?.users.append(contentsOf: users)
                    self?.page += 1
                    self?.filterUsers() // Llamar al filtrado después de cargar los usuarios

                case .failure(let error):
                    print("Error fetching users: \(error)")
                }
                
                self?.isLoading = false
            }
            .disposed(by: disposeBag)
    }
    func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { user in
                user.name.first.lowercased().contains(searchText.lowercased()) ||
                user.name.last.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
