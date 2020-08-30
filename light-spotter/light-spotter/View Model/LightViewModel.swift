//
//  LightViewModel.swift
//  light-spotter
//
//  Created by Abhijit Gite on 29/8/20.
//  Copyright © 2020 Abhijit Gite. All rights reserved.
//

import Foundation
import UIKit

class LightsViewModel {
    
    weak var vc : MapController?
    var resultCameras = [Cameras]()
    
    //Get Data from Rest API with Data task
    func getAllCameras(){
        
        let nowTimeStamp = self.getCurrentTimeStamp()

        let urlString = "\(String(describing: String.traffic!))?date_time\(nowTimeStamp)"
        URLSession.shared.dataTask(with: URL(string:urlString )!) { (data, response, error) in
            if( error == nil ){
                if let data = data {
                    do {
                        let userResponse = try JSONDecoder().decode(SG_Lights.self, from: data)
                        var items =  [Items]()
                        items.append(contentsOf: userResponse.items!)

                        self.resultCameras.append(contentsOf: items[0].cameras!)
                        DispatchQueue.main.async {
                            self.vc?.loadMarkers()
                            
                        }
                        print(self.resultCameras)
                    }catch let err {
                        print(err.localizedDescription)
                    }
                }
                
            }else{
                print(error?.localizedDescription ?? "Error")
            }
        }.resume()
    }
    
    //Get current time stamp from phone
    func getCurrentTimeStamp() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    //Auto Refresh data
    func autorefresh(){
        DispatchQueue.global(qos: .background).async {
            self.getAllCameras()
        }
        
    }
}
