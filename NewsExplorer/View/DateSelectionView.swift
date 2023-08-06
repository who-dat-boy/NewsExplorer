//
//  DateSelectionView.swift
//  NewsExplorer
//
//  Created by Arthur ? on 06.08.2023.
//

import SwiftUI

struct DateSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NewsViewModel
    @Binding var isTimeIntervalSet: Bool
    
    @State private var timeIntervalFrom: Date = Date()
    @State private var timeIntervalTo: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(spacing: 20) {
                    DatePicker("From", selection: $timeIntervalFrom, in: ...Date.now)
                    
                    DatePicker("To", selection: $timeIntervalTo, in: ...Date.now)
                }
                .padding(.vertical, 20)
                
                HStack {
                    Button {
                        // get iso dates from Swift-Date-type values
                        let isoDateFrom = getISODate(from: timeIntervalFrom)
                        let isoDateTo   = getISODate(from: timeIntervalTo)
                        
                        // set viewModels url with time attributes
                        viewModel.url = URL(string: "https://newsapi.org/v2/everything?q=kanye%20west&from=\(isoDateFrom)&to=\(isoDateTo)&apiKey=6f69beda71054145b5d7fc6ca2cf3934")
                        
                        // set time interval boolean
                        isTimeIntervalSet = true
                        
                        // dismiss the view
                        dismiss()
                    } label: {
                        Text("Set time interval").bold()
                    }
                    .disabled(setButtonDisabled)
                    
                    Spacer()
                    
                    Button(role: .destructive) {
                        // set default viewModels url
                        viewModel.url = URL(string: "https://newsapi.org/v2/everything?q=kanye%20west&apiKey=6f69beda71054145b5d7fc6ca2cf3934")
                        
                        // set time interval boolean
                        isTimeIntervalSet = false
                        
                        // dismiss the view
                        dismiss()
                    } label: {
                        Text("Reset").bold()
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Set time interval")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var setButtonDisabled: Bool {
        !(timeIntervalFrom <= timeIntervalTo) || (timeIntervalFrom == timeIntervalTo)
    }
    
    func getISODate(from date: Date) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime]

        return isoDateFormatter.string(from: date)
    }
}

struct DateSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DateSelectionView(viewModel: NewsViewModel(), isTimeIntervalSet: .constant(false))
    }
}
