//
//  UserResponseView.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import SwiftUI

struct UserResponseView: View {
    private let viewModel: UserResponseViewModel
    private let authToken: String
    private let userUpdateFetcher: UserUpdateFetchable
    private let changePasswordFetcher: ChangePasswordFetchable
    init(userUpdateFetcher: UserUpdateFetchable,
         changePasswordFetcher: ChangePasswordFetchable,
         viewModel: UserResponseViewModel,
         authToken: String) {
        self.userUpdateFetcher = userUpdateFetcher
        self.changePasswordFetcher = changePasswordFetcher
        self.viewModel = viewModel
        self.authToken = authToken
    }
    var body: some View {
        ScrollView(.vertical) {
          VStack {
            UserUpdateView(viewModel: UserUpdateViewModel(item: viewModel.item, userUpdateFetcher: self.userUpdateFetcher, authorizationToken: self.authToken))
            ChangePasswordView(viewModel: ChangePasswordViewModel(changePasswordFetcher: self.changePasswordFetcher, authorizationToken: self.authToken))
          }
        }
    }
}

/*
struct UserResponseView_Previews: PreviewProvider {
    static var previews: some View {
        UserResponseView()
    }
}
 */
