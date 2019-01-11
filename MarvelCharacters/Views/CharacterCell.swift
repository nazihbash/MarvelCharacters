//
//  CharacterCell.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/10/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    var character: MarvelCharacter? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.clipsToBounds = true
        self.contentView.subviews.forEach { view in
            view.layer.cornerRadius = 8.0
            view.layer.masksToBounds = true
        }
        characterImageView.layer.cornerRadius = characterImageView.frame.size.width / 2.0
        characterImageView.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
    }
    
    private func updateView() {
        guard let character = character else { return }
        nameLabel.text = character.name
        characterImageView.kf.setImage(with: URL(string: character.imageUrl))
    }
}
