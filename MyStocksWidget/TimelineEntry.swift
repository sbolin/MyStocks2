//
//  TimelineEntry.swift
//  MyStocksWidgetExtension
//
//  Created by Scott Bolin on 14-Dec-21.
//

import SwiftUI
import WidgetKit


// model
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let stockData: StockData?
}
