//
//  TipModel.swift
//  AppleIntelligence
//
//  Created by Aniket Bane on 16/02/25.
//

import Foundation
import TipKit

struct AddGalleryTipModel : Tip {
    static let showTip = Event(id: "showTip")
    
    var title: Text {
        Text("Add from Photos")
    }
    
    var message: Text? {
        Text("Select an image from your photos.")
    }

    var image: Image? {
        Image(systemName: "photo.badge.plus")
    }
    
    var rules: [Rule] {
        #Rule(Self.showTip) { event in
            event.donations.count == 1
        }
    }
    
}


struct AddPromptTipModel : Tip {
    static let promptTip = Event(id: "promptTip")
    
    var title: Text {
        Text("Add AI prompt")
    }
    
    var message: Text? {
        Text("Tell the AI what you'd like it to do!")
    }
    
    var image: Image? {
        Image(systemName: "text.bubble")
            .renderingMode(.template)
    }

    
    var rules: [Rule] {
        #Rule(Self.promptTip) { event in
            event.donations.count == 0
        }
    }
    
}

