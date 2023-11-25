//
//  PhotoViewerListViewModel.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import Foundation
import SwiftUI
import Combine

final class PhotoViewerListViewModel: ObservableObject {
    
    typealias InputType = Input
    
    enum Input {
        case onAppear
        case didPullScrollView
    }
    
    enum Output {
        case setAssets
        case showError(message: String)
    }
    
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService
        
        bindInput()
    }
    
    private let apiService: APIServiceType
    
    let inputStream = PassthroughSubject<Input, Never>()
    
    // Output
    @Published private(set) var assets = [PhotoAsset]()
    @Published var isErrorShown = false
    @Published private(set) var errorMessage = ""
    
    private var cancellables: [AnyCancellable] = []
    
    private func bindInput() {
        let inputCancellable = inputStream
            .sink(receiveValue: { [weak self] in
                switch $0 {
                case .onAppear, .didPullScrollView:
                    self?.getPhotoList()
                }
            })
        
        cancellables.append(inputCancellable)
    }
    
    private func getPhotoList() {
        let request = PhotoListRequest()
        let cancellable = apiService.response(from: request)
            .subscribe(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                    
                case let .failure(error):
                    self?.errorMessage = error.localizedDescription
                    self?.isErrorShown = true
                }
                
            }, receiveValue: { [weak self] in
                self?.assets = $0
            })
        
        cancellables.append(cancellable)
    }
}



