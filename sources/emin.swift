// WebService.swift
import Foundation

class WebServices {
 
     func fetchData() -> DataModel {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=464f8a5567ef6de84d256d195532ca13")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            guard let safeData = data else { return}
            do {
                if error == nil {
                    let jsonData =
                    try JSONDecoder().decode(DataModel.self, from: safeData)
                    return jsonData.results
                 
                }
            } catch {
                print("Error")
                return nil
            }
        }.resume()
    }
}


// ViewController.swift
//
//  ViewController.swift
//  TestMovie
//
//  Created by Emin Saygı on 13.09.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   // bu optional oldu
    var dataModel = [Movie]?
    // burası eklendi
    var webService = WebService()

    @IBOutlet weak var myTable: UITableView!
    
    
    private var movieTableViewModel : TableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTable.delegate = self
        myTable.dataSource = self
        
        dataModel = webService.fetchData()
     
    }
 // ....
        
