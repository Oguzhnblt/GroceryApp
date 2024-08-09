//
//  AppFonts.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 5.08.2024.
//

import SwiftUI

enum AppFonts {
    static func gilroyMedium(size: CGFloat) -> Font {
        Font.custom("Gilroy-Medium", size: size)
    }
    
    static func gilroySemiBold(size: CGFloat) -> Font {
        Font.custom("Gilroy-SemiBold", size: size)
    }
    
    static func gilroyRegular(size: CGFloat) -> Font {
        Font.custom("Gilroy-Regular", size: size)
    }
    
    static func gilroyBold(size: CGFloat) -> Font {
        Font.custom("Gilroy-Bold", size: size)
    }
}
