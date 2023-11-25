//
//  PhotoCardView.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import SwiftUI
import Kingfisher

struct PhotoCardView: View {
    let asset: PhotoAsset
    
    var body: some View {
        VStack {
            KFImage(asset.thumbnailUrl)
                .resizable()
                .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
            
            Text(asset.title)
                .lineLimit(1)
                .font(.caption)
                .foregroundColor(.black)
                .frame(alignment: .center)
        }
    }
}

//#Preview {
//    PhotoCardView(asset: .dummy)
//}
