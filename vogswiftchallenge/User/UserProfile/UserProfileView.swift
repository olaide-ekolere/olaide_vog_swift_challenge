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
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().backgroundColor = .white
        
    }
    var body: some View {
        NavigationView {
            ZStack { Color.init(red: 143.0/255.0, green: 32.0/255.0, blue: 31.0/255.0).edgesIgnoringSafeArea(.bottom)
                VStack {
                    Text("Welcome\nTo\nSwiftUI")
                }
            }
            .navigationBarTitle("User Profile")
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
