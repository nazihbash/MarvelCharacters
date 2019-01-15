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
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var characterImageView: EFImageViewZoom!
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
        
        characterImageView.imageViewContentMode = .scaleAspectFill
        characterImageView.imageViewCornerRadius = 100
        characterImageView.imageUrl = viewModel.character.imageUrl
        nameLabel.text = viewModel.character.name
        detailsLabel.text = viewModel.character.details
        viewWikiButton.isHidden = ApplicationHelper.isNullOrEmpty(viewModel.character.wikiUrl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        characterImageView._delegate = self
    }
    
    @IBAction func viewWikiButtonTapped() {
        if let url = URL(string: viewModel.character.wikiUrl) {
            let vc = WikiViewController.create(url: url)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CharacterDetailViewController: EFImageViewZoomDelegate {
    
    func didZoom(zoomingScale: CGFloat) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.2) {
            self.characterImageView.imageViewCornerRadius = 0
            self.mainView.subviews.forEach({ (subView) in
                if subView != self.characterImageView {
                    subView.alpha = 0
                }
            })
            self.view.layer.backgroundColor = UIColor(hexString: "424242").cgColor;
            self.view.layoutIfNeeded()
        }
    }
    func didEndZooming() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIView.animate(withDuration: 0.2) {
            self.characterImageView.imageViewCornerRadius = 100
            self.mainView.subviews.forEach({ (subView) in
                subView.alpha = 1
            })
            self.view.layer.backgroundColor = UIColor.white.cgColor;
            self.view.layoutIfNeeded()
        }
    }
}

