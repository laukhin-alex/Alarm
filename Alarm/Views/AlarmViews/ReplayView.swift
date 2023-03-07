//
//  ReplayView.swift
//  Alarm
//
//  Created by Александр on 05.03.23.
//

import SwiftUI

struct ReplayView: View {
    @EnvironmentObject var rVM: AlarmViewModel

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            List {
                ForEach(rVM.weekDays, id: \.id) { day in
                    HStack {
                        Button(rVM.weekDays[day.id - 1].nameOfTheDay) {
                            if rVM.selectedDays.contains(day) {
                                rVM.selectedDays.removeAll(where: { $0 == day })

                                print(rVM.selectedDays)
                            } else {
                                rVM.selectedDays.append(day)
                                print(rVM.selectedDays)
                            }

                        }
                        .foregroundColor(.white)
                        Spacer()
                        if rVM.selectedDays.contains(where: { $0 == day}) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.orange)

                        } else {
                            Text("")
                        }
                    }
                }
                .listRowSeparatorTint(.gray)
                .listRowBackground(Color.gray.opacity(0.1))
            }
        }
        .tint(.orange)
        .scrollContentBackground(.hidden)
    }
}

struct ReplayView_Previews: PreviewProvider {
    static var previews: some View {
        ReplayView()
            .environmentObject(AlarmViewModel())
    }
}
