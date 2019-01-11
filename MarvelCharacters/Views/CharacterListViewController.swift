//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Nazih on 1/8/19.
//  Copyright © 2019 Nazih Bash. All rights reserved.
//

import UIKit

class CharacterListViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    private var viewModel = CharacterListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "title.list".localized
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        disposables.add(viewModel.fetchCharacterAction.isExecuting.producer.skip(first: 1).startWithValues { [weak self] (isExecuting) in
            guard let `self` = self else { return }
            
            if isExecuting && self.viewModel.characterListMap.value.offset == 0 {
                self.showProgressAnimation()
            } else {
                self.hideProgressAnimation()
            }
        })
        
        disposables.add(viewModel.fetchCharacterAction.errors.producer.startWithValues { [weak self] (error) in
            self?.hideProgressAnimation()
            self?.showError(error: error)
        })
        
        disposables.add(viewModel.characterListMap.producer.startWithValues { [weak self] (characterListMap) in
            guard let `self` = self else { return }
            
            self.hideProgressAnimation()
            self.tableView.reloadData()
        })
        
        viewModel.fetchMoreCharacters()
    }
}
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterListMap.value.characters.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailViewController.create(character: viewModel.characterListMap.value.characters[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.character = viewModel.characterListMap.value.characters[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let displayedCount = viewModel.characterListMap.value.characters.count
        if indexPath.row + 1 == displayedCount {
            if displayedCount < viewModel.characterListMap.value.total {
                if !viewModel.fetchCharacterAction.isExecuting.value {
                    viewModel.characterListMap.value.offset += Constants.characterPageLimit
                    viewModel.fetchMoreCharacters()
                    
                    let spinner = UIActivityIndicatorView(style: .gray)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
                    
                    tableView.tableFooterView = spinner
                }
            } else {
                tableView.tableFooterView = nil
            }
        }
    }
}
