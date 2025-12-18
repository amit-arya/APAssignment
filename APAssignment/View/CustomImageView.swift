//
//  CustomImageView.swift
//  APAssignment
//
//  Created by Amit Arya iOS Dev on 17/12/25.
//

import SwiftUI

struct CustomImageView: View {
    @State var imageModel: ImageModel
    @StateObject var imageLoader = ImageLoader()

    var body: some View {
        GeometryReader{ geo in
            if let image = imageLoader.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.width/0.65)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 1)
                    }
                    .clipped()
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.9))
                    .frame(width: geo.size.width, height: geo.size.width / 0.65)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.blue, lineWidth: 1)
                    }
            }
        }
        .aspectRatio(0.65, contentMode: .fit)
        .onAppear {
            imageLoader.loadImage(from: imageModel.imageUrl)
        }
    }
}

#Preview {
    let imageModel = ImageModel(id: "123", thumbnail: Thumbnail(domain: "", basePath: "", key: ""))
    CustomImageView(imageModel: imageModel)
}
