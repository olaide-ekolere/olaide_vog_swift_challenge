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
    
    init(viewModel: UserResponseViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text("\(viewModel.item.data.firstName) \(viewModel.item.data.lastName)")
            .foregroundColor(.white)
        
    }
}

/*
struct UserResponseView_Previews: PreviewProvider {
    static var previews: some View {
        UserResponseView()
    }
}
 */
