//
//  SmallWidgetView.swift
//  MyStocks2
//
//  Created by Scott Bolin on 15-Dec-21.
//


import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.configuration.customSymbol?.identifier ?? "No custom symbol")
            Text(entry.configuration.symbol ?? "no value")
            LineChart(values: entry.stockData?.closeValues ?? [])
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .frame(width: 150, height: 50)

            // optional method to open from widget, can add multiple links within one widget, so different views open depending on where user clicks. Note force unwrap of url
            /*
            Link(destination: entry.stockData!.url) {

            }
             */
        }
        .widgetURL(entry.stockData?.url) // simple method, but only one click zone
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
