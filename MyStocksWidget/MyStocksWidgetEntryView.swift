//
//  MyStocksWidgetEntryView.swift
//  MyStocksWidgetExtension
//
//  Created by Scott Bolin on 14-Dec-21.
//

import SwiftUI
import WidgetKit

struct MyStocksWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        case .systemLarge:
            Text("Large Family")
        default:
            Text("No Family")
        }
    }
}

