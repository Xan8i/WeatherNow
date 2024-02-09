//
//  ResponseBodyTests.swift
//  WeatherNowTests
//
//  Created by Xanthi Panagiotopoulou on 9/2/24.
//

import XCTest
@testable import WeatherNow

final class ResponseBodyTests: XCTestCase {
    
    func testResponseBody() {
        //Given
        let responseBody: ResponseBody = Decoder.load("weatherData.json")
        
        //Then
        XCTAssertEqual(responseBody.weatherImageName, "sun.max")
        
        XCTAssertFalse(responseBody.isItDayTime)
        
        XCTAssertEqual(responseBody.weatherBackround, .sunny)
    }
    

    

    
    
    
    
//    func testSuccessfullTransformingToRowData() {
//        //Given
//        
//        //When
//        
//        //Then
//    }
    

}
