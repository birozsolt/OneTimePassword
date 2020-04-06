//
//  CoordinateModel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 20/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class CoordinateModel: Codable {
    
    // MARK: - Properties
    
    var timeSerieQ1: TimeSerieModel
    var timeSerieQ2: TimeSerieModel
    var timeSerieQ3: TimeSerieModel
    var timeSerieQ4: TimeSerieModel
    
    // MARK: - Init
    
    init(coordsQ1: [Coordinate], coordsQ2: [Coordinate], coordsQ3: [Coordinate], coordsQ4: [Coordinate],
         normModelQ1: NormalizationModel? = nil, normModelQ2: NormalizationModel? = nil,
         normModelQ3: NormalizationModel? = nil, normModelQ4: NormalizationModel? = nil) {
        timeSerieQ1 = TimeSerieModel(with: coordsQ1, normModel: normModelQ1)
        timeSerieQ2 = TimeSerieModel(with: coordsQ2, normModel: normModelQ2)
        timeSerieQ3 = TimeSerieModel(with: coordsQ3, normModel: normModelQ3)
        timeSerieQ4 = TimeSerieModel(with: coordsQ4, normModel: normModelQ4)
    }
    
    // MARK: - Public methods
    
    func getSerie(forQuarter quarter: Quarters) -> TimeSerieModel {
        switch quarter {
        case .first:
            return timeSerieQ1
        case .second:
            return timeSerieQ2
        case .third:
            return timeSerieQ3
        case .fourth:
            return timeSerieQ4
        }
    }
    
    func isEmpty() -> Bool {
        return timeSerieQ1.isEmpty() || timeSerieQ2.isEmpty() || timeSerieQ3.isEmpty() || timeSerieQ4.isEmpty()
    }
}

// MARK: - Equatable methods

extension CoordinateModel: Equatable {
    static func == (lhs: CoordinateModel, rhs: CoordinateModel) -> Bool {
        return lhs.timeSerieQ1 == rhs.timeSerieQ1 &&
            lhs.timeSerieQ2 == rhs.timeSerieQ2 &&
            lhs.timeSerieQ3 == rhs.timeSerieQ3 &&
            lhs.timeSerieQ4 == rhs.timeSerieQ4
    }
}
