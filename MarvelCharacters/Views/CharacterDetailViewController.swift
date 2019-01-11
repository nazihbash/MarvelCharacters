//
//  CharacterDetailViewController.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/11/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import UIKit

class CharacterDetailViewController: BaseViewController {
    
    private var viewModel: CharacterDetailViewModel!
    
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var viewWikiButton: UIButton!

    static func create(character: MarvelCharacter) -> CharacterDetailViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        vc.viewModel = CharacterDetailViewModel(character: character)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.character.name
        characterImageView.layer.cornerRadius = characterImageView.frame.size.width / 2.0
        characterImageView.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        
        characterImageView.kf.setImage(with: URL(string: viewModel.character.imageUrl))
        nameLabel.text = viewModel.character.name
        detailsLabel.text = viewModel.character.details
        viewWikiButton.isHidden = ApplicationHelper.isNullOrEmpty(viewModel.character.wikiUrl)
    }
    
    @IBAction func viewWikiButtonTapped() {
        if let url = URL(string: viewModel.character.wikiUrl) {
            let vc = WikiViewController.create(url: url)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
