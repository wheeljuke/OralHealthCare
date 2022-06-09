//
//  MapModel.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/6/8.
//

import Foundation
import CoreLocation

class MapKitModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        super.init()
        
        // Set ContentModel as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
        // TODO: Start geolocating the user, after the user has granted permission
        //locationManager.startUpdatingLocation()
    }
    
    // MARK: - locationManager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating the user after we have permission
            locationManager.startUpdatingLocation()
            
        }
        
        else if locationManager.authorizationStatus == .denied {
            
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Give us the location of the use
        // print (locations.first ?? "no location")
        let userLocation = locations.first
        
        if userLocation != nil {
            // Stop getting the location after we got it once
            locationManager.stopUpdatingLocation()
            
            // If we have the coordinates of the user send it into Yelp API and get the near by restaurants
            getBusinesses(category: "Destist", location: userLocation!)
        }
    }
    
    // MARK: - Yelp API Methods
    
    func getBusinesses(category: String, location: CLLocation) {
        
        // Create URL
        /*
         let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=10"
         let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "10")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer Ct24Ujlw-uvlS6MssF3158dKa1DDKsNXqihDB4BP-TbbHbXWqVZr0G6WXSEpmcD6xqT2gqPSz9Tohps6f_N61Bqp5GT8zDodahjZ-6bAsToTSG33ZnKiMQixT0agYnYx", forHTTPHeaderField: "Authorization")
            
            // Create URL Session
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                // Check if there's any errors
            }
            
            // Start the Data Task
            
            dataTask.resume()

        }
    }
}

