//
//  Home.swift
//  ResponsiveApp
//
//  Created by NomoteteS on 1.01.2023.
//

import SwiftUI
// MARK: iOS 16+
import Charts

struct Home: View {
    var props: Properties
    // MARK: View Properties
    @State var currentTab: String = "Home"
    @Namespace var animation
    @State var showSideBar: Bool = false
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
                    InfoCards()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            DailySalesView()
                            PieChartView()
                        }
                    }
                    .padding(.horizontal,15)
                }
                .padding(15)
            }
        }
        //        .frame(minWidth: .infinity, maxHeight: .infinity,alignment: .leading)
        .background{
            Color.black
                .opacity(0.04)
                .ignoresSafeArea()
        }
        .overlay(alignment: .leading) {
            // MARK: Side Bar For Non iPad Devices
            ViewThatFits {
                SideBar()
                ScrollView(.vertical,showsIndicators: false){
                    SideBar()
                }
                .background(Color.black.ignoresSafeArea())
            }
            .offset(x: showSideBar ? 0 : -100)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                Color.black
                    .opacity(showSideBar ? 0.25 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut){showSideBar.toggle()}
                    }
            }
        }
    }
    
    // MARK: Piechart View
    func PieChartView()-> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Total Income")
                .font(.title2.bold())
            
            ZStack {
                Circle()
                    .trim(from: 0.5, to: 1)
                    .stroke(.red, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0.2, to: 0.5)
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(.green, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Text("$200K")
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 15) {
                Label {
                    Text("Beer")
                        .font(.caption)
                        .foregroundColor(.black)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.green)
                }

                Label {
                    Text("Wine")
                        .font(.caption)
                        .foregroundColor(.black)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.red)
                }
                
                Label {
                    Text("Vodka")
                        .font(.caption)
                        .foregroundColor(.black)
                } icon: {
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                }
            }
        }
        .padding(15)
        .frame(width: 250, height: 260)
        .background{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
    }
    
    // MARK: Graph View
    @ViewBuilder
    func DailySalesView()->some View{
        VStack(alignment: .leading, spacing: 15) {
            Text("Daily Sales")
                .font(.title3.bold())
            
            Chart {
                ForEach(dailySales){sale in
                    //MARK: Area Mark For Gradient BG
                    AreaMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(.linearGradient(colors: [
                        
                        Color("Purple").opacity(0.6),
                        Color("Purple").opacity(0.5),
                        Color("Purple").opacity(0.3),
                        Color("Purple").opacity(0.1),
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
                    .interpolationMethod(.catmullRom)
                    
                    // MARK: Line Mark
                    LineMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(Color("Purple"))
                    .interpolationMethod(.catmullRom)
                    
                    // MARK: Point Mark For Showing Points
                    PointMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(Color("Purple"))
                }
            }
            .frame(height: 150)
        }
        .padding(15)
        .background(content: {
            RoundedRectangle(cornerRadius: 15,style: .continuous)
                .fill(.white)
        })
        .frame(minWidth: props.size.width - 30)
    }
    
    // MARK: Info Cards View
    @ViewBuilder
    func InfoCards()-> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(infos) { info in
                    VStack(alignment: .leading, spacing: 18) {
                        HStack(spacing: 15) {
                            Text(info.title)
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Image(systemName: info.loss ? "arrow.down" : "arrow.up")
                                Text("\(info.percentage)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(info.loss ? .red : .green)
                            }
                            
                            HStack(spacing: 18) {
                                Image(systemName: info.icon)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .frame(width: 45, height: 45)
                                    .background {
                                        Circle()
                                            .fill(info.iconColor)
                                    }
                                
                                Text(info.amount)
                                    .font(.title.bold())
                                
                            }
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 15,style: .continuous)
                                .fill(.white)
                        }
                    }
                }
                .padding(15)
            }
        }
        .padding(.horizontal,-15)
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
            .frame(maxWidth: .infinity,alignment: .leading)
            // MARK: Search Bar With Menu Button
            HStack(spacing: 10) {
                if !(props.isiPad && !props.isMaxSplit) {
                    Button {
                        withAnimation(.easeOut){showSideBar.toggle()}
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
            .padding(.horizontal,15)
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
