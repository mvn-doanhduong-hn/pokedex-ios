//
//  AppDelegate.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa
import XCGLogger

let log: XCGLogger = {
    #if DEBUG
    let xcLog = XCGLogger(identifier: "advancedLoggerDebug", includeDefaultDestinations: false)
    let systemDestination = AppleSystemLogDestination(identifier: XCGLogger.Constants.systemLogDestinationIdentifier)
    
    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    
    xcLog.add(destination: systemDestination)
    xcLog.logAppDetails()
    #else
    let xcLog = XCGLogger(identifier: "advancedLoggerRelease", includeDefaultDestinations: false)
    let systemDestination = AppleSystemLogDestination(identifier: XCGLogger.Constants.systemLogDestinationIdentifier)
    
    systemDestination.outputLevel = .severe
    systemDestination.showLogIdentifier = true
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    
    xcLog.add(destination: systemDestination)
    xcLog.logAppDetails()
    #endif
    
    return xcLog
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let disposeBag = DisposeBag()
    var coordinator = FlowCoordinator()
    var appFlow: AppFlow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        guard let window = window else { return false }
        
        window.backgroundColor = .blue
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            log.debug("did navigate to flow = \(flow) and step = \(step)")
        }).disposed(by: disposeBag)
        
        self.appFlow = AppFlow(with: window)
        
        coordinator.coordinate(flow: self.appFlow, with: OneStepper(withSingleStep: AppStep.splash))

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

