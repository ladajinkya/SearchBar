//
//  DEMOViewController.swift
//  Home Web_Weather
//
//  Created by Mac on 28/11/18.
//  Copyright © 2018 Yogss. All rights reserved.
//

import UIKit

class DEMOViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var DogObject=Dogs()
    var arrayDog=[Dogs]()
let Object=WeatherModel()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:UITableViewCell = self.table.dequeueReusableCell(withIdentifier:"cell") as UITableViewCell!
        cell.textLabel?.text=arrayDog[indexPath.row].breed
        return cell;
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrayDog.count
    }
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate=self;
        self.table.dataSource=self;
        
        
        DogData()
loadData()
        // Do any additional setup after loading the view.
    }
    func DogData()
    {
        let DogURL=URL(string:"http://bitcode.info/ws_ios_assignment/ws_dog_info.php")
        var request=URLRequest(url: DogURL!)
        request.httpMethod = "GET"
        let session=URLSession.shared
        let data=session.dataTask(with: request, completionHandler:{(data:Data?,response:URLResponse?,error:Error?) -> Void in
            if(error != nil)
                {
                    print("Unable to fetch data")
                    
            }
            do
                {
                let rootArray = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                    print("ROOTDICTIONARY=\(rootArray)")
                    for elements in rootArray
                    {
                        let tempelements=elements as! NSDictionary
                        let breeed = tempelements.object(forKey:"breed")as! String
                        self.DogObject.breed=breeed;
                    }
                    self.arrayDog.append(self.DogObject)
                    self.table.reloadData()
                    
                }
            
        })
        data.resume()
    }
    func loadData()
    {
        let urlstr = URL(string:"http://api.openweathermap.org/data/2.5/weather?q=pune&APPID=5282e570f40beded06a7e2ab9ca99f20");
        var Request = URLRequest(url: urlstr!)
        Request.httpMethod="GET";
        let session=URLSession.shared
        let data=session.dataTask(with: Request, completionHandler: {(data:Data?,response:URLResponse?,error:Error?) -> Void in
            if(error != nil)
            {
                print("Unable to fetch Data");
                
            }
            do
            {
                let rootdict=try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                var name =  rootdict.object(forKey:"name")as! String
                self.Object.NameStr = name
                print("Name =\(name)")
                var id = rootdict.object(forKey:"id")as! Int
                self.Object.idstr=id;
                print("id=\(id)")
                let cod=rootdict.object(forKey:"cod")as! Int
                self.Object.codStr=cod;
                print("COD=\(cod)");
               let dt=rootdict.object(forKey:"dt")as! Int
                self.Object.dtStr=dt
                print("dt=\(dt)")
                let base = rootdict.object(forKey:"base")as! String
                self.Object.BaseStr=base;
                print("base =\(base)")
                
                let Weather=rootdict.object(forKey:"weather")as! NSArray
                for elements in Weather
                {
                    var tempelements = elements as! NSDictionary
                    let ID=tempelements.object(forKey:"id")as! Int
                    let main=tempelements.object(forKey:"main")as! String
                    let descripttion=tempelements.object(forKey:"description")as! String
                    print("ID=\(ID)")
                    print("main=\(main)")
                    print("descripttion=\(descripttion)")
                    print("tempelements=\(tempelements)")
                    
                }
                let main=rootdict.object(forKey:"main")as! NSDictionary
                let humidity=main.object(forKey:"humidity")as! Int
                print("Humidity=\(humidity)")
                
                let clouds=rootdict.object(forKey: "clouds")as! NSDictionary
                let all=clouds.object(forKey:"all")as! Int
                print("ALL=\(all)")
                
                let sys=rootdict.object(forKey:"sys")as! NSDictionary
                let Cuntry=sys.object(forKey:"country")as! String
                print("Country =\(Cuntry)")
            }
            
        })
        data.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
