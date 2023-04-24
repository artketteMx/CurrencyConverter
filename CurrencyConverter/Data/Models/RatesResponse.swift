//
//  RatesResponse.swift
//  CurrencyConverter
//
//  Created by Arturo Cadena on 24/04/23.
//

import Foundation

struct RatesResponse: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
    let success: Bool
    let timestamp: Int
}
