//
//  DogDetailController.swift
//  Dog Breed
//
//  Created by Bipin Msb on 2022-07-13.
//

import UIKit

class DogDetailController: UIViewController {
    var getBreed : String = ""
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var newImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getBreed)
        getImage()

        // Do any additional setup after loading the view.
    }
    
    func getImage() {
        let getApiHelper = Get_Breeds()
        
        getApiHelper.fetchImage(breed: getBreed) { getImage in
            DispatchQueue.main.async {
                let url = URL(string: getImage)
                
                if let imageData = try? Data(contentsOf: (url ?? URL(string: "https://images.dog.ceo/breeds/affenpinscher/n02110627_7694.jpg"))!) {
                    if let loadedImage = UIImage(data: imageData) {
                        self.dogImage.image = loadedImage
                    }
                }
            }
        }
    }
    
    @IBAction func changeImage(_ sender: Any) {
        getImage()
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
