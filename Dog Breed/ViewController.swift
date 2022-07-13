//
//  ViewController.swift
//  Dog Breed
//
//  Created by Bipin Msb on 2022-06-11.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var breeds : [[String: String]] = [[:]]
    var getImageDetails = ""

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "BreedCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BreedCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // assing data from the api to the variable named breeds
        let getApiHelper = Get_Breeds()
        getApiHelper.fetchData { getData in
            DispatchQueue.main.async {
                self.breeds = getData
                self.tableView.reloadData()
            }
        }
    }
    
    func getDogImage(breed: String) -> String {
        let getApiHelper = Get_Breeds()
        getApiHelper.fetchImage(breed: breed) { getImage in
            DispatchQueue.main.async {
//                print(getImage)
//                print("getImage")
                self.getImageDetails =  getImage
            }
        }
        print(getImageDetails)
        return getImageDetails
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell", for: indexPath) as! BreedCell
        cell.breed?.text = breeds[indexPath.row]["breed"]
        let url = URL(string: getDogImage(breed: breeds[indexPath.row]["breed"] ?? ""))
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: (url ?? URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_7694.jpg"))!) {
                if let loadedImage = UIImage(data: imageData) {
                    cell.BreedImage.image = loadedImage
                }
            }
            
        }
        
        let getSubBreed = breeds[indexPath.row]["name"]
        if !(getSubBreed?.isEmpty ?? false) {
            cell.subBreed?.text = "Sub Breed: \(getSubBreed ?? "")"
        } else {
            cell.subBreed?.text = ""
        }
        
        return cell
    }
    
}

