//
//  DashBoardView.swift
//  AppleIntelligence
//
//  Created by Aniket Bane on 16/02/25.
//

import ImagePlayground
import PhotosUI
import SwiftUI
import TipKit

struct DashBoardView: View {
    @State var presejt = false
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImage: Image? = nil
    @State var generateImage: Bool = false
    @State var prompt: String = ""
    
    
    let addGallerytip = AddGalleryTipModel()
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    if  selectedImage != nil {
                        selectedImage?
                            .resizable()
                            .scaledToFill()
                            .frame(height: UIScreen.main.bounds.height)
                            .overlay(
                                GlassEffectView(
                                    prompt: $prompt,
                                    generateImage: $generateImage
                                )
                            )
                            .edgesIgnoringSafeArea(.all)
                    } else {
                            Image("model")
                                .resizable()
                                .scaledToFill()
                                .frame(height: UIScreen.main.bounds.height)
                                .overlay(
                                        GlassEffectView(
                                            prompt: $prompt,
                                            generateImage: $generateImage
                                        )
                                )
                                .edgesIgnoringSafeArea(.all)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ToolbarActionsView(
                        selectedItem: $selectedItem,
                        selectedImage: $selectedImage
                    ).popoverTip(addGallerytip)
                    
                    if selectedImage != nil {
                        Button {
                            selectedImage = nil
                        } label: {
                            ToolbarButtonsView(
                                systemName:
                                    "arrow.trianglehead.counterclockwise.rotate.90",
                                size: 35,
                                colors: [.white]
                            )
                        }
                    }
                }
               

                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if let url = URL(
                            string: "https://www.linkedin.com/in/aniket-bane")
                        {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack{
                            Image("linkedIn")
                                .resizable()
                                .frame(width: 30,height: 30)
                            Text("LinkedIn")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                        }
    
                    }

                }

            }
            .imagePlaygroundSheet(
                isPresented: $generateImage,
                concept: prompt,
                sourceImage: selectedImage,
                onCompletion: { url in
                    if let data = try? Data(contentsOf: url),
                        let image = UIImage(data: data)
                    {
                        selectedImage = Image(uiImage: image)
                        DispatchQueue.main
                            .asyncAfter(deadline: .now() + 5){
                                Task {await AddGalleryTipModel.showTip.donate()}
                            }
                    }
                },
                onCancellation: {
                    prompt = ""
                    DispatchQueue.main
                        .asyncAfter(deadline: .now() + 5){
                            Task {await AddGalleryTipModel.showTip.donate()}
                        }
                }
            )
        }
    }
}

#Preview {
    DashBoardView()
}
