//
//  Utils.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

class Utils {
    
    static func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    static func getGradientColors(pokemonType: PokemonType) -> [UIColor] {
        var gradientColors: [UIColor] = []
        switch pokemonType {
        case .bug:
            gradientColors.append(UIColor(hexString: "92BC2C"))
            gradientColors.append(UIColor(hexString: "AFC836"))
        case .dark:
            gradientColors.append(UIColor(hexString: "595761"))
            gradientColors.append(UIColor(hexString: "6E7587"))
        case .dragon:
            gradientColors.append(UIColor(hexString: "0C69C8"))
            gradientColors.append(UIColor(hexString: "0180C7"))
        case .electric:
            gradientColors.append(UIColor(hexString: "EDD53E"))
            gradientColors.append(UIColor(hexString: "FBE273"))
        case .fairy:
            gradientColors.append(UIColor(hexString: "EC8CE5"))
            gradientColors.append(UIColor(hexString: "F3A7E7"))
        case .fighting:
            gradientColors.append(UIColor(hexString: "CE4265"))
            gradientColors.append(UIColor(hexString: "E74347"))
        case .fire:
            gradientColors.append(UIColor(hexString: "FB9B51"))
            gradientColors.append(UIColor(hexString: "FBAE46"))
        case .flying:
            gradientColors.append(UIColor(hexString: "90A7DA"))
            gradientColors.append(UIColor(hexString: "A6C2F2"))
        case .ghost:
            gradientColors.append(UIColor(hexString: "516AAC"))
            gradientColors.append(UIColor(hexString: "7773D4"))
        case .grass:
            gradientColors.append(UIColor(hexString: "5FBC51"))
            gradientColors.append(UIColor(hexString: "5AC178"))
        case .ground:
            gradientColors.append(UIColor(hexString: "DC7545"))
            gradientColors.append(UIColor(hexString: "D29463"))
        case .ice:
            gradientColors.append(UIColor(hexString: "70CCBD"))
            gradientColors.append(UIColor(hexString: "8CDDD4"))
        case .normal:
            gradientColors.append(UIColor(hexString: "9298A4"))
            gradientColors.append(UIColor(hexString: "A3A49E"))
        case .poison:
            gradientColors.append(UIColor(hexString: "A864C7"))
            gradientColors.append(UIColor(hexString: "C261D4"))
        case .psychic:
            gradientColors.append(UIColor(hexString: "F66F71"))
            gradientColors.append(UIColor(hexString: "FE9F92"))
        case .rock:
            gradientColors.append(UIColor(hexString: "C5B489"))
            gradientColors.append(UIColor(hexString: "D7CD90"))
        case .steel:
            gradientColors.append(UIColor(hexString: "52869D"))
            gradientColors.append(UIColor(hexString: "58A6AA"))
        case .water:
            gradientColors.append(UIColor(hexString: "4A90DD"))
            gradientColors.append(UIColor(hexString: "6CBDE4"))
        }
        return gradientColors
    }
    
    static func numberFormat(_ number: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        // Avoid not getting a zero on numbers lower than 1
        // Eg: .5, .67, etc...
        formatter.numberStyle = .decimal
        
        return formatter.string(from: number as NSNumber) ?? "n/a"
    }
}
