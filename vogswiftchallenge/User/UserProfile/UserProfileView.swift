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
                content
            }
            .onAppear(perform: viewModel.fetchUserProfile)
            .navigationBarTitle("User Profile")
        }
    }
}

private extension UserProfileView {
    var content: some View {
        if let viewModel = viewModel.dataSource {
            if(self.viewModel.failed){
                return AnyView(retryView);
            }
            else {
                return AnyView(UserResponseView(userUpdateFetcher: userUpdateFetcher,
                                            changePasswordFetcher: changePasswordFetcher,
                                            viewModel: viewModel,
                                            authToken: self.viewModel.authorizationToken)
                .accessibility(identifier: "UserResponseView"))
            }
        }
        else{
            if(self.viewModel.failed){
                return AnyView(retryView);
            }
            else {
                return AnyView(loading)
            }
        }
    }
    
    var retryView: some View {
         VStack {
            Text("Could Not Load Profile")
                .foregroundColor(.white)
                .padding(.bottom, 8.0)
                .accessibility(identifier: "profile-error-text")
            
            Button(action:{
                self.viewModel.fetchUserProfile()
            }) {
                Text("RETRY")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .tracking(2)
                    .padding(.horizontal, 32.0)
                    .padding(.vertical, 12.0)
                    .border(Color.white, width: 2)
                    .cornerRadius(4.0)
            }
         .accessibility(identifier: "profile-retry-button")
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
