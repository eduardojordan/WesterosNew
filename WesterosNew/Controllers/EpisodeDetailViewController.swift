//
//  EpisodeDetailViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var xlabel: UILabel!
    
    //Mark: Properties
    private var model: Episode
    
    //Mark: Initialization
    init(model: Episode){
        self.model = model
        super.init(nibName: nil, bundle:nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Mark: Cycle-life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Nos damos de alta en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SeasonDidChangeNotificationName), object: nil)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Baja en la notificación
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    // Mark: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        navigationController?.popViewController(animated: true)
    }
    
    // Sincronizar Modelo & Vista
    
    func syncModel(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let date = dateFormatter.string(from: model.dateRelease)
        
        
        
        titleLabel.text = model.title
        dateLabel.text = " Release:\(date)"
        xlabel.text? = "\(model.season?.name ?? "") Episode \(model.dateRelease)"
        
        //  title = model.title
    }
    
}

