//
//  MapView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/5/23.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var MapModel = MapViewModel()
    
    var model = MapKitModel()
    
    var body: some View {
        
        Map(coordinateRegion: $MapModel.region, showsUserLocation: true)
            .onAppear {
                MapModel.checkIfLocationServiceIsEnabled()
            }
    }
    
}

    

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center:  CLLocationCoordinate2D(latitude: 24, longitude: 121), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
        }
        
        else {
            
        }
    }
    
    private func checkLocationAuthorization() {
        
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("若要使用牙醫地圖，請到App設定開啟定位服務")
        case .denied:
            print("若要使用牙醫地圖，請到App設定開啟定位服務")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 25.025451, longitude: 121.561076), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        checkLocationAuthorization()
    }
}
