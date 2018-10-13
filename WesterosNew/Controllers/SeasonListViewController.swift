//
//  SeasonListTableViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit


protocol SeasonListViewControllerDelegate{
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
    
    
    //Mark: Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
    
    
    @IBOutlet var tableViewSeason: UITableView!
    
    //Mark: Initialization
    init(model: [Season]){
        self.model = model
       super.init(nibName: nil, bundle: nil)
      //  super.init(style: .plain)
        
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Descubrimos cual es el season a mostrar
        let season = model[indexPath.row]
        
        // Creamos la celda ( o la dan de cache si existe)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        // Sicronizar modelo - Vista
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let date = dateFormatter.string(from: season.releaseDate)
        
        cell?.textLabel?.text = season.name
        cell?.detailTextLabel?.text = "Release: \(date)"
        
        return cell!
        
    }
    
    //Mark: Delegate
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Averiguar la season
        let season = model[indexPath.row]
        
        // Avisamos al delegado (SIEMPRE emotir la info a travez de DELEGATE & NOTIFICATION)
        
        delegate?.seasonListViewController(self, didSelectSeason: season)

        
        // Enviar una notificacion
        let nc = NotificationCenter.default
        let notification = Notification(name: Notification.Name(SeasonDidChangeNotificationName), object: self, userInfo: [SeasonKey : season])
        nc.post(notification)
        
        //Guardamos
        saveLastSelectedSeason(row: indexPath.row)
        
    }
}

extension SeasonListViewController: SeasonListViewControllerDelegate{
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        // Crear el controlador del detalle
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        // Push
        navigationController?.pushViewController(seasonDetailViewController, animated: true)
    }
}
extension SeasonListViewController{
    
    func saveLastSelectedSeason( row: Int){
        // Aqui vamos a guardar la ultima casa seleccionada por el usuario
        let userDefaults = UserDefaults.standard
        //Lo insertamos en un diccionario
        userDefaults.set(row, forKey: lastSeasonKey)
        // Giuardar
        userDefaults.synchronize() // Por si acaso
        
    }
    
    func lastSelectSeason() -> Season{
        //Averiguar cual es la ultima row seleccionada(si la hay)
        let row = UserDefaults.standard.integer(forKey: lastSeasonKey) // Value 0 es el default
        return season(at: row)
    }
    func season(at index: Int)-> Season{
        return model[index]
    }
}


