//
//  BaseApiManager.swift
//  TestiOS
//
//  Created by Arturo Cadena on 24/04/23.
//

import Foundation
import Alamofire
let API_KEY = "xXaMtWllrnQ8UNqSey7uFshj6ZQ1jJIW"

protocol BaseApiManager {
    static func executeService <T: Codable> (url: String, httpMethod: HTTPMethod, parameters: Parameters, onResponse: @escaping(T?, Error?)->() )
    
}

extension BaseApiManager {
    static func executeService<T: Codable>(url: String, httpMethod: HTTPMethod, parameters: Parameters, onResponse: @escaping(T?, Error?)->()) {
        var newUrl = url
        var newParameters: Parameters? = parameters
        var headers: HTTPHeaders = HTTPHeaders()
        headers.add(HTTPHeader(name: "apikey", value: API_KEY))
        if httpMethod == .get {
            newUrl += parameters.reduce("?", { (partialResult, data) in
                let (key, value) = data
                return "\(partialResult)&\(key)=\(value)"
            })
            newParameters = nil
        }
        AF.request(newUrl, method:httpMethod, parameters: newParameters, encoding: JSONEncoding.default, headers:headers).responseData { (response: AFDataResponse<Data>) in
            switch response.result {
            case .success(let data):
                do {
                    onResponse(try JSONDecoder().decode(T.self, from: data), nil)
                } catch {
                    onResponse(nil, error)
                }
            case .failure(let error):
                onResponse(nil, error)
            }
        }
    }
}

