//
//  ViewController.swift
//  GetGreen
//
//  Created by C4Q on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var communityGardens = [CommunityGardens]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let url = URL(string: "https://data.cityofnewyork.us/resource/yes4-7zbb.json")!
        Alamofire.request(url, method: .get, headers: headers).responseJSON { (jsonResponse) in
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
                        dump(self.communityGardens)
                    }
                } catch {
                    print("Error parsing JSON")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

