//
//  ExtensionsTests.swift
//  WeatherNowTests
//
//  Created by Xanthi Panagiotopoulou on 9/2/24.
//

import XCTest
@testable import WeatherNow

final class ExtensionsTests: XCTestCase {

    func testConvertingStringToDate() {
        //Given
        let dateTypeString = "2024-02-09T14:23"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let dateResult = dateFormatter.date(from: dateTypeString)
        
        //When
        let dateTypeDate = DateFormatter.convertToDate(dateTypeString)
       
        //Then
        XCTAssertEqual(dateTypeDate, dateResult)
    }
    
    func testConvertingStringToShortDate() {
        //Given
        let dateTypeString = "2024-02-09"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateResult = dateFormatter.date(from: dateTypeString)
        
        //When
        let dateTypeDate = DateFormatter.convertToShortDate(dateTypeString)
       
        //Then
        XCTAssertEqual(dateTypeDate, dateResult)
    }
    
    func testGetWeekDayFromDate() throws {
        //Given
        let dateTypeString = "2024-02-09"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
      
        let dateTypeDate = try XCTUnwrap(dateFormatter.date(from: dateTypeString))
        
        //When
        let weekday = DateFormatter.getWeekDay(dateTypeDate)
       
        //Then
        XCTAssertEqual(weekday, "Friday")
    }
}
