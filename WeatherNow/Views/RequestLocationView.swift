//
//  RequestLocationView.swift
//  WeatherNow
//
//  Created by Xanthi Panagiotopoulou on 7/5/24.
//

import SwiftUI

struct RequestLocationView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 150)
            
            Image(systemName: "location.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
            
            Text("Your location is needed")
                .font(.title)
                .padding(.bottom)
            
            Text("Please allow WeatherNow access to this device's location")
                .font(.title3)
                .multilineTextAlignment(.center)
            
            Button {
                goToSettings()
            } label: {
                Text("Go to Settings")
                    .font(.title3.bold())
                    .foregroundStyle(.blue)
                    .frame(width: 180, height: 60)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
            .padding(100)
        }
        .background(Image(.sunny))
        .preferredColorScheme(.dark)
        .padding(30)
    }
}

private func goToSettings() {
    let url = URL(string:UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!){
                // can open succeeded.. opening the url
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
}

#Preview {
    RequestLocationView()
}
