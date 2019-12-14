//
//  ViewController.swift
//  Home Web_Weather
//
//  Created by Zumbarlal Saindane on 26/09/17.
//  Copyright © 2017 Yogss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var wObj = WeatherClass()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCity_Id: UILabel!
    @IBOutlet weak var lblRiseTime: UILabel!
    @IBOutlet weak var lblSetTime: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLattitude: UILabel!
    @IBOutlet weak var lblSeaLevel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
    }

    func loadData(){
        //url
        let wwurl = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=pune&APPID=5282e570f40beded06a7e2ab9ca99f20")
        //request
        var req = URLRequest(url: wwurl!)
        
        // http method
        req.httpMethod = "GET"
        
        //sesssion
        let session = URLSession.shared
        
        //task
        
        var dataProcess = session.dataTask(with: req, completionHandler:
        {(data:Data?,response:URLResponse?,error:Error?) -> Void in
            
            if error != nil{
                    print("Unable to fetch data")
                }
        
            do{
                let rootDict = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                let name = rootDict.object(forKey: "name")as! String
                self.wObj.name = name
                self.lblName.text = self.wObj.name
                
                let id = rootDict.object(forKey: "id") as! Int
                self.wObj.ct_id = id
                self.lblCity_Id.text = String(self.wObj.ct_id)
                
                //co-ordinates
                let coord = rootDict.object(forKey: "coord")as! NSDictionary
                let lat = coord.object(forKey: "lat")as! Double
                self.wObj.Lattitude = lat
                self.lblLattitude.text = String(self.wObj.Lattitude)
                
                let lon = coord.object(forKey: "lon")as! Double
                self.wObj.longitude = lon
                self.lblLongitude.text = String(self.wObj.longitude)
                
                //weather
                let weather = rootDict.object(forKey: "weather")as! NSArray
                
                for element in weather{
                    
                    var tempElement = element as! NSDictionary
                    
                    let w_id = tempElement.object(forKey: "id")as! Int
                    self.wObj.whtr_id = w_id
                    
                    
                    let descrip = tempElement.object(forKey: "description")as! String
                    self.wObj.description = descrip
                    
                    
                    
                    // for end
                }
                //parameters
                let parameter = rootDict.object(forKey: "main")as! NSDictionary
                
                let temp = parameter.object(forKey: "temp")as! Double
                self.wObj.temp = temp
                
                let press = parameter.object(forKey: "pressure")as! Double
                self.wObj.press = press
                
                let humidity = parameter.object(forKey: "humidity")as! Double
                self.wObj.humidity = humidity
                
                let sea = parameter.object(forKey: "sea_level")as! Double
                self.wObj.sea_level = sea
                self.lblSeaLevel.text = String(self.wObj.sea_level)
                
                
                //wind 
                let wind = rootDict.object(forKey: "wind")as! NSDictionary
                
                let speed = wind.object(forKey: "speed")as! Double
                self.wObj.wind_Speed = speed
                
                let system = rootDict.object(forKey: "sys")as! NSDictionary
                let country = system.object(forKey: "country")as! String
                self.wObj.country = country
                
                let settime = system.object(forKey: "sunset")as! CLong
                self.wObj.setTime = settime
                self.lblSetTime.text = String(self.wObj.setTime)
                
                let risetime = system.object(forKey: "sunrise")as! CLong
                self.wObj.riseTime = risetime
                self.lblRiseTime.text = String(self.wObj.riseTime)
     
                //do end
            }

                
                
                
         //closure end
        })
        
        dataProcess.resume()
        
        
        
        
        
        
        //func end
    }
    
    
    
    
    @IBAction func DetailButton(_ sender: AnyObject) {
    
    let dvc = storyboard?.instantiateViewController(withIdentifier: "ss")as! Detail_ViewController
        
        dvc.bufferObj = wObj
        
      print(dvc.bufferObj.description)
    navigationController?.pushViewController(dvc, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        var svc = segue.destination as! Detail_ViewController
//        svc.bufferObj = wObj
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

