//
//  ViewController.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import UIKit

protocol MainViewInputDelegate: AnyObject {
    func setupData(source: [MainViewModel])
}

class ViewController: UIViewController {

    var dataSource = [MainViewModel]()
    var viewOutputDelegate: MainViewOutputDelegate?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let cellId = "photoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main"
        self.viewOutputDelegate?.getData()
        
        createTable()
        view.addSubview(tableView)
        createConstraints()
    }
    
    func createTable () {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
    }
    
    func createConstraints () {
        let safeGuide = self.view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewOutputDelegate?.didSelectCell(cellNumber: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = dataSource[indexPath.row].description
        content.textProperties.color = dataSource[indexPath.row].color
        content.textProperties.numberOfLines = 2
        
        content.secondaryText = String(dataSource[indexPath.row].likes) + " likes"
        
        content.image = dataSource[indexPath.row].image
        content.imageProperties.reservedLayoutSize = CGSize(width: 100, height: 100)
        content.imageProperties.maximumSize = CGSize(width: 90, height: 90)
        content.imageProperties.cornerRadius = 5
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}

extension ViewController: MainViewInputDelegate {
    func setupData(source: [MainViewModel]) {
        self.dataSource = source
        tableView.reloadData()
    }
    
    
}
