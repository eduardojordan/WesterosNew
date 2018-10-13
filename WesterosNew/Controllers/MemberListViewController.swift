//
//  MemberListTableViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

class MemberListViewController: UITableViewController {
    
    // Mark: - Outlets
   // @IBOutlet weak var tableView: UITableView!
    
    // Mark: - Properties
    var model: [Person]
    
    // Mark: - Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark Cycle Lyfe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        NotificationCenter.default.removeObserver(self)
    }
   
    @objc func houseDidChange(notification: Notification) {
        // sacar la info y  Extraer
        guard let info = notification.userInfo,
            let house = info[HouseKey] as? House else { return }
        //
        // Actualizar el modelo
        self.model = house.sortedMembers
        // Sincronizar modelo - vista
        syncModelWithView()
    }
   
    func syncModelWithView() {
        tableView.dataSource = self
        tableView.reloadData()
        
    }

// Mark TableView

//extension MemberListViewController: UITableViewDataSource {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "PersonCell"
        // Descubrimos cual es la Person que hay que mostrar
        let person = model[indexPath.row]
        // Creamos la celda (o nos la dan de cache)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        // Sincronizar modelo-vista (person-cell)
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.alias
        
        return cell!
    }
    
    func person(at index: Int) -> Person {
        return model[index]
    }

//extension MemberListViewController: UITableViewDelegate {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.model[indexPath.row]
        navigationController?.pushViewController(MemberDetailViewController(model: person), animated:true)
    }
}
