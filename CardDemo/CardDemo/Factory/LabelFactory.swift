//
//  LabelFactory.swift
//  CardDemo
//
//  Created by JiWuChao on 2017/12/19.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

import UIKit

enum LableFactory {
    case standardLbl(text:String,textColor:UIColor,fontStyle:UIFontTextStyle,textAlignment:NSTextAlignment?,sizeToFit:Bool,adjustToFit:Bool)
    
    var new : UILabel {
        switch self {
        case .standardLbl(let text,let textColor,let fontStyle, let textAlignment,let sizeToFit, let adjustToFit):
            return createStandardLbl(text: text, textColor: textColor, fontStyle: fontStyle, textAlignment: textAlignment, sizeToFit: sizeToFit, adjustToFit: adjustToFit)
        }
    }
    
    private func createStandardLbl(text:String,textColor:UIColor,fontStyle:UIFontTextStyle,textAlignment:NSTextAlignment?,sizeToFit:Bool,adjustToFit:Bool) -> UILabel {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = adjustToFit
        lbl.text = text
        lbl.font = UIFont.preferredFont(forTextStyle: fontStyle)
        lbl.textAlignment = textAlignment ?? .left
        lbl.textColor = textColor
        if sizeToFit {
            lbl.sizeToFit()
        }
        return lbl
    }
}
