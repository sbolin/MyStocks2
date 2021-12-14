//
//  BarChart.swift
//  MyStocks2
//
//  Created by Scott Bolin on 17-May-21.
//

import SwiftUI

struct BarChart: View {
    
    let data: [ChartData]
    @State var animated = false
    
    var body: some View {
        withAnimation {
            GeometryReader { proxy in
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(data) { entry in
                        VStack(alignment: .center) {
                            Spacer()

                            RoundedRectangle(cornerRadius: 4)
                                .frame(height: animated ? (proxy.size.height - 16) * (CGFloat(entry.value) / CGFloat(data.map(\.value).max()!)) : 0)
//                                .animation(.spring())

                            Text(entry.title)
                        }
                    }
                }
                .padding(.horizontal)
                .onAppear { animated = true }
            }
        }
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(data: ChartData.preview)
    }
}


struct ChartData: Identifiable {
    let id = UUID()
    let value: Double
    let title: String
    
    static let preview: [ChartData] = [
        ChartData(value: 0.5, title: "First"),
        ChartData(value: 0.7, title: "Second"),
        ChartData(value: 1.0, title: "Third"),
        ChartData(value: 0.85, title: "Fourth"),
        ChartData(value: 1.2, title: "Fifth")
    ]
    
}
