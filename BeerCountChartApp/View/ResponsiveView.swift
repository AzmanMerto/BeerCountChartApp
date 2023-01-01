//
//  ResponsiveView.swift
//  Responsive
//
//  Created by NomoteteS on 1.01.2023.
//

import SwiftUI
import Foundation

// MARK: Custom View Which will give Useful Properties for Adpotable
struct ResponsiveView<Content: View>: View {
    var content: (Properties)->Content
    init(@ViewBuilder content: @escaping (Properties)->Content ) {
        self.content = content
    }
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            let isLandscape = size.width > size.height
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let isMaxSplit = isSplit() && size.width < 400
            let properties = Properties(isLandscape: isLandscape, isiPad: isIpad, isSplit: isSplit(), isMaxSplit: isMaxSplit, size: size)
            
            content(properties)
                .frame(width: size.width, height: size.height)
        }
    }
    
    // MARK: Simple Way to Find it the app is in Split View
    func isSplit() -> Bool {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{return false}
        return screen.windows.first?.frame.size != screen.screen.bounds.size
    }
    
}

struct Properties{
    var isLandscape: Bool
    var isiPad: Bool
    var isSplit: Bool
// MARK: If the App size is reduced more than 1/3 in split mode on iPad
    var isMaxSplit: Bool
    var size: CGSize
}
