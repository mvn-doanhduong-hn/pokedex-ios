//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit
import RxSwift
import Reusable
import MXSegmentedPager

class PokemonDetailViewController: MXSegmentedPagerController, StoryboardBased, ViewModelBased {
    
    var viewModel: PokemonDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    let titles = ["Stats", "Evolutions", "Moves"]
    let viewPages = [StatsPageView(), EvolutionsPageView(), MovesPageView()]
    
    let pokemonHeaderView = PokemonDetailHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingPagerView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestPokemonDetail.onNext(())
        
        segmentedPager.parallaxHeader.minimumHeight = pokemonHeaderView.menuBarView.bounds.height
    }
    
    private func settingPagerView() {
        segmentedPager.backgroundColor = .white

        // Parallax Headerok
        segmentedPager.parallaxHeader.view = pokemonHeaderView
        pokemonHeaderView.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        segmentedPager.parallaxHeader.mode = .fill
        segmentedPager.parallaxHeader.height = pokemonHeaderView.bounds.height
        segmentedPager.parallaxHeader.minimumHeight = pokemonHeaderView.menuBarView.bounds.height

        // Segmented Control customization

        segmentedPager.segmentedControl.type = .text
        segmentedPager.segmentedControl.sectionTitles = titles

        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = .white
        segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hexString: "1C8BED")]
        segmentedPager.segmentedControl.selectionStyle = .arrow
        segmentedPager.segmentedControl.selectionIndicatorColor = UIColor(hexString: "1C8BED")
    }

    @objc func backAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: {})
    }
    
    func bindViewModel() {
        viewModel.pokemonDetail
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                switch result {
                case .success(let value):
                    print("Value: ", value.pokemon.name)
                    self.setDataPokemonDetail(pokemon: value.pokemon)
                    self.setDataStatsPage(stats: value.stats)
                    self.setDataEvolutionsPage(evolutions: value.evolutions)
                    self.setDataMovesPage(moves: value.moves)
                    
                case .failure(let error):
                    print("Error: ", error.description)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setDataPokemonDetail(pokemon: Pokemon) {
        pokemonHeaderView.setData(pokemon: pokemon)
    }
    
    func setDataStatsPage(stats: Stats) {
        let statsPageView = viewPages[0] as! StatsPageView
        statsPageView.setData(stats: stats)
    }
    
    func setDataEvolutionsPage(evolutions: [Evolution]) {
        let evolutionsPageView = viewPages[1] as! EvolutionsPageView
        evolutionsPageView.setData(evolutions)
    }
    
    func setDataMovesPage(moves: [Move]) {
        let movesPageView = viewPages[2] as! MovesPageView
        movesPageView.setData(moves)
    }
    
    // Asks the data source to return the number of pages in the segmented pager.
    override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return titles.count
    }

    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return titles[index]
    }

    // Asks the data source for a view to insert in a particular page of the pager.
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewForPageAt index: Int) -> UIView {
        return viewPages[index]
    }

    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
        pokemonHeaderView.fadeInTitleBar()
        if (parallaxHeader.progress <= 0.3) {
            if (pokemonHeaderView.isTitleBarHidden()) {
                pokemonHeaderView.fadeInTitleBar()
            }
        } else {
            if (!pokemonHeaderView.isTitleBarHidden()) {
                pokemonHeaderView.fadeOutTitleBar()
            }
        }
    }
    
}
