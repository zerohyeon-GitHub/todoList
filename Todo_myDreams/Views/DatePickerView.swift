//
//  DatePickerView.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/30.
//

import SwiftUI

struct DatePickerView: View {
    @State var date = Date()
      
      var body: some View {
        DatePicker(
          "Start Date",
          selection: $date,
          displayedComponents: [.date]
        )
        .padding()
        .background(.yellow)
        .cornerRadius(15)
        .padding()
      }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
