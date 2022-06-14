//
//  WeatherData.swift
//  Clima
//
//  Created by user215496 on 6/14/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
//data come from API
//Decodable protocol
//Encodeable protocol :Allow swift object to be encoded to JSON format
//Codeable : Decodable and Encodable
struct WeatherData : Codable{
    let name : String
    let main :  Main
    let weather : [Weather]
    
}
struct Main : Codable {
let temp: Double
}
struct Weather:Codable{
    let description: String
    let id : Int
}
