//
//  TimeLineProvider.swift
//  MyStocksWidgetExtension
//
//  Created by Scott Bolin on 14-Dec-21.
//

import Combine
import Intents
import SwiftUI
import WidgetKit

// timeline provider - refresh widget at set intervals
class Provider: IntentTimelineProvider {
    var cancellable: Set<AnyCancellable> = []

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), stockData: nil)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        createTimelineEntry(date: Date(), configuration: configuration, completion: completion)

//        let entry = SimpleEntry(date: Date(), configuration: configuration)
//        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        createTimeline(date: Date(), configuration: configuration, completion: completion)
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration, stockData: <#StockData?#>)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
    }

    func createTimelineEntry(date: Date, configuration: ConfigurationIntent, completion: @escaping (SimpleEntry) -> ()) {
        StockService
            .getStockData(for: configuration.symbol ?? "APPL")
            .sink { _ in } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuration, stockData: stockData)
                completion(entry)
            }
            .store(in: &cancellable)

    }

    func createTimeline(date: Date, configuration: ConfigurationIntent, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        StockService
            .getStockData(for: configuration.symbol ?? "APPL")
            .sink { _ in } receiveValue: { stockData in
                let entry = SimpleEntry(date: date, configuration: configuration, stockData: stockData)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
            .store(in: &cancellable)
    }
}
