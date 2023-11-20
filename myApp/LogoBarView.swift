//
//  LogoBarView.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import SwiftUI

struct LogoBarView: View {
    var body: some View {
        HStack {
            Image("logo_app")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            Spacer()

            Text("Amstragram")
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
    }
}
