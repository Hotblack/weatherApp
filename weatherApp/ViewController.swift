//
//  ViewController.swift
//  weatherApp
//
//  Created by Adam Jackrel on 5/7/20.
//  Copyright © 2020 Adam Jackrel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLabel: UILabel!
    @IBOutlet weak var cityNameText: UITextField!
    
    
    //create the strings that will hold all of the parts of the URL
    //string1 is the first part
    var string1 : String = "https://api.openweathermap.org/data/2.5/weather?q="
    //string2 is the second part
    var string2 : String = ""
    //string3 is the third part
    var string3 : String = "&units=imperial&appid=1b994f626e0c3ad62d62ee49078361b7"
    var totalString : String = ""
    
    @IBAction func cityName(_ sender: UITextField) {
//
//        if (textFieldDidEndEditing){
//        print(sender.text)
//        }
        
    }
    
    //we need a button here to grab the user input and
    //to call the getWeather() function
    //VERY IMPORTANT:
    @IBAction func searchButton(_ sender: UIButton) {
        
        string2 = (cityNameText.text)!
        print("user input is: \(string2)")
        
        //String Concatenation - linking strings together to make a new one
        totalString = string1 + string2 + string3
        
        print(totalString)

        getWeather()
        
        
    }
    
    let API_KEY = "API KEY GOES HERE"
        
    func getWeather(){
               
        //IGNORE ME!
        let session = URLSession.shared
        
        let weatherURL = URL(string: totalString)!
        
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
                        
                        if let cityName = jsonObj.value(forKey: "name") {
                        print("The city name is: \(cityName)")
                            
                            DispatchQueue.main.async {
                                self.cityLabel.text = (cityName as! String)
                            }
                            
                        }
                        else{
                            print("no city name found")
                        }
                        
                        //START WEATHER DESCRIPTION
                        let weather = jsonObj.value(forKey: "weather") as! NSArray
                        let description = weather.value(forKey: "description")
                        //print(weather.value(forKey: "description"))
                        print("weather is: \(weather)")
                        print("description is: \(description)")
                        
                        //START TEMP AND FEELS LIKE
                        let main = jsonObj.value(forKey: "main") as? NSDictionary
                        
                        //we have to use the FORCE UNWRAPPING because it's a number and we want to get rid of
                        //the annoying OPTIONAL messages
                        //also we can use it as a number now
                        let temp = main?.value(forKey: "temp") as! NSNumber
                        print(temp)
                        let feelsLike = main?.value(forKey: "feels_like") as! NSNumber
                      
            
                        //EXAMPLE OF HOW TO ACCESS A VALUE INSIDE THE JSON
                        
                        //Note the key we used, "coord", is the same as the dictionary item in the converted JSON data
                        //thus we store the dictionary in a variable called mainDictionary
                        if let mainDictionary = jsonObj.value(forKey: "coord") as? NSDictionary {
                            print("This is the dictionary: \(mainDictionary)")
                            
                            //Now that we have the dictionary stored in a variable we can use the appropriate key
                            //again, we must use the converted JSON data to know what we are looking for
                            let lat = mainDictionary.value(forKey: "lat")!
                            let lon = mainDictionary.value(forKey: "lon")!
                            
                            
                            
                                DispatchQueue.main.async {
                                    print("the latitude is:  \(lat)")
                                    self.latLabel.text = "\(lat)"
                                    print("the longitude is:  \(lon)")
                                    self.lonLabel.text = "\(lon)"
                                    self.conditionsLabel.text = "\(description)"
                                    self.tempLabel.text = "\(temp)"
                                    self.feelsLabel.text = "\(feelsLike)"
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
            
           // getWeather()
        }


    }


