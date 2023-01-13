//
//  DetailsViewController.swift
//  Proyecto
//
//  Created by Oscar Rodriguez Garrucho on 19/12/22.
//

import UIKit

class DetailsViewController: BaseViewController {

    @IBOutlet weak var heroeImageView: UIImageView!
    @IBOutlet weak var heroeNameLabel: UILabel!
    @IBOutlet weak var heroeDescLabel: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    
    
    var heroe: Heroe!
    var transformations: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transformationsButton.alpha = 0
        title = heroe.name
        
        heroeImageView.setImage(url: heroe.photo)
        heroeNameLabel.text = heroe.name
        heroeDescLabel.text = heroe.description
        
        let token = LocalDataLayer.shared.getToken()
        
        NetworkLayer
            .shared
            .fetchTransformations(token: token, heroeId: heroe.id) { [weak self] allTrans, error in
                guard let self = self else { return }
                
                if let allTrans = allTrans {
                    self.transformations = allTrans
                    
                    print("trans count: ", allTrans.count)
                    
                    if !self.transformations.isEmpty {
                        DispatchQueue.main.async {
                            self.transformationsButton.alpha = 1
                        }
                    }
                    
                } else {
                    print("Error fetching transformations: ", error?.localizedDescription ?? "")
                }
            }
    }


    @IBAction func transformationsButtonTapped(_ sender: UIButton) {
        let transView = TransformationsViewController()
        transView.transformations = self.transformations
        
        navigationController?.pushViewController(transView, animated: true)
    }
    

}
