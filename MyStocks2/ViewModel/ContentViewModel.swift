//
//  ContentViewModel.swift
//  MyStocks2
//
//  Created by Scott Bolin on 16-May-21.
//

import Combine
import Foundation
import Intents
import SwiftUI

final class ContentViewModel: ObservableObject {
    // could use @Environment to pass viewContext, too
    private let context = PersistenceController.shared.container.viewContext
    private var cancellable = Set<AnyCancellable>()

    @Published var stockData: [StockData] = []
    @Published var symbolValid = false
    @Published var symbol = ""
    @Published var stockEntities: [StockEntity] = []
    
    init() {
        loadFromCoreDate()
        loadAllSymbols()
        validateSymbolField()
    }
    
    func loadFromCoreDate() {
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func validateSymbolField() {
        $symbol
            .sink { [unowned self] newValue in
                self.symbolValid =  (!newValue.isEmpty && newValue.count < 5)
            }
            .store(in: &cancellable)
    }
    
    func addStock() {
        let newStock = StockEntity(context: context)
        newStock.symbol = symbol
        
        do {
            try context.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        stockEntities.append(newStock)
        getStockData(for: symbol)
        
        symbol = ""
    }
    
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        stockData.remove(at: index)
        let stockToRemove = stockEntities.remove(at: index)
        context.delete(stockToRemove)
        do {
            try context.save()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    func loadAllSymbols() {
        stockData = []
        stockEntities.forEach { stockEntity in
            getStockData(for: stockEntity.symbol ?? "")
        }
    }
    
    func getStockData(for symbol: String) {
        StockService
            .getStockData(for: symbol)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completed sink")
                    return
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                    return
                }
            } receiveValue: { [unowned self] stockData in
                DispatchQueue.main.async {
                    self.stockData.append(stockData)
                }
            }
            .store(in: &cancellable)
    }

    func donateIntent() {
        let intent = ConfigurationIntent()
        // hardcoded, but should get data from widget
        intent.customSymbol = CustomSymbol(identifier: "AAPL", display: "Apple")

        let interaction = INInteraction(intent: intent, response: nil)
        interaction.identifier = "AAPL-interaction"
        interaction.donate { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        INInteraction.delete(with: ["AAPL-interaction"]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

