//
//  LocationManager.swift
//  SwiftUI-WeatherForecastApp
//
//  Created by Memory Mhou on 26/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var weather: Weather?
    @Published var cityName: String = ""
    @Published var weeklyForecast: [Weather] = []
    @Published var filteredWeeklyForecast: [Weather] = [] {
        didSet {
            objectWillChange.send()
        }
    }

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        // Use reverse geocoding to get the city name
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else { return }
            self.cityName = placemark.locality ?? ""

            // Get weather data for the city
            WeatherAPI().getWeatherData(city: self.cityName) { weather in
                DispatchQueue.main.async {
                    self.weather = weather
                }
            }

            // Get the weekly forecast data
            WeatherAPI().getWeeklyForecast(city: self.cityName) { weeklyForecast in
                DispatchQueue.main.async {
                    self.weeklyForecast = weeklyForecast

                    // Filter the forecast to show only unique days
                    self.filteredWeeklyForecast = weeklyForecast
                }
            }
        }

        self.locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
}
