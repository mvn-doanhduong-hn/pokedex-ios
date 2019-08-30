//
//  ItemDetailViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

class ItemDetailViewController: BaseDetailViewController, StoryboardBased, ViewModelBased {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var effectsLabel: UILabel!
    
    var viewModel: ItemDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundGradientColor(fromHexString: "84E090", toHexString: "75DEDD")
        setRoundCornerView(contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestItemDetail.onNext(())
    }
    
    func bindViewModel() {
        viewModel.itemDetail
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                switch result {
                case .success(let item):
                    print("Value: ", item.name)
                    self.itemImageView.af_setImage(withURL: URL(string: item.image)!)
                    self.itemNameLabel.text = item.name
                    self.itemPriceLabel.text = "\(item.price)"
                    self.effectsLabel.text = item.effects
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
