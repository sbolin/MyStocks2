//
//  MyStocksWidget.swift
//  MyStocksWidget
//
//  Created by Scott Bolin on 14-Dec-21.
//

import Intents
import SwiftUI
import WidgetKit

@main
struct StockWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        MyStocksWidget()
    }
}

// main entry point to widget
struct MyStocksWidget: Widget {
    let kind: String = "MyStocksWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyStocksWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Stocks Widget")
        .description("Choose stock to display in widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct MyStocksWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyStocksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            MyStocksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

//            MyStocksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil))
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
