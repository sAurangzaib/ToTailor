//
//  BackgroundTaskHandler.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation
import UIKit

class BackgroundTaskHandler {
    var backgroundUpdateTask = UIBackgroundTaskIdentifier.invalid
    
    @discardableResult func beginBackgroundTask() -> UIBackgroundTaskIdentifier {
        
        endBackgroundTask() // End Background task if alreayd running.
        
        backgroundUpdateTask = UIApplication.shared.beginBackgroundTask (expirationHandler: {
            self.endBackgroundTask()
        })
        
        return backgroundUpdateTask
    }
    
    func endBackgroundTask() {
        if backgroundUpdateTask != UIBackgroundTaskIdentifier.invalid {
            UIApplication.shared.endBackgroundTask(backgroundUpdateTask)
            backgroundUpdateTask = UIBackgroundTaskIdentifier.invalid
        }
    }
    
}
