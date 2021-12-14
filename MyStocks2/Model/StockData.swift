//
//  StockData.swift
//  MyStocks2
//
//  Created by Scott Bolin on 16-May-21.
//

import Foundation

import Foundation

struct StockData: Codable, Identifiable {
    
    let id = UUID()
    let metaData: MetaData
    let timeSeries5min: [String: StockDataEntry]
    
    private enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries5min = "Time Series (5min)"
    }
    
    var latestClose: String {
        timeSeries5min.first?.value.close ?? ""
    }
    
    var delta: String {
        let low = Double(timeSeries5min.first?.value.low ?? "0")!
        let high = Double(timeSeries5min.first?.value.high ?? "0")!
        return String(high - low)
        
    }
    
    var closeValues: [Double] {
        let rawValues = timeSeries5min.values.map { Double($0.close)! }
        let max = rawValues.max()!
        let min = rawValues.min()!
        return rawValues.map { ($0 - min * 0.95) / (max - min * 0.95) } // scale
    }

    var url: URL {
        guard let url = URL(string: "mystocks://symbol/\(metaData.symbol)") else {
            fatalError("Failed to construct url")
        }
        return url
    }

    struct MetaData: Codable {
        let information: String
        let symbol: String
        let lastRefreshed: String
        let interval: String
        let outputSize: String
        let timeZone: String
        
        private enum CodingKeys: String, CodingKey {
            case information = "1. Information"
            case symbol = "2. Symbol"
            case lastRefreshed = "3. Last Refreshed"
            case interval = "4. Interval"
            case outputSize = "5. Output Size"
            case timeZone = "6. Time Zone"
        }
    }
    
    struct StockDataEntry: Codable {
        let open: String
        let high: String
        let low: String
        let close: String
        let volume: String
        
        private enum CodingKeys: String, CodingKey {
            case open = "1. open"
            case high = "2. high"
            case low = "3. low"
            case close = "4. close"
            case volume = "5. volume"
        }
    }
}
