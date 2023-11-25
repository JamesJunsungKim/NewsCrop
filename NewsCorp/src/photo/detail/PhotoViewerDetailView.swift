//
//  PhotoViewerDetailView.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import Foundation
import SwiftUI
import Kingfisher

struct PhotoViewerDetailView: View {
    private let asset: PhotoAsset
    
    init(asset: PhotoAsset) {
        self.asset = asset
    }
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0

    var body: some View {
        VStack {
            Text(asset.title)
                .font(.headline)
                .lineLimit(2)
                .padding(EdgeInsets.init(top: 0, leading: 25, bottom: 0, trailing: 25))
            
            GeometryReader { geo in
                ScrollView([.vertical, .horizontal], showsIndicators: false){
                    ZStack{
                        KFImage(asset.url)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width,
                                   height: geo.size.width)
                            .scaleEffect(scale)
                            .gesture(MagnificationGesture().onChanged { val in
                                let delta = val / self.lastScaleValue
                                self.lastScaleValue = val
                                var newScale = self.scale * delta
                                if newScale < 1.0 {
                                    newScale =  1.0
                                }
                                scale = newScale
                            }.onEnded{val in
                                lastScaleValue = 1
                            })
                    }
                }
                .frame(width: geo.size.width, height: geo.size.width)
                .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))

            }
            
            Text("You can pinch zoom in")
                .font(.caption)
        }
    }
}

#Preview {
    PhotoCardView(asset: .dummy(id: 1))
}
