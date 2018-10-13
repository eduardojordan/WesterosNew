//
//  MemberDetailViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    
    
    var model:Person
    
    init(model:Person){
    self.model = model
    super.init(nibName:nil,bundle:nil)
    title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // Mark: Cycle Life
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        syncMV()
    }

    
    func syncMV(){
        nameLabel.text = "\(model.name)"
        aliasLabel.text = model.alias
        
    }
    
    @objc func houseDidChange(notification: Notification){
        guard let info = notification.userInfo,
            let house: House = info[HouseKey] as? House else {return}
        
        let memberListViewController = MemberListViewController(model: house.sortedMembers)
        
        navigationController?.pushViewController(memberListViewController, animated: true)
        
    }

}
