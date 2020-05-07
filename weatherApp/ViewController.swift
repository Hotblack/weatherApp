//
//  ViewController.swift
//  weatherApp
//
//  Created by Adam Jackrel on 5/7/20.
//  Copyright © 2020 Adam Jackrel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
        let API_KEY = "API KEY GOES HERE"
       
        
    func getWeather(){
            
        //IGNORE ME!
        let session = URLSession.shared
        
        let weatherURL = URL(string: "API URL CALL GOES HERE")!
        
        //CONNECT TO SERVER AND ESTABLISH CONNECTION
        let dataTask = session.dataTask(with: weatherURL) {
        (data: Data?, response: URLResponse?, error: Error?) in
        
            //IF WE CANNOT CONNECT TO INTERNET
            if let error = error {
        print("Error:\n\(error)")
        }
               //STARTING THE API CALL
            else {
                
                print("START API CALL")
                
                if let data = data {
                    
                    //IGNORE ME!
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
            
                    //THIS STARTS THE JSON SERIALIZATON
                    //IT WILL CONVERT JSON TO SWIFT
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
        
            
                        //EXAMPLE OF HOW TO ACCESS A VALUE INSIDE THE JSON
                        
                        //Note the key we used, "coord", is the same as the dictionary item in the converted JSON data
                        //thus we store the dictionary in a variable called mainDictionary
                        if let mainDictionary = jsonObj.value(forKey: "coord") as? NSDictionary {
                            print("This is the dictionary: \(mainDictionary)")
                            
                            //Now that we have the dictionary stored in a variable we can use the appropriate key
                            //again, we must use the converted JSON data to know what we are looking for
                            let mainish = mainDictionary.value(forKey: "lat")!
                
                                DispatchQueue.main.async {
                                    print("the latitude is:  \(mainish)")
                                }
                
              
                            }
        
                    else {
                    print("Could not find dictionary")
                    }
            
                }
                
            else {
            print("Error: unable to convert json data")
            }
                    
                }

                
    else {
    print("Error: did not receive data")
    }
                
        }
            
        }
        
        dataTask.resume()
        
        
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            getWeather()
        }


    }


