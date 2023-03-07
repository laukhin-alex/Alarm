//
//  MelodyViews.swift
//  Alarm
//
//  Created by Александр on 07.03.23.
//

import SwiftUI

struct MelodyViews: View {
    @EnvironmentObject var alarmVM: AlarmViewModel

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            List {
                ForEach(alarmVM.melody, id: \.self) { item in
                    SelectionCell(melody: item, selectedMelody: self.$alarmVM.selectedMelody)
                }
                .listRowSeparatorTint(.gray)
                .listRowBackground(Color.gray.opacity(0.1))
            }
            .tint(.orange)
            .scrollContentBackground(.hidden)
        }
    }
}

struct SelectionCell: View {

    let melody: String
    @Binding var selectedMelody: String?

    var body: some View {
        HStack {
            Text(melody)
                .foregroundColor(.white)
            Spacer()
            if melody == selectedMelody {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }   .onTapGesture {
            self.selectedMelody = self.melody
        }
    }
}

struct MelodyViews_Previews: PreviewProvider {
    static var previews: some View {
        MelodyViews()
            .environmentObject(AlarmViewModel())
    }
}
