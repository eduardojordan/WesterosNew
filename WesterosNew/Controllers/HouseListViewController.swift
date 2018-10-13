//
//  HouseListViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate: class {
    // Should
    // Will
    // Did
    // Convencion: El primer parametro de las funciones del delegate es SIEMPRE el objeto
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse : House)
}

class HouseListViewController: UITableViewController {
    
    // Mark: - Properties
    let model: [House]
    var delegate: HouseListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros Houses"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return model.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        // Descubir el item (casa) que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda (o que nos la den del caché)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda (view) y casa (model)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        // Devolver la celda
        return cell!
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la casa en cuestion
        let house = model[indexPath.row]
        
        
        // SIEMPRE emitir la informacion a traves de los dos metodos: delegates y notifications
        // Avisar/Informar al delegado
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Enviar una notificacion
        let nc = NotificationCenter.default
        let notification = Notification(name: Notification.Name(HouseDidChangeNotificationName), object: self, userInfo: [HouseKey : house])
        nc.post(notification)
        
        //Guardamos la ultima casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
}

extension HouseListViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        let houseDetailViewController = HouseDetailViewController(model: house)
        navigationController?.pushViewController(houseDetailViewController, animated: true)
        
    }
}
//MARK . - Persistence (UserDeafaluls) // Solo sirve para persistir pequeñas cantidades e objetos
//Los objetos tienen que ser sencillos: String, Array, Int

extension HouseListViewController{
    
    func saveLastSelectedHouse(at row: Int){
        // Aqui vamos a guardar la ultima casa seleccionada por el usuario
        let userDefaults = UserDefaults.standard
        //Lo insertamos en un diccionario
        userDefaults.set(row, forKey: lastHouseKey)
        // Giuardar
        userDefaults.synchronize() // Por si acaso
        
    }
    
    func lastSelectHouse() -> House{
        //Averiguar cual es la ultima row seleccionada(si la hay)
        let row = UserDefaults.standard.integer(forKey: lastHouseKey) // Value 0 es el default
        return house(at: row)
    }
    func house(at index: Int)-> House{
        return model[index]
    }
}


