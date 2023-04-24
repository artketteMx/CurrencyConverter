//
//  ConversionResponse.swift
//  TestiOS
//
//  Created by Arturo Cadena on 24/04/23.
//

import Foundation

struct ConversionResponse: Codable {
    let date: String
    let success: Bool
    let result: Double
}
