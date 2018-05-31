//
//  PrPsUITests.swift
//  PrPsUITests
//
//  Created by fpmi on 31.05.2018.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import XCTest

class PrPsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testNotUser(){
        let app=XCUIApplication()
        
        let loginTextField=app.textFields["LoginTF"]
        loginTextField.tap()
        loginTextField.typeText("Ekaterina")
        
        let passwordTextField=app.secureTextFields["PasswordTF"]
        passwordTextField.tap()
        passwordTextField.typeText("0811998")
        app.buttons["EnterBT"].tap()
        
        let updateBT = app.buttons["updateDBBT"]
        let ifExistButtonUpdateDB = updateBT.exists
        
        XCTAssertEqual(ifExistButtonUpdateDB, false)
    }
    
    func testAdmin() {
        let app=XCUIApplication()
        
        let loginTextField=app.textFields["LoginTF"]
        loginTextField.tap()
        loginTextField.typeText("admin")
        
        let passwordTextField=app.secureTextFields["PasswordTF"]
        passwordTextField.tap()
        passwordTextField.typeText("admin")
        app.buttons["EnterBT"].tap()
        
        let updateBT = app.buttons["updateDBBT"]
        let ifExistButtonUpdateDB = updateBT.exists
        
        XCTAssertEqual(ifExistButtonUpdateDB, true)
    }
    
    func testNotAdmin(){
        let app=XCUIApplication()
        
        let loginTextField=app.textFields["LoginTF"]
        loginTextField.tap()
        loginTextField.typeText("kat")
        
        let passwordTextField=app.secureTextFields["PasswordTF"]
        passwordTextField.tap()
        passwordTextField.typeText("123")
        app.buttons["EnterBT"].tap()
        
        let updateBT = app.buttons["updateDBBT"]
        let ifExistButtonUpdateDB = updateBT.exists
        
        XCTAssertEqual(ifExistButtonUpdateDB, false)
    }
 
    
}
