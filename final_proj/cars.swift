//
//  cars.swift
//  final_proj
//
//  Created by pruthvi raj dudam on 4/7/21.
//

import Foundation
import CoreData


class cars
{
    var cars:[car] = []
    //var cars = [CarEntity]()
    //let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init()
    {
        let c1 = car(cn: "honda")
        let c2 = car(cn: "bmw")
//        let c1 = city(cn: "Washington", cd: "Capital of the United States of America", cin: "washington.jpg")
//        let c2 = city(cn: "California", cd: "the most populous U.S. state and the third-largest by area", cin: "california.jpg")
//        let c3 = city(cn: "Texas", cd: "the second largest U.S. state", cin: "Texas.jpg")
//        let c4 = city(cn: "Ohio", cd: "Ohio has an area of 44,828 sq mi", cin: "ohio.jpg")
//        let c5 = city(cn: "Florida", cd: "Sun-Shine state", cin: "florida.jpg")
//
       // cars.append(c1) 
        //cars.append(c2)
//        cities.append(c1)
//        cities.append(c2)
//        cities.append(c3)
//        cities.append(c4)
//        cities.append(c5)
        
    }
//    func fetchRecord() -> Int {
//        // Create a new fetch request using the FruitEntity
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
//        let sort = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sort]
//        var x   = 0
//        // Execute the fetch request, and cast the results to an array of FruitEnity objects
//        cars = ((try? ((UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext).fetch(fetchRequest)) as? [CityEntity])!
//
//
//        x = cars.count
//
//        print(x)
//
//        // return how many entities in the coreData
//        return x
//
//
//    }
    
    func getCount() -> Int
    {
        return cars.count
    }
    
    func getCarObject(item:Int) -> car{
        
        return cars[item]
    }
    
    func removeCarObject(item:Int) {
        
         cars.remove(at: item)
    }
    
    //func addCityObject(name:String, desc: String, image: String) -> city{
    func addCarObject(name:String) -> car{
       // let c = car(cn: name, cd: "Liberty City", cin: "newyork.jpg")
        let c = car(cn: name)
        cars.append(c)
        return c
    }
    
}
class car
{
    var carName:String?
    //var cityDescription:String?
    //var cityImageName:String?
    
    //init(cn:String, cd:String, cin:String)
    init(cn:String)
    {
        carName = cn
        //cityDescription = cd
       // cityImageName = cin
        
    }
}

