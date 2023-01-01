//
//  Home.swift
//  ResponsiveApp
//
//  Created by NomoteteS on 1.01.2023.
//

import SwiftUI

struct Home: View {
    var props: Properties
    // MARK: View Properties
    @State var currentTab: String = "Home"
    @Namespace var animation
    var body: some View {
        HStack(spacing: 0) {
           // MARK: Showing Only For iPad
            if props.isiPad{
                ViewThatFits {
                    SideBar()
                    ScrollView(.vertical,showsIndicators: false){
                        SideBar()
                    }
                    .background(Color.black.ignoresSafeArea())
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HeaderView()
                }
                .padding(15)
            }
        }
        .frame(minWidth: .infinity, maxWidth: .infinity)
        .background{
                Color.black
                    .opacity(0.04)
                    .ignoresSafeArea()
            }
    }
    // MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View{
        // MARK: Dynamic Layout(iOS 16+)
        let layout = props.isiPad && !props.isMaxSplit ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout(spacing: 22))
        
        layout{
            VStack(alignment: .leading, spacing: 8) {
                Text("Seattle, New York")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
            }
            // MARK: Search Bar With Menu Button
            HStack(spacing: 10) {
                if !(props.isiPad && !props.isMaxSplit) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                    TextField("Search", text:.constant(""))
                    
                    Image("Search")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                }
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .background {
                Capsule()
                    .fill(.white)
            }
        }
    }
    
    // MARK: Side Bar
    @ViewBuilder
    func SideBar()-> some View {
        // MARK: Tabs
        let tabs: [String] =  [
        "Home","Table","Menu","Order","History","Report","Alert","Settings"
        ]
        VStack(spacing: 10) {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .padding(.bottom,10)
            
            ForEach(tabs,id:\.self) { tab in
                VStack(spacing: 8) {
                    Image(tab)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    
                    Text(tab)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(currentTab == tab ? Color("Purple") : .gray)
                .padding(.vertical,13)
                .frame(width: 65)
                .background {
                    if currentTab == tab{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color("Purple").opacity(0.1))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeOut){currentTab = tab}
                }
            }
            Button {
                
            } label: {
                VStack {
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    
                    Text("Profile")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top,20)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity,alignment: .top)
        .frame(width: 100)
        .background {
                Color.white
                    .ignoresSafeArea()
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
