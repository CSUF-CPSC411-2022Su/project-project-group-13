//
//  MapApiView.swift
//  FullertonEats
//
//  Created by csuftitan on 6/26/22.
//

import Foundation
import SwiftUI

struct MapsAPIData: Codable {
    var features: [FoodLocactionInfo]
}

struct FoodLocactionInfo: Codable, Hashable { // Parts of the JSON decode feature's varibles
    var place_name: String
    var center: [Double] // long and lat
}

// TODO: Provide property to store the JSON's center key/value pair *

class FoodFinder: ObservableObject {
    @Published var firstFoundName = ""
    @Published var image = UIImage()
    @Published var arr: [FoodLocactionInfo] = []

    private var accessToken = "pk.eyJ1IjoicGludmVudGFkbyIsImEiOiJjbDFreTYwZWwwNWY3M2JvZm1ieDNpOGVsIn0._iXvNRhRLnJEYoLGzzY5IQ"

    func find(_ searchString: String) {
        guard searchString != "" else {
            return
        }

        let mapboxSearchURL = "https://api.mapbox.com/geocoding/v5/mapbox.places/\(searchString).json?access_token=\(accessToken)"

        /* addingPercentEncoding is a String method that returns a new string created by replacing all characters in the string not in the specified set (CharacterSet.urlQueryAllowed) with percent encoded characters. URLs cannot contain spaces and other special characters so they are replaced with percent encoded characters such as %20 indicating a space.

            URL is a structure that tries to convert a String into a URL object.
         */
        if let urlString = mapboxSearchURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
           let url = URL(string: urlString)
        {
            // Creates a task that retrieves the contents of the specified URL, then calls a handler upon completion.
            let task = URLSession.shared.dataTask(with: url) {
                data, _, _ in

                // Run the code asynchronously so the UI can be updated while we wait for a reply from the server and decode the JSON.
                DispatchQueue.main.async {
                    let jsonDecoder = JSONDecoder()
                    // Decode the JSON and store in result
                    if let validData = data, let result = try? jsonDecoder.decode(MapsAPIData.self, from: validData) {
                        if result.features.count > 0 {
                            self.arr = result.features
                            // assign FoodLocactionInfo array, features is the object of FoodLocactionInfo

                            // TODO: Retrieve the first value in the center property and store in long
                            // let long = 0.0 // Replace 0.0 with code
                            let long = result.features[1].center[0]

                            // TODO: Retrieve the second value in the center property and store in lat *
                            // let lat = 0.0 // Replace 0.0 with code
                            let lat = result.features[1].center[1]

                            // self.loadMapImage(long: long, lat: lat)
                        } else {
                            self.firstFoundName = "Inner no results found"
                        }
                    } else {
                        self.firstFoundName = "No results found"
                    }
                }
            }
            task.resume() // Runs the task (open the URL)
        }
    }
}
