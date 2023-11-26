//
//  ContentView.swift
//  SwiftUI-WeatherForecastApp
//
//  Created by Memory Mhou on 26/11/2023.
//

import SwiftUI
import CoreLocation



struct ContentView: View {
    @ObservedObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let weather = locationManager.weather {
                TopHalfView(weather: weather, cityName: locationManager.cityName)
                BottomHalfView(weather: weather, weeklyForecast: locationManager.filteredWeeklyForecast)
            } else {
                Text("Loading...")
            }
        }
        .background(locationManager.weather?.conditionBackground)
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


