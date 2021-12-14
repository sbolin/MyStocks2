//
//  IntentHandler.swift
//  MyStocksAppIntents
//
//  Created by Scott Bolin on 15-Dec-21.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {

    func provideSymbolOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {

    }

    func resolveSymbol(for intent: ConfigurationIntent, with completion: @escaping (INStringResolutionResult) -> Void) {

    }

    func resolveCustomSymbol(for intent: ConfigurationIntent, with completion: @escaping (CustomSymbolResolutionResult) -> Void) {

    }

    func provideCustomSymbolOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<CustomSymbol>?, Error?) -> Void) {

        let symbols: [CustomSymbol] = [
            CustomSymbol(identifier: "AAPL", display: "Apple"),
            CustomSymbol(identifier: "IBM", display: "IBM"),
            CustomSymbol(identifier: "TSLA", display: "Tesla"),
            CustomSymbol(identifier: "MSFT", display: "Microsoft"),
        ]

        let collection = INObjectCollection(items: symbols)
        completion(collection, nil)
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
