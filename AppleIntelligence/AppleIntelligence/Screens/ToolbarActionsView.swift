//
//  ToolbarActionsView.swift
//  AppleIntelligence
//
//  Created by Aniket Bane on 16/02/25.
//

import SwiftUI
import PhotosUI

struct ToolbarActionsView: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var selectedImage: Image?
    
    var body: some View {
        HStack {
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                ToolbarButtonsView(
                    systemName: "photo.on.rectangle.angled.fill",
                    size: 45,
                    colors: [.pink, .blue]
                )
            }
            .onChange(of: selectedItem) {
                Task {
                    if ((selectedItem) != nil){
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedImage = Image(uiImage: uiImage)
                        }
                    }
                }
            }
        }
    }
}



    #Preview {
        ToolbarActionsView(selectedItem: .constant(nil), selectedImage: .constant(nil))
    }


