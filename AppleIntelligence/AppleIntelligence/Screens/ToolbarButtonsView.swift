//
//  ToolbarButtonsView.swift
//  AppleIntelligence
//
//  Created by Aniket Bane on 16/02/25.
//

import SwiftUI

struct ToolbarButtonsView: View {
    var systemName: String
    var size: CGFloat
    var colors: [Color] 
    
    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .fontWeight(.bold)
            .symbolRenderingMode(.palette)
            .foregroundStyle(colors.count > 1 ? AnyShapeStyle(colors[0]) : AnyShapeStyle(Color.white),
                             colors.count > 1 ? AnyShapeStyle(colors[1]) : AnyShapeStyle(Color.gray),
                             colors.count > 2 ? AnyShapeStyle(colors[2]) : AnyShapeStyle(Color.clear))
            .frame(width: size, height: size)
    }
}

#Preview {
    ToolbarButtonsView(systemName: "photo.on.rectangle.angled.fill", size: 35, colors: [.red,.green])
}
