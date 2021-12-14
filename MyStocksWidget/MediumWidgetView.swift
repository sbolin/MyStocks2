//
//  MediumWidgetView.swift
//  MyStocks2
//
//  Created by Scott Bolin on 15-Dec-21.
//

import Intents
import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(entry.configuration.customSymbol?.identifier ?? "No custom symbol selected")
                Text(entry.configuration.symbol ?? "no value")
            }
            LineChart(values: entry.stockData?.closeValues ?? [])
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .frame(width: 150, height: 50)
        }
        .widgetURL(entry.stockData?.url)
    }
}

//struct MediumWidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediumWidgetView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}
