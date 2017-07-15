//
//  SwiftViewController.swift
//  Week3
//
//  Created by YongJai on 13/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

import UIKit

@objc protocol FoodMenu: class {
    func didSelectMenu(menuType : FoodMenu)
}

@objc enum Menu: UInt {
    case bossam = 1
    case chicken, dduck, hamburger, pizza
    
    func didSelectMenu(menuType : Menu) -> String {
        switch self {
        case .bossam:
            return "bossam"
        case .chicken:
            return "chicken"
        case .dduck:
            return "dduck"
        case .hamburger:
            return "hamburger"
        case .pizza:
            return "pizza"
        }
    }
}

class SwiftViewController: UIViewController {
    var delegate: FoodMenu?
    
    @IBOutlet weak var randImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func random(_ range:Range<Int>) -> Int {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    @IBAction func clickedShuffleBtn(_ sender: Any) {
        let food :String
        let num = random(1..<6)
        if let convertFood = Menu(rawValue: UInt(num)){
            food = convertFood.didSelectMenu(menuType: convertFood)
            randImage.image = UIImage(named:"\(food)")
            print(food)
        }
    }
}


