//
//  PhotoViewerList.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import SwiftUI
import Combine
import Refresher

struct PhotoViewerListView: View {
    @ObservedObject private var viewModel: PhotoViewerListViewModel
    
    private let height: CGFloat = 180
    private var assets = [PhotoAsset]()
    
    init(viewModel: PhotoViewerListViewModel) {
        self.viewModel = viewModel
    }
    
    private var cancellables: [AnyCancellable] = []
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Photo Viewer")
                    .font(.headline)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.assets, id: \.self) { asset in
                            NavigationLink(destination: PhotoViewerDetailView(asset: asset),
                                           label: {
                                PhotoCardView(asset: asset)
                                    .padding(EdgeInsets.init(top: 0, leading: 5, bottom: 0, trailing: 5))
                            })
                        }
                    }
                }
                .refresher(style: .system, action: {
                    self.viewModel.inputStream.send(.didPullScrollView)
                })
                .alert(isPresented: $viewModel.isErrorShown, content: { () -> Alert in
                    Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
                })
            }
            .onAppear(perform: {
                self.viewModel.inputStream.send(.onAppear)
            })
        }
    }
  
}

