//
//  UserUpdateViewModel.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import SwiftUI
import Combine

class UserUpdateViewModel : ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var dataSource: String?
    @Published var isLoading: Bool = false
    
    let userName: String
    
    
    private let userUpdateFetcher: UserUpdateFetchable
    private var disposables = Set<AnyCancellable>()
    private let authorizationToken: String
    init(item: UserResponse,
         userUpdateFetcher: UserUpdateFetchable,
         authorizationToken: String) {
        self.firstName = item.data.firstName
        self.lastName = item.data.lastName
        self.userName = item.data.userName
        self.userUpdateFetcher = userUpdateFetcher
        self.authorizationToken = authorizationToken
    }
    
    
    func performUserUpdate(userUpdate: UserUpdate) {
        dataSource = nil
        isLoading = true
        userUpdateFetcher.performUserUpdate(userUpdate: userUpdate, withToken: self.authorizationToken)
        .map(UserResponseViewModel.init)
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = "\(value)"
                    self.isLoading = false
                    print(value)
                case .finished:
                    //self.dataSource = nil
                    self.isLoading = false
                    break
                }
            },
            receiveValue: { [weak self] userResponseViewModel in
                guard let self = self else { return }
                self.dataSource = userResponseViewModel.item.message
                let data = userResponseViewModel.item.data
                self.firstName = data.firstName
                self.lastName = data.lastName
            }
        )
        .store(in: &disposables)
    }
}
