//
//  ContentView.swift
//  Responsive
//
//  Created by NomoteteS on 30.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ResponsiveView { props in
            Home(props: props )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
