//
//  HouseDetailViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 8/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
//Mark: Properties
    
    var model:House

//Mark IBOUTLET
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    
    // MARK: - Initialization
    init(model: House) {
        // Primero, limpio mi propio desorden (a.k.a, le doy valor a mis propias propiedades)
        self.model = model
        // Despues, llamamos a super
        super.init(nibName: nil, bundle: nil)
        // Si quieres, utilizas alguna propiedad de tu super clase
      //  title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    // Este init es el que utilizan los Storyboards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        // Sincronizar modelo y vista
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        houseLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        title = model.name
    }
    func setupUI() {
        // Crear los botones
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        // Anadir los botones
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    @objc func displayWiki() {
        // Crear el VC destino
        let wikiViewController = WikiViewController(model: model)
        
        // Navegar a el, push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
    
    @objc func displayMembers() {
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        
        // Push
        navigationController?.pushViewController(memberListViewController, animated: true)
    }
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
    
}
