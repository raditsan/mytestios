//
//  ViewController.swift
//  MyTest
//
//  Created by Mac on 05/08/22.
//

import UIKit

class ViewController: UIViewController {
    var users: UserModel = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let vc = segue.destination as? DetailViewController {
                let indexPath = tableView.indexPathForSelectedRow
                vc.user = users[indexPath!.row]
            }
        }
    }
    
    
    func setupUi() {
        let nib = UINib.init(nibName: String(describing: UserTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.sizeToFit()
        tableView.dataSource = self
        tableView.delegate = self
        
        getPost { users in
            DispatchQueue.main.async {
                self.users = users
                self.tableView.reloadData()
            }
        }
    }
    

    
    func getPost(completion: @escaping ((UserModel) -> Void)){
        let jsonUrlString = "https://jsonplaceholder.typicode.com/posts"

        guard let url = URL(string: jsonUrlString) else{
            return
        }

        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {
                  return
            }
            do {
                let user = try JSONDecoder().decode(UserModel.self, from: data)
                completion(user)
            } catch {
                completion([])
                print("didnt work \(error)")
            }
        }.resume()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.title.text = users[indexPath.row].title
        cell.subtitle.text = users[indexPath.row].body
        
        return cell
    }
}

