//
//  UserRemoteDataSource.swift
//  People
//
//  Created by AntonioCano on 06/08/2024.
//

import Foundation
import RxSwift

class UserRemoteDataSource {
    func fetchUsers(page: Int) -> Single<[User]> {
        let API_KEY = "W6I5-ZEYE-IP3V-APR08"

        let urlString = "https://randomuser.me/api/?key=\(API_KEY)&?page=\(page)&results=10"

        guard let url = URL(string: urlString) else {
            return .error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                let response = try JSONDecoder().decode(RandomUserResponse.self, from: data)
                return response.results
            }
            .asSingle()
    }
}

struct RandomUserResponse: Codable {
    let results: [User]
}
