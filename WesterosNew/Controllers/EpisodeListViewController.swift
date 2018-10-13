//
//  EpisodeListViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit



class EpisodeListViewController: UITableViewController {
    
    
    // Mark: Properties
    private var model: [Episode]
    //   var delegate: EpisodeListViewControllerDelegate?
    
    // Mark: Initialization
    init(model:[Episode]){
        self.model = model
        super.init(style: .plain)
    //    super.init(nibName: nil, bundle:nil)
        // title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // Baja en la notificación
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }

        // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SeasonDidChangeNotificationName), object: nil)
        
    }
    
    // Mark: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Sacar el userInfo
        let info = notification.userInfo!
        
        // Sacar la season
        guard let season = info[SeasonKey] as? Season else { return }
        
        // Actualizar el modelo
        model = season.sortedEpisodes
        
        // Sincronizar las vistas
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        //descubrir el item
        let episode = model[indexPath.row]
        //crear celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle,reuseIdentifier: cellId)
        }
        //Sincronizar view & model
        cell?.textLabel?.text = episode.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let date = dateFormatter.string(from: episode.dateRelease)
        cell?.detailTextLabel?.text = "Release: \(date)"
        
        
        
        //Devolver celda
        return cell!
    }
    
    // MARK: - Table View Controller
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        // Se averigua la celda
        let episode = model[indexPath.row]
        
        // Se crea el controlador
        let viewController = EpisodeDetailViewController(model: episode)
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

