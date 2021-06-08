//
//  UITestBase.swift
//  uitestsUITests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation
import XCTest

import Embassy
import EnvoyAmbassador

class UITestBase: XCTestCase {
    let port = 8080
    var router: Router!
    var eventLoop: EventLoop!
    var server: HTTPServer!
    var app: XCUIApplication!
    
    var eventLoopThreadCondition: NSCondition!
    var eventLoopThread: Thread!
    
    override func setUp() {
        super.setUp()
        setupWebApp()
        setupApp()
    }
    
    private func setupWebApp() {
        eventLoop = try! SelectorEventLoop(selector: try! KqueueSelector())
        router = DefaultRouter()
        server = DefaultHTTPServer(eventLoop: eventLoop, port: port, app: router.app)
        
        // Start HTTP server to listen on the port
        try! server.start()
        
        eventLoopThreadCondition = NSCondition()
        eventLoopThread = Thread(target: self, selector: #selector(runEventLoop), object: nil)
        eventLoopThread.start()
    }
    
    // set up XCUIApplication
    private func setupApp() {
        app = XCUIApplication()
        app.launchEnvironment["RESET_LOGIN"] = "1"
        app.launchEnvironment["ENVOY_BASEURL"] = "http://localhost:\(port)"
        app.launchEnvironment["IS_UI_TEST_MODE"] = "1"
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
        server.stopAndWait()
        eventLoopThreadCondition.lock()
        eventLoop.stop()
        while eventLoop.running {
            if !eventLoopThreadCondition.wait(until: NSDate().addingTimeInterval(10) as Date) {
                fatalError("Join eventLoopThread timeout")
            }
        }
    }
    
    @objc private func runEventLoop() {
        eventLoop.runForever()
        eventLoopThreadCondition.lock()
        eventLoopThreadCondition.signal()
        eventLoopThreadCondition.unlock()
    }
    
    func addUIInterruptions() {
        addUIInterruptionMonitor(withDescription: "Allow push") { (alerts) -> Bool in
            if(alerts.buttons["Allow"].exists){
                alerts.buttons["Allow"].tap();
            }
            return true;
        }
        
        addUIInterruptionMonitor(withDescription: "Location Dialog") { (alerts) -> Bool in
            if(alerts.buttons["Allow While Using App"].exists){
                alerts.buttons["Allow While Using App"].tap();
            } else if (alerts.buttons["Allow"].exists) {
                alerts.buttons["Allow"].tap();
            }
            return true;
        }
        app.activate()
    }
    
    func openSideMenu() {
        sleep(10)
        let drawerButton = app.buttons["drawerButton"]
        if !drawerButton.isHittable {
            app.otherElements["googleMapView"].tap()
            sleep(2)
        }
        drawerButton.tap()
    }

}
