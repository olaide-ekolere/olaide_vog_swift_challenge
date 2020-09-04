//
//  UserProfileViewModel.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import SwiftUI
import Combine

class UserProfileViewModel: ObservableObject {
    @Published var dataSource: UserResponseViewModel?
    @Published var failed: Bool = false
    
    private let userFetcher: UserFetchable
    private var disposables = Set<AnyCancellable>()
    private let authorizationToken: String
    init(
        userFetcher: UserFetchable,
        authorizationToken: String) {
        self.userFetcher = userFetcher
        self.authorizationToken = authorizationToken
    }
    
    func fetchUserProfile() {
        failed = false
        userFetcher.userDetails(withToken: self.authorizationToken)
        .map(UserResponseViewModel.init)
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = nil
                    self.failed = true
                    print(value)
                case .finished:
                    self.failed = false
                    break
                }
            },
            receiveValue: { [weak self] userResponseViewModel in
                guard let self = self else { return }
                self.dataSource = userResponseViewModel
            }
        )
        .store(in: &disposables)
    }
}
