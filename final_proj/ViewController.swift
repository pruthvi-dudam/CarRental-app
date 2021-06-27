//
//  ViewController.swift
//  final_proj
//
//  Created by pruthvi raj dudam on 3/20/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myCarList =  [CarEntity]()
    var inputImage:UIImage?
    var counter = 1

    @IBOutlet weak var car_table: UITableView!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        self.loadImage()
        super.viewDidLoad()}
    
    func fetchRecord() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CarEntity")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x = 0
        myCarList = ((try? (managedObjectContext).fetch(fetchRequest)) as? [CarEntity])!
        x = myCarList.count
        print(x)
        return x}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "car_cell", for: indexPath) as! CarTableViewCell
        cell.layer.borderWidth = 1.0
        if indexPath.row == 0 {
            cell.car_name?.text = "My Car Rental List"
        }else{
            cell.car_name?.text = myCarList[indexPath.row].name;}
        if let picture = myCarList[indexPath.row].picture {
            cell.car_image.image =  UIImage(data: picture  as Data)
        } else {
            cell.car_image.image = nil
        }
        return cell}
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true}
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle{return UITableViewCell.EditingStyle.delete}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: NSIndexPath) -> CGFloat {
            return UITableView.automaticDimension}
    //delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            if editingStyle == .delete{
                
                managedObjectContext.delete(myCarList[indexPath.row])
                myCarList.remove(at:indexPath.row)
                do {try managedObjectContext.save()}
                catch {}
                car_table.reloadData()}}
        
    @IBAction func add(_ sender: Any) {
        
        let ent = NSEntityDescription.entity(forEntityName: "CarEntity", in: self.managedObjectContext)
        let newItem = CarEntity(entity: ent!, insertInto: self.managedObjectContext)
        newItem.name = ""
        newItem.picture = nil
        updateCounter()
        let alertController = UIAlertController(title: "Add Car", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the Car here"
        })
        let searchAction = UIAlertAction(title: "Picture", style: .default) { action in
            let photoPicker = UIImagePickerController ()
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            self.present(photoPicker, animated: true, completion: nil)
            if let name = alertController.textFields?[0].text {
                newItem.name = name}
        }
        let imageAction = UIAlertAction(title: "Camera", style: .default) { action in
            let photoPicker = UIImagePickerController ()
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                photoPicker.allowsEditing = false
                photoPicker.sourceType = UIImagePickerController.SourceType.camera
                photoPicker.cameraCaptureMode = .photo
                photoPicker.modalPresentationStyle = .fullScreen
                self.present(photoPicker,animated: true,completion: nil)
                if let name = alertController.textFields?[0].text {
                    newItem.name = name}
            } else {
                print("No camera")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in}
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        alertController.addAction(imageAction)
        
        self.present(alertController, animated: true, completion: nil)
        // save the updated context
        do {try self.managedObjectContext.save()}
        catch _ {}
        print(newItem)
        car_table.reloadData()}

    func updateLastRow() {
        let indexPath = IndexPath(row: myCarList.count - 1, section: 0)
        car_table.reloadRows(at: [indexPath], with: .automatic)}
    func initCounter() {
        counter = UserDefaults.init().integer(forKey: "counter")}
    
    func updateCounter() {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()}
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker .dismiss(animated: true, completion: nil)

        if let car = myCarList.last, let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            car.picture = image.pngData()! as NSData
            updateLastRow()
            do {
                try managedObjectContext.save()
            } catch {
                print("Error while saving the new image")
            }
        }
    }
    func loadImage() {
        inputImage = UIImage(named: "honda.jpeg")
        UIImageWriteToSavedPhotosAlbum(inputImage!, nil, nil, nil)
        inputImage = UIImage(named: "fiat.jpeg")
        UIImageWriteToSavedPhotosAlbum(inputImage!, nil, nil, nil)
        inputImage = UIImage(named: "nissan.jpeg")
        UIImageWriteToSavedPhotosAlbum(inputImage!, nil, nil, nil)
        inputImage = UIImage(named: "volkswagen.jpeg")
        UIImageWriteToSavedPhotosAlbum(inputImage!, nil, nil, nil)
        inputImage = UIImage(named: "mistubushi.png")
        UIImageWriteToSavedPhotosAlbum(inputImage!, nil, nil, nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.car_table.indexPath(for: sender as! UITableViewCell)!
        if(segue.identifier == "DetailView1"){
            if let viewController: DetailViewController1 = segue.destination as? DetailViewController1{
                viewController.selectedCar = myCarList[selectedIndex.row].name}}
        }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()}
}

