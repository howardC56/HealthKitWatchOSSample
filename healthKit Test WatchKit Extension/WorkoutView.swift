//
//  WorkoutView.swift
//  healthKit Test WatchKit Extension
//
//  Created by Howard Chang on 11/23/20.
//

import SwiftUI


struct WorkoutView: View {
    
    enum WorkoutState {
        case active, paused
    }
    
    @State private var workoutState:
        WorkoutState = .active
    @ObservedObject var healthManager: HealthManager
    var distanceQuantity: String {
        let miles = healthManager.totalDistance
        var distanceString = String(format: "%.2f", miles)
        if miles >= 10 {
            distanceString = String(format: "%.1f", miles)
        }
        return distanceString
    }
    var calorieQuantity: String {
        return String(format: "%.0f", healthManager.totalEnergyBurned)
    }
    var heartRateQuantity: String {
        return String(Int(healthManager.lastHeartRate))
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                StatisticView(quantity: heartRateQuantity, unit: "BPM")
                    .foregroundColor(.red)
                Spacer()
                StatisticView(quantity: calorieQuantity, unit: "cal")
                    .foregroundColor(.yellow)
                Spacer()
                StatisticView(quantity: distanceQuantity, unit: "mi")
                    .foregroundColor(.blue)
            }
            Spacer()
            
            if workoutState == .active {
                Button("Pause") {
                    healthManager.pause()
                    workoutState = .paused
                }
                .background(Color.green)
                .foregroundColor(.black)
                .cornerRadius(10)
            } else {
                Button("Resume") {
                    healthManager.resume()
                    workoutState = .active
                }
                
                Button("End") {
                    healthManager.end()
                }
                .background(Color.red)
                .foregroundColor(.black)
                .cornerRadius(10)
            }
        }
    }
}

struct StatisticView: View {
    var quantity: String
    var unit: String
    var body: some View {
        VStack {
            Text("\(quantity)")
                .font(.title2)
                .fontWeight(.bold)
            Text("\(unit)".uppercased())
                .font(.caption)
                .fontWeight(.light)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(healthManager: HealthManager())
    }
}
