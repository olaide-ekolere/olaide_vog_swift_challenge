//
//  ChangePasswordView.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 05/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import SwiftUI

struct ChangePasswordView: View {
    //@Environment(\.firstResponder) private var firstResponder: ObjectIdentifier
    @ObservedObject var viewModel : ChangePasswordViewModel
    init(viewModel : ChangePasswordViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            Spacer(minLength: 24.0)
            ZStack {
                Color.white
                VStack(alignment: .center){
                    HStack {
                        Text("PASSWORD")
                            .padding(.leading, 24.0)
                    }
                    .frame(maxWidth: .infinity, minHeight: 36.0, alignment: .leading)
                    .background(Color.init(red: 239.0/239.0, green: 239.0/255.0, blue: 243.0/255.0))
                    .foregroundColor(Color.gray)
                    .font(.subheadline)
                    VStack(alignment: .leading) {
                        currentPasswordView
                        Divider()
                        newPasswordView
                        Divider()
                        confirmPasswordView
                        Divider()
                    }
                    .padding(.leading, 24.0)
                }
            }
            //Spacer(minLength: 24.0)
            Text(self.viewModel.dataSource)
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
        .accessibility(identifier: "change-password-button")
        }
    }
}

private extension ChangePasswordView {
    var currentPasswordView: some View {
        HStack(alignment: .center) {
            Text("Current Password")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding(.top, 4)
                .padding(.bottom, 4)
            SecureField("", text: $viewModel.currentPassword)
                .disabled(viewModel.isLoading)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .accessibility(identifier: "current-password-field")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    var newPasswordView: some View {
        HStack(alignment: .center) {
            Text("New Password")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding(.top, 4)
                .padding(.bottom, 4)
            SecureField("", text: $viewModel.newPassword)
                .disabled(viewModel.isLoading)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .accessibility(identifier: "new-password-field")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    var confirmPasswordView: some View {
        HStack(alignment: .center) {
            Text("Re-enter Password")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .padding(.top, 4)
                .padding(.bottom, 4)
            SecureField("", text: $viewModel.confirmPassword)
                .disabled(viewModel.isLoading)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .accessibility(identifier: "confirm-password-field")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
        
        
        
    func validateForm() {
        if (self.viewModel.currentPassword.count<4){
            self.viewModel.dataSource = "Current password must be at least 4 characters"
        }
        else if (self.viewModel.newPassword.count<4){
            self.viewModel.dataSource = "New Password must be at least 4 characters"
        }
        else if (self.viewModel.newPassword != self.viewModel.confirmPassword){
            self.viewModel.dataSource = "Re-enter Password not match New Password"
        }
        else {
            let changePassword = ChangePassword(currentPassword: self.viewModel.currentPassword, newPassword: self.viewModel.newPassword, confirmPassword: self.viewModel.confirmPassword)
            self.viewModel.performChangePassword(changePassword: changePassword)
        }
    }
}

/*
struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
 */
