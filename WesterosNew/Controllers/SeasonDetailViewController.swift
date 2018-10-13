//
//  SeasonDetailViewController.swift
//  WesterosNew
//
//  Created by Eduardo on 12/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    
    @IBAction func checkLabel(_ sender: Any) {
        let viewController = EpisodeListViewController(model: model.sortedEpisodes)
        //push
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    //Mark: Properties
    var model: Season
    
    //Mark: Initialization
    init(model: Season){
        //Limpio mi ***
        self.model = model
        //LLamamos a super
        super.init(nibName:nil, bundle:nil)
        // Si quiero uso alguna propiedad
        
     //   title = model.name
    }
    //Parche cuperino marca ACME
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Mark - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModel()
    }
    
    //Mark: Sync
    func syncModel(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        title = "Season"
        nameLabel.text = model.name
        let date = dateFormatter.string(from: model.releaseDate)
        releaseDateLabel.text = " Release date: \(date)"
        episodeLabel.text = " Number of Episode: \(model.count)"
        
    }
    
    
}
extension SeasonDetailViewController: SeasonListViewControllerDelegate{
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
       model = season
        syncModel()
        
        
    }
}
