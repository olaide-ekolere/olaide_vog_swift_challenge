//
//  UserUpdateView.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 04/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import SwiftUI

struct UserUpdateView: View {
    @ObservedObject var viewModel: UserUpdateViewModel
    init(viewModel: UserUpdateViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            Spacer(minLength: 24.0)
            ZStack {
                Color.white
                VStack(alignment: .center){
                    HStack {
                        Text("BASIC INFORMATION")
                            .padding(.leading, 24.0)
                            .accessibility(identifier: "edit-title-text")
                    }
                    .frame(maxWidth: .infinity, minHeight: 36.0, alignment: .leading)
                    .background(Color.init(red: 239.0/239.0, green: 239.0/255.0, blue: 243.0/255.0))
                    .foregroundColor(Color.gray)
                    .font(.subheadline)
                    VStack(alignment: .leading) {
                        userNameView
                        Divider()
                        firstNameView
                        Divider()
                        lastNameView
                        Divider()
                    }
                    .padding(.leading, 24.0)
                }
            }
            //Spacer(minLength: 24.0)
            Text(self.viewModel.dataSource == "User Retrieved" ? "Updated Successfully" :
            self.viewModel.dataSource)
                .foregroundColor(.white)
                .font(.body)
                .padding(.top, 4.0)
                .padding(.bottom, 8.0)
            Button(action:{
                if (!self.viewModel.isLoading) {
                    self.validateForm()
                }
            }) {
                Text(self.viewModel.isLoading ? "UPDATING..." : "SAVE CHANGES")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .tracking(2)
                    .padding(.horizontal, 32.0)
                    .padding(.vertical, 12.0)
                    .border(Color.white, width: 2)
                    .cornerRadius(4.0)
            }
        }
    }
}

private extension UserUpdateView {
    var userNameView: some View {
        HStack(alignment: .center) {
            Text("Username")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding(.top, 4)
                .padding(.bottom, 4)
            TextField("e.g. coolion", text: $viewModel.userName)
            .disabled(true)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    var firstNameView: some View {
        HStack(alignment: .center) {
            Text("First Name")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding(.top, 4)
                .padding(.bottom, 4)
            TextField("e.g. coolion", text: $viewModel.firstName)
                .disabled(viewModel.isLoading)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    var lastNameView: some View {
        HStack(alignment: .center) {
            Text("Last Name")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding(.top, 4)
                .padding(.bottom, 4)
            TextField("e.g. coolion", text: $viewModel.lastName)
            .disabled(viewModel.isLoading)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    
    
    func validateForm() {
        print(self.viewModel.firstName)
        print(self.viewModel.lastName)
        if (self.viewModel.firstName.count<4){
            self.viewModel.dataSource = "First Name must be at least 4 characters"
        }
        else if (self.viewModel.lastName.count<4){
            self.viewModel.dataSource = "Last Name must be at least 4 characters"
        }
        else {
            let userUpdate = UserUpdate(firstName: self.viewModel.firstName, lastName: self.viewModel.lastName)
            self.viewModel.performUserUpdate(userUpdate: userUpdate)
        }
    }
}
/*
struct UserUpdateView_Previe/Users/olaidenojeemekeolere/XcodeProjects/vogswiftchallenge/vogswiftchallenge/User/UserProfile/UserProfileView.swiftws: PreviewProvider {
    static var previews: some View {
        UserUpdateView()
    }
}
*/
