//
//  Get_Breeds.swift
//  Dog Breed
//
//  Created by Bipin Msb on 2022-06-11.
//

import Foundation

class Get_Breeds {
    private var endpoint = URL(string: "https://dog.ceo/api/breeds/list/all")
    
    private var session: URLSession = {
        var config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchData(callback: @escaping ([[String: String]]) -> Void) {
        let request = URLRequest(url: endpoint!)
        let task = session.dataTask(with: request) {
            data, response, error in
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    guard
                        let jsonDictionay = jsonObject as? [AnyHashable:Any],
                        let getBreeds = jsonDictionay["message"] as? [String:[String]]
                    else { return }
                    var breedList = [[String: String]]()
                    
                    for (breed, subBreed) in getBreeds {
                        
                        if subBreed.count != 0 {
                            for singleSubBreed in subBreed {
                                breedList.append([
                                    "name": singleSubBreed,
                                    "breed": breed
                                ])
                            }
                        } else {
                            breedList.append([
                                "name":"",
                                "breed": breed
                            ])
                        }
                    }
                    
                    callback(breedList)
                } catch let error {
                    print("Error \(error)")
                }
            } else if let error = error {
                print(error)
            } else {
                print("Unknown Error")
            }
        }
        task.resume()
    }
}
