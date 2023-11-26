//
//  TopHalfView.swift
//  SwiftUI-WeatherForecastApp
//
//  Created by Memory Mhou on 26/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation


struct TopHalfView: View {
    var weather: Weather
    var cityName: String

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image(systemName: weather.conditionIcon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(.trailing, 16)
                    .padding(.top, 16)

                VStack {
                    Spacer()
                    Text("\(Int(weather.temperature))°C")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                    Text(weather.condition)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text(cityName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .background(
            GeometryReader { geometry in
                AsyncImage(url: weather.conditionBackgroundURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .brightness(-0.3)
                } placeholder: {
                    Color.clear
                }
                .clipped()
                .cornerRadius(10)
            }
        )
    }
}
