//
//  Helpers.swift
//  AppleIntelligence
//
//  Created by Aniket Bane on 16/02/25.
//

import Foundation
import UIKit


final class Helpers {
    static let shared = Helpers()
    
    private init() {} 
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

 
