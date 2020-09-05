//
//  UserProfileView.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    private let userUpdateFetcher: UserUpdateFetchable
    private let changePasswordFetcher: ChangePasswordFetchable
    init(viewModel: UserProfileViewModel,
    userUpdateFetcher: UserUpdateFetchable,
    changePasswordFetcher: ChangePasswordFetchable) {
        self.viewModel = viewModel
        self.userUpdateFetcher = userUpdateFetcher
        self.changePasswordFetcher = changePasswordFetcher
        UINavigationBar.appearance().backgroundColor = .none
        
    }
    var body: some View {
        NavigationView {
            ZStack { Color.init(red: 143.0/255.0, green: 32.0/255.0, blue: 31.0/255.0).edgesIgnoringSafeArea(.bottom)
                content()
            }
            .onAppear(perform: viewModel.fetchUserProfile)
            .navigationBarTitle("User Profile")
        }
    }
}

private extension UserProfileView {
    func content() -> some View {
        if let viewModel = viewModel.dataSource {
            return AnyView(UserResponseView(userUpdateFetcher: userUpdateFetcher,
                                            changePasswordFetcher: changePasswordFetcher,
                                            viewModel: viewModel,
                                            authToken: self.viewModel.authorizationToken)
                .accessibility(identifier: "UserResponseView"))
        }
        else{
            return AnyView(loading)
        }
    }
    
    var loading: some View {
       VStack {
          Text("Loading")
            .foregroundColor(.white)
       }
    }
}
/*
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
 */
