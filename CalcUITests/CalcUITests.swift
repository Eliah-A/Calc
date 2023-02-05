//
//  CalcUITests.swift
//  CalcUITests
//
//  Created by Илья Сергеевич on 19.01.2023.
//

import XCTest

class CalcUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication.init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func textResultViewDefaultValues() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
    }
}
