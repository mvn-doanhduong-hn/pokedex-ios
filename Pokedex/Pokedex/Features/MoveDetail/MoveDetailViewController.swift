//
//  MoveDetailViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

class MoveDetailViewController: BaseDetailViewController, StoryboardBased, ViewModelBased {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeWithTextImageView: UIImageView!
    @IBOutlet weak var effectsLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    
    var viewModel: MoveDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setBackgroundGradientColor(fromHexString: "559EDF", toHexString: "69B9E3")
        setRoundCornerView(contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestMoveDetail.onNext(())
    }
    
    func bindViewModel() {
        viewModel.moveDetail
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                switch result {
                case .success(let move):
                    print("Value: ", move.name)
                    let pokemonType = PokemonType.init(rawValue: move.type)
                    self.typeImageView.image = UIImage(named: (pokemonType!.image.lowercased()))
                    self.typeWithTextImageView.image = UIImage(named: (pokemonType!.imageWithText.lowercased()))
                    self.nameLabel.text = move.name
                    self.effectsLabel.text = move.effects
                    self.powerLabel.text = "\(move.power ?? 0)"
                    self.accuracyLabel.text = "\(move.accuracy ?? 0)%"
                    self.ppLabel.text = "\(move.pp ?? 0)"
                    
                    let gradientColors = Utils.getGradientColors(pokemonType: pokemonType!)
                    self.view.setBackgroundGradientColor(fromColor: gradientColors[0], toColor: gradientColors[1])
                    
                case .failure(let error):
                    print("Error: ", error.description)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
}

