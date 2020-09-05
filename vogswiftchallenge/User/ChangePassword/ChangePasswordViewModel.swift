//
//  ChangePasswordViewModel.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//


import SwiftUI
import Combine

class ChangePasswordViewModel : ObservableObject {
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var dataSource: String = ""
    @Published var code: String = ""
    @Published var isLoading: Bool = false
    
    
    private let changePasswordFetcher: ChangePasswordFetchable
    private var disposables = Set<AnyCancellable>()
    private let authorizationToken: String
    init(changePasswordFetcher: ChangePasswordFetchable,
         authorizationToken: String) {
        self.changePasswordFetcher = changePasswordFetcher
        self.authorizationToken = authorizationToken
        #if DEBUG
        if CommandLine.arguments.contains("filled-password") ||
            CommandLine.arguments.contains("failed-change-password") {
            currentPassword = "oldpassword"
            newPassword = "newpassword"
        }
        #endif
    }
    
    
    func performChangePassword(changePassword: ChangePassword) {
        dataSource = ""
        isLoading = true
        changePasswordFetcher.performChangePassword(changePassword: changePassword, withToken: self.authorizationToken)
        .map(ChangePasswordResponseViewModel.init)
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
            receiveValue: { [weak self] changePasswordResponseViewModel in
                guard let self = self else { return }
                self.dataSource = changePasswordResponseViewModel.item.message
                self.code = changePasswordResponseViewModel.item.code
                if (self.code=="200") {
                    self.currentPassword = ""
                    self.newPassword = ""
                    self.confirmPassword = ""
                }
            }
        )
        .store(in: &disposables)
    }
}

