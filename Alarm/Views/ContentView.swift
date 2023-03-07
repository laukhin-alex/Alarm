//
//  ContentView.swift
//  Alarm
//
//  Created by Александр on 05.03.23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 2
    @EnvironmentObject var alarmVM: AlarmViewModel

    var body: some View {
        ZStack {
            Color.black

            TabView(selection: $selectedTab) {
                TestView()
                    .tabItem {
                        Label("Мировые часы", systemImage: "globe")
                    }
                    .tag(1)
                AlarmView()
                    .tabItem {
                        Label("Будильник", systemImage: "alarm")
                    }
                    .tag(2)
                TestView()
                    .tabItem {
                        Label("Секундомер", systemImage: "stopwatch")
                    }
                    .tag(3)
                TestView()
                    .tabItem {
                        Label("Таймер", systemImage: "timer")
                    }
                    .tag(4)
            }
            .accentColor(.orange)

        }
        .onAppear {
            alarmVM.tabBarPreferences()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AlarmViewModel())
    }
}
