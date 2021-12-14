//
//  ContentView.swift
//  MyStocks2
//
//  Created by Scott Bolin on 16-May-21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var model = ContentViewModel()
    @State var symbol = ""

    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("Symbol", text: $model.symbol )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add", action: model.addStock)
                        .disabled(!model.symbolValid)
                }
                if !model.stockData.isEmpty {
                    ForEach(model.stockData) { stock in
                        HStack {
                            Text(stock.metaData.symbol)
                            
                            Spacer()
                            
                            LineChart(values: stock.closeValues)
                                .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),
                                    startPoint: .top,
                                    endPoint: .bottom)
                                )
                                .frame(width: 150, height: 50)
                            
                            VStack(alignment: .trailing) {
                                Text(stock.latestClose)
                                Text(stock.delta)
                            }
                            .frame(width: 100) // 75?
                        }
                    }
                    .onDelete(perform: model.delete)
                }
            }
            .navigationTitle(symbol == "" ? "My Stocks" : "\(symbol)")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                }
            }
        }
        .onOpenURL { url in
            guard url.scheme == "mystocks",
                  url.host == "symbol" else { return }
            symbol = url.pathComponents[1]
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
