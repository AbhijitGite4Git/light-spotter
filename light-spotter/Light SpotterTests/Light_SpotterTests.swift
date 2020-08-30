//
//  Light_SpotterTests.swift
//  Light SpotterTests
//
//  Created by Abhijit Gite on 30/8/20.
//  Copyright © 2020 Abhijit Gite. All rights reserved.
//

import XCTest
@testable import Light_Spotter
class Light_SpotterTests: XCTestCase {

    var sut: URLSession!

    override func setUpWithError() throws {
        sut = URLSession(configuration: .default)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCameraApi() {
            // given
            let urlString = "https://api.data.gov.sg/v1/transport/traffic-images?date_time2020-08-29T13:10:45"
            let url = URL(string: urlString)!
           
           var resultCameras = [Cameras]()
    
            //What we expect to happen
            let promise = expectation(description: "Status code: 200 or 201")

            // when
           let dataTask = sut.dataTask(with: url) { data, response, error in

                // then
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                    return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {

                    if statusCode == 200 || statusCode == 201 {
                        promise.fulfill()
                    } else {
                        XCTFail("Status code: \(statusCode)")
                    }
                }
               
                if let data = data {
                  do {
                      let userResponse = try JSONDecoder().decode(SG_Lights.self, from: data)
                      var items =  [Items]()
                      items.append(contentsOf: userResponse.items!)

                      resultCameras.append(contentsOf: items[0].cameras!)
                      
                      print(resultCameras)
                  }catch let err {
                     XCTFail(err.localizedDescription)
                  }
               }
            }
            dataTask.resume()

            //Keeps the test running until all expectations are fulfilled, or the timeout interval ends, whichever happens first
            wait(for: [promise], timeout: 5)
        }

}
