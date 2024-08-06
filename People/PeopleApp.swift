//
//  PeopleApp.swift
//  People
//
//  Created by AntonioCano on 25/07/2024.
//

import SwiftUI

@main
struct RandomUserApp: App {
    var body: some Scene {
        WindowGroup {
            let remoteDataSource = UserRemoteDataSource()
            let userRepository = UserRepositoryImpl(remoteDataSource: remoteDataSource)
            let viewModel = UserViewModel(repository: userRepository)
            UserListView(viewModel: viewModel)
        }
    }
}

