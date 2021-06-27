//
//  DetailViewController1.swift
//  final_proj
//
//  Created by pruthvi raj dudam on 3/20/21.
//

import UIKit

class DetailViewController1: UIViewController {
    
    var selectedCar:String?
    var items:Int?
    var car_arr:[String] = []
    
    @IBOutlet weak var car_label: UILabel!
    @IBOutlet weak var item_num: UILabel!
    @IBOutlet weak var model: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.car_label.text = "Do you Want to travel to \(selectedCar!) Rental?"
        get_data(str: selectedCar!)
//        self.item_num.text = "\(items) Cars Available [Model, ID, type] in \(selectedCar!) rental store:"
        
            }
    
    func carLabel(str:String){
        self.car_label.text = "get directions to \(selectedCar!)"
    }
    func get_data(str:String){
       // print(selectedCar)
        let key_str = str
        let urlAsString = "https://vpic.nhtsa.dot.gov/api/vehicles/GetVehicleTypesForMake/\(key_str)?format=json"
                let url = URL(string: urlAsString)!
                let urlSession = URLSession.shared
                let jsonQuery = urlSession.dataTask(with: url as URL, completionHandler: { [self] data, response, error -> Void in
                                if (error != nil) {
                                    print(error!.localizedDescription)
        
                                }
                                var err: NSError?
                                var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                                if (err != nil) {
                                    print("JSON Error \(err!.localizedDescription)")
                                }
                    
                   print(jsonResult)
                   if let dictionary = jsonResult as? [String: Any]{
                              //  self.jsonView.text = String(decoding: jsonResult!, as: UTF8.self)
                    
                            let resultObjects = dictionary["Results"] as! NSArray
                               // print(earthquakeObjects)
                        //self.car_arr.append("Model, type, ID ")
                    
                                let p = (resultObjects.count) as Int
                    items = p
                    self.item_num.text = "\(items!) Cars Available [Model,type] in \(selectedCar!) rental store:"
                    
                                for i in 0..<p{
                                    self.car_arr.append(" ")
                                    //self.car_arr.append("\(i+1)"+"->")
                                    if let object = resultObjects[i] as? [String:Any] {
                                        
                                        
                                        for (key,value) in object{
                                            
                                            if key == "MakeName"{
                                                self.car_arr.append(String(describing:value))
                                            }
//                                            if key == "VehicleTypeId"{
//                                                self.car_arr.append(String(describing:value))
//                                            }
                                            if key == "VehicleTypeName"{
                                                self.car_arr.append(String(describing:value))
                                            }
                                        }
                                    }
                                }
                    }

                        DispatchQueue.main.async {
                            model.numberOfLines = 30

                            // Join strings with new line characters so each string is a separate line
                            model.text = car_arr.joined(separator: "\n")
                        }
            })
                jsonQuery.resume()
    }
    
    
    @IBAction func to_map(_ sender: Any) {
        performSegue(withIdentifier: "toMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc1 = segue.destination as? DetailViewController2
        if(segue.identifier == "toMap")
        {
            
            vc1!.selected_car3 = selectedCar!
        }
        
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()}

}
