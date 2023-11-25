//
//  NewsCorpApp.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import SwiftUI

@main
struct NewsCorpApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoViewerListView(viewModel: .init())
        }
    }
}
