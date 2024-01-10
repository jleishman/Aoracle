//
//  ContentViewModel.swift
//  Aoracle
//
//  Created by Justin Leishman on 11/13/23.
//

import Foundation
import OSLog

class OracleViewModel: ObservableObject {
    let logger = Logger(subsystem: "Aoracle", category: "ContentViewModel")

    enum Value: Hashable, CustomStringConvertible {
        case blue
        case green
        
        var description: String {
            switch self {
            case .blue: "B"
            case .green: "G"
            }
        }
    }
    
    @Published var values = [Value]()
    @Published var histogram = [[Value] : [Value : Int]]()
    
    @Published var prediction: Value?
    @Published var correctPredictions = 0
    @Published var totalPredictions = 0
    @Published var predictionPercentage: Double?
    
    let nGramSize = 5
    let corpusSize = 20

    func append(_ value: Value) {
        logger.debug("Appending value: \(value)")
        
        values.append(value)
        
        logger.debug("values.count: \(self.values.count)")
        
        if prediction == value {
            logger.debug("Prediction was correct, incrementing correctPredictions")
            correctPredictions += 1
            logger.debug("correctPredictions: \(self.correctPredictions)")
        }

        if values.count > nGramSize {
            let previousNGram = Array(values[(values.endIndex - nGramSize - 1)..<(values.endIndex - 1)])

            logger.debug("values: \(self.values)")
            logger.debug("nGram: \(previousNGram)")
            
            update(previousNGram, value)
            
            if values.count > corpusSize {
                let currentNGram = Array(values[(values.endIndex - nGramSize)..<values.endIndex])
                
                prediction = predict(currentNGram)
                
                logger.debug("Incrementing total predictions")
                totalPredictions += 1
                
                logger.debug("correctPredictions: \(self.correctPredictions)")
                logger.debug("totalPredictions: \(self.totalPredictions)")
                
                if totalPredictions > 0 {
                    predictionPercentage = 100 * Double(correctPredictions) / Double(totalPredictions)
                    logger.debug("predictionPercentage: \(self.predictionPercentage!)")
                }
            }
        }
    }
    
    func reset() {
        values = []
        histogram = [:]
        prediction = nil
        correctPredictions = 0
        totalPredictions = 0
        predictionPercentage = nil
    }
    
    private func update(_ nGram: [Value], _ next: Value) {
        logger.debug("Updating histogram for \(nGram) with value: \(next)")
        
        var current = current(nGram)
        
        logger.debug("Current histogram for \(nGram): \(current)")
        
        current[next] = (current[next] ?? 0) + 1
        
        logger.debug("Updated histogram for \(nGram): \(current)")
        
        histogram[nGram] = current
    }
    
    private func current(_ nGram: [Value]) -> [Value : Int] {
        if let current = histogram[nGram] {
            return current
        }
        
        return [.blue : 0, .green: 0]
    }
    
    private func predict(_ nGram: [Value]) -> Value {
        logger.debug("Predicting next value for \(nGram)")

        let current = current(nGram)
        
        logger.debug("Current histogram for \(nGram): \(current)")

        if current[.blue] ?? 0 >= current[.green] ?? 0 {
            logger.debug("Predicting blue for next value")

            return .blue
        }
        
        logger.debug("Predicting green for next value")

        return .green
    }
}

