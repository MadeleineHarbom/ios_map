//
//  CountryListViewController.swift
//  mapKitDemo
//
//  Created by ksd on 28/10/2019.
//  Copyright © 2019 eaaa. All rights reserved.
//

import UIKit

struct Country: Decodable {
    let name: String
    let latlng: [Double]
}

class CountryListViewController: UIViewController {

    @IBOutlet weak var countryListTableView: UITableView! {
        didSet {
            countryListTableView.dataSource = self
        }
    }
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonURL = "https://restcountries.eu/rest/v2/all"
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { [weak self](data, response, error) in
            do {
                self?.countries = try JSONDecoder().decode([Country].self, from: data!)
                DispatchQueue.main.async {
                    self?.countryListTableView.reloadData()
                }
                
            }
            catch {
                print("error: \(error)")
            }
        }.resume()
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "countryDetailSegue" {
            let destination = segue.destination as? ViewController
            let index = countryListTableView.indexPathForSelectedRow
            destination?.country = countries[index!.row]
        }
        
    }
    

}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    
}
