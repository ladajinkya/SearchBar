//
//  Detail_ViewController.swift
//  Home Web_Weather
//
//  Created by Zumbarlal Saindane on 26/09/17.
//  Copyright © 2017 Yogss. All rights reserved.
//

import UIKit

class Detail_ViewController: UIViewController {

    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblW_ID: UILabel!
    @IBOutlet weak var lblWind_Speed: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
  
    
    var bufferObj = WeatherClass()
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTemp.text = String(bufferObj.temp)
        lblPressure.text = String(bufferObj.press)
        lblHumidity.text = String(bufferObj.humidity)
        lblW_ID.text = String(bufferObj.whtr_id)
        lblWind_Speed.text = String(bufferObj.wind_Speed)
        lblCountry.text = bufferObj.country
        lblDescription.text = bufferObj.description
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
