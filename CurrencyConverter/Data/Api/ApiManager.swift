//
//  ApiManager.swift
//  TestiOS
//
//  Created by Arturo Cadena on 24/04/23.
//

import Foundation
import Alamofire


class ApiManager: BaseApiManager {
    static func convertFromoHNLTo(otherCurrency: Currency, amount: Double, onResponse: @escaping(ConversionResponse?, Error?)->()) {
        let parameters: Parameters = [
            "from": "HNL",
            "to": otherCurrency.rawValue,
            "amount": amount
        ]
        let url: String = "https://api.apilayer.com/fixer/convert"

        executeService(url: url, httpMethod: .get, parameters: parameters, onResponse: onResponse)
    }
    
    static func getHNLRates(onResponse: @escaping(RatesResponse?, Error?)->()) {
        let parameters: Parameters = [
            "base": "HNL",
            "symbols": Currency.allCases.map({
                $0.rawValue
            }).joined(separator: ",")
        ]
        let url: String = "https://api.apilayer.com/fixer/latest"

        executeService(url: url, httpMethod: .get, parameters: parameters, onResponse: onResponse)
    }
}
