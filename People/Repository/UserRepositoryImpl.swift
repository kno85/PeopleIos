//
//  UserRepositoryImp.swift
//  People
//
//  Created by AntonioCano on 06/08/2024.
//

import RxSwift

class UserRepositoryImpl: UserRepository {
    private let remoteDataSource: UserRemoteDataSource
    
    init(remoteDataSource: UserRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchUsers(page: Int) -> Single<[User]> {
        return remoteDataSource.fetchUsers(page: page)
    }
}
