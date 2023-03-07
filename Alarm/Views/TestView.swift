//
//  TestView.swift
//  Alarm
//
//  Created by Александр on 05.03.23.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Color.black

            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
        }
        .ignoresSafeArea(.all)

    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
