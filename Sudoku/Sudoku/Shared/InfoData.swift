//
//  Info.swift
//  Sudoku
//
//  Created by Jairo Júnior on 28/08/24.
//

import Foundation
import UIKit

struct InfoData{
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height

    var bigGridFrame: CGFloat
    var frameWidth: CGFloat
    var frameHeight: CGFloat
    
    
    init(){
        self.bigGridFrame = (width / 3) * 0.95
        
        self.frameWidth = (width / 9) * 0.95
        self.frameHeight = (width / 9) * 0.95
    }
}
