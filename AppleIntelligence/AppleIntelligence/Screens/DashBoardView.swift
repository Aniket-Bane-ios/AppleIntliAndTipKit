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
    @State var selectedImage: Image? = Image("model")
    @State var generateImage: Bool = false
    @State var prompt: String = ""
    
    
    let addGallerytip = AddGalleryTipModel()
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .appleIntelligenceYellow,
                            .appleIntelligenceIndigo,
                            .appleIntelligenceBlue,
                            .appleIntelligencePink
                        ]
                    ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
)
                .animation(.linear(duration: 2).repeatForever(autoreverses: true), value: UUID())
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    if selectedImage != nil {
                        selectedImage?
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .padding(.bottom, 100)
                            .padding(.horizontal)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }

                }.overlay {
                    GlassEffectView(
                        prompt: $prompt,
                        generateImage: $generateImage
                    )
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ToolbarActionsView(
                        selectedItem: $selectedItem,
                        selectedImage: $selectedImage
                    ).popoverTip(addGallerytip)
                    
                 
                }
               

                ToolbarItemGroup(placement: .topBarLeading) {
                    if selectedImage != Image("model") {
                        Button {
                            selectedImage =  Image("model")
                        } label: {
                            ToolbarButtonsView(
                                systemName:
                                    "arrow.trianglehead.counterclockwise.rotate.90",
                                size: 35,
                                colors: [.white]
                            )
                        }
                    }
                    
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
                        prompt = ""
                        selectedImage = Image(uiImage: image)
                        DispatchQueue.main
                            .asyncAfter(deadline: .now() + 3){
                                Task {await AddGalleryTipModel.showTip.donate()}
                            }
                    }
                },
                onCancellation: {
                    prompt = ""
                    DispatchQueue.main
                        .asyncAfter(deadline: .now() + 3){
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
