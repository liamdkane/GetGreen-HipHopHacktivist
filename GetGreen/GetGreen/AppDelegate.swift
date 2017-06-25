//
//  AppDelegate.swift
//  GetGreen
//
//  Created by C4Q on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//
import UIKit
import Firebase
import Alamofire

let kGardensNotificationName = Notification.Name(rawValue: "gotGardens")
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    static let url = URL(string: "https://data.cityofnewyork.us/resource/yes4-7zbb.json")!
    var communityGardens: [CommunityGardens]? {
        didSet {
            let gotGardensnotification = Notification(name: kGardensNotificationName,
                                                      object: self.communityGardens,
                                                      userInfo: nil)
            NotificationCenter.default.post(gotGardensnotification)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        
        let fetchDataOperationsQueue = OperationQueue()
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        fetchDataOperationsQueue.addOperation {
            Alamofire.request(AppDelegate.url, method: .get, headers: headers).responseJSON { (jsonResponse) in
                print(jsonResponse.result.value!)
                
                if let data = jsonResponse.data {
                    print("getting json: \(data)")
                    
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        guard let responseData = jsonData as? [[String:Any]] else {
                            print("Error parsing responseData")
                            return
                        }
                        
                        if let gardenObject = CommunityGardens.parseArray(from: responseData) {
                            self.communityGardens = gardenObject
                        }
                    } catch {
                        print("Error parsing JSON")
                    }
                }
            }
        }
        fetchDataOperationsQueue.qualityOfService = .background
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
