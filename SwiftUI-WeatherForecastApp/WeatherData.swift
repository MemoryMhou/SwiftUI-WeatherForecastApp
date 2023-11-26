//
//  WeatherData.swift
//  SwiftUI-WeatherForecastApp
//
//  Created by Memory Mhou on 26/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation


struct Weather {
    var temperature: Double
    var minTemperature: Double
    var maxTemperature: Double
    var condition: String
    var conditionIcon: String
    var conditionBackgroundURL: URL?
    var conditionBackground: Color
    var dayOfWeek: String
}

struct WeatherData: Codable {
    let main: Main
    let weather: [WeatherCondition]
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct WeatherCondition: Codable {
    let description: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case description = "main"
        case icon
    }
}

struct WeeklyForecastData: Codable {
    let list: [ForecastItem]
}

struct ForecastItem: Codable {
    let dt_txt: String
    let main: Main
    let weather: [WeatherCondition]
}

