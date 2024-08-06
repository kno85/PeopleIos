//
//  UserRepository.swift
//  People
//
//  Created by AntonioCano on 06/08/2024.
//

import RxSwift

protocol UserRepository {
    func fetchUsers(page: Int) -> Single<[User]>
}
