import SwiftUI

struct Furniture: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var imageName: String
    var selectedModel: String
    var price: String
    var scale: Float
    var isWallDecoration: Bool
    var category: String // Tambahkan properti category

}

struct MenuPage: View {
    @State private var selectedFilter: String = "All"
    @State private var selectedModel: String = ""
    @State private var showSearch: Bool = false
    
    @State private var searchText: String = ""
    
    let chairItems: [Furniture] = [
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "chair1", selectedModel: "chair1", price: "Rp 299.000", scale: 0.0095, isWallDecoration: false , category: "chair"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "chair2", selectedModel: "chair2", price: "Rp 299.000", scale: 0.0022, isWallDecoration: false, category: "chair"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "chair3", selectedModel: "chair3",price: "Rp 299.000", scale: 0.0022, isWallDecoration: false, category: "chair"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "chair4", selectedModel: "chair4",price: "Rp 299.000", scale: 0.0025, isWallDecoration: false, category: "chair"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "chair5", selectedModel: "chair5",price: "Rp 299.000", scale: 0.005, isWallDecoration: false, category: "chair")
    ]
    
    let tableItems: [Furniture] = [
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "table1", selectedModel: "table3",price: "Rp 299.000", scale: 0.04, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "table2", selectedModel: "table1",price: "Rp 299.000", scale: 0.01, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "table3", selectedModel: "table2",price: "Rp 299.000", scale: 0.0025, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "table4", selectedModel: "table5", price: "Rp 299.000",scale: 0.0095, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "table5", selectedModel: "table4", price: "Rp 299.000",scale: 0.002, isWallDecoration: false, category: "table"),
    ]
    
    let drawerItems: [Furniture] = [
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "drawer1", selectedModel: "drawer1", price: "Rp 299.000",scale: 0.0018, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "drawer2", selectedModel: "drawer2", price: "Rp 299.000",scale: 0.002, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "drawer3", selectedModel: "drawer3", price: "Rp 299.000",scale: 0.002, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "drawer4", selectedModel: "drawer4",price: "Rp 299.000", scale: 0.01, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "drawer5", selectedModel: "drawer5", price: "Rp 299.000",scale: 0.006, isWallDecoration: false, category: "table"),
    ]
    
    let wardrobeItems: [Furniture] = [
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wardrobe1", selectedModel: "wardrobe1", price: "Rp 299.000",scale: 0.0075, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wardrobe2", selectedModel: "wardrobe2", price: "Rp 299.000",scale: 0.0075, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wardrobe3", selectedModel: "wardrobe3", price: "Rp 299.000",scale: 0.0095, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wardrobe4", selectedModel: "wardrobe4", price: "Rp 299.000",scale: 0.0065, isWallDecoration: false, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wardrobe5", selectedModel: "wardrobe5", price: "Rp 299.000",scale: 0.0065, isWallDecoration: false, category: "table"),
    ]
    
    let wallItems: [Furniture] = [
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wall1", selectedModel: "wall1", price: "Rp 299.000",scale: 0.0045, isWallDecoration: true, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wall2", selectedModel: "wall2", price: "Rp 299.000",scale: 0.0075, isWallDecoration: true, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wall3", selectedModel: "wall3", price: "Rp 299.000",scale: 0.0025, isWallDecoration: true, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wall4", selectedModel: "wall4", price: "Rp 299.000",scale: 0.0025, isWallDecoration: true, category: "table"),
        Furniture(name: "Wooden Chair", description: "A comfortable wooden chair.", imageName: "wall5", selectedModel: "wall5", price: "Rp 299.000",scale: 0.006, isWallDecoration: true, category: "table"),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack {
                        Image("sofa3")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 400)
                            .offset(y: -10)
                            .clipped()
                            .overlay(Color.black.opacity(0.4))
                            .padding(.top, 12)
                            .onTapGesture {
                                withAnimation {
                                    showSearch = false
                                    searchText = ""
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            }
                        
                        VStack(alignment: .center) {
                            Text("Aike allows you to see photorealistic 3D furniture models in your own rooms.")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            ZStack {
                                if showSearch {
                                    TextField("Search furniture", text: $searchText)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(32)
                                        .padding(.horizontal, 450)
                                        .padding(.bottom, 30)
                                        .background(
                                            Color.clear
                                                .contentShape(Rectangle())
                                                .onTapGesture {
                                                    withAnimation {
                                                        showSearch = false
                                                        searchText = ""
                                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                    }
                                                }
                                        )
                                } else {
                                    ZStack{
                                        Text("Search furniture         ")
                                            .foregroundColor(Color.init(hex: 0x515558))
                                            .fontWeight(.regular)
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 20)
                                        //                                        .background(Color.init(hex: 0x515558))
                                            .background(Color.white)
                                            .cornerRadius(32)
                                        
                                        Image(systemName: "magnifyingglass")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 16, height: 36)
                                            .foregroundColor(Color.init(hex: 0x515558))
                                            .padding(.bottom, 0)
                                            .padding(.leading, 156)
                                    }
                                        .onTapGesture {
                                            withAnimation(.spring) {
                                                showSearch = true
                                                
                                                
                                            }
                                        }
                                }
                               
                            }
                    
                        }.padding(.top, 30)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Filter:")
                            .padding(.leading, 36)
                        
                        HStack {
                            FilterButton(filterName: "All", selectedFilter: $selectedFilter)
                            FilterButton(filterName: "Chair", selectedFilter: $selectedFilter)
                            FilterButton(filterName: "Table", selectedFilter: $selectedFilter)
                            FilterButton(filterName: "Drawer", selectedFilter: $selectedFilter)
                            FilterButton(filterName: "Wardrobe", selectedFilter: $selectedFilter)
                            FilterButton(filterName: "Wall Decoration", selectedFilter: $selectedFilter)
                        }
                        .padding(.leading, 32)
                        
                        if selectedFilter == "All" || selectedFilter == "Chair" {
                            FurnitureSection(title: "Chair", items: chairItems, selectedFilter: selectedFilter, searchText: searchText)
                        }
                        if selectedFilter == "All" || selectedFilter == "Table" {
                            FurnitureSection(title: "Table", items: tableItems, selectedFilter: selectedFilter, searchText: searchText)
                        }
                        if selectedFilter == "All" || selectedFilter == "Drawer" {
                            FurnitureSection(title: "Drawer", items: drawerItems, selectedFilter: selectedFilter, searchText: searchText)
                        }
                        if selectedFilter == "All" || selectedFilter == "Wardrobe" {
                            FurnitureSection(title: "Wardrobe", items: wardrobeItems, selectedFilter: selectedFilter, searchText: searchText)
                        }
                        if selectedFilter == "All" || selectedFilter == "Wall Decoration" {
                            FurnitureSection(title: "Wall Decoration", items: wallItems, selectedFilter: selectedFilter, searchText: searchText)
                        }
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                }
            }
            .navigationBarTitle("Select Furniture")
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FilterButton: View {
    var filterName: String
    @Binding var selectedFilter: String
    
    var body: some View {
        Text(filterName)
            .foregroundColor(selectedFilter == filterName ? .white : Color.init(hex: 0x515558))
            .fontWeight(.medium)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(selectedFilter == filterName ? Color.init(hex: 0x515558) : Color.init(hex: 0xCBFFF8))
            .cornerRadius(32)
            .onTapGesture {
                selectedFilter = filterName
            }
    }
}

struct FurnitureSection: View {
    var title: String
    var items: [Furniture]
    var selectedFilter: String
    var searchText: String
    
    var body: some View {
        let filteredItems = items.filter { searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .padding(.leading, 32)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(filteredItems) { item in
                        NavigationLink(destination: ContentView(furnitureName: item.selectedModel, furnitureScale: item.scale, isWallDecoration: item.isWallDecoration, category: item.category)) {
                            FurnitureCardView(furniture: item)
                                .frame(width: 250, height: 360)
                                .padding(.horizontal, 12)
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .padding(.top, 48)
    }
}

struct FurnitureCardView: View {
    var furniture: Furniture
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(furniture.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
            
            Text(furniture.name)
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .foregroundColor(Color.init(hex: 0x43494D))
                .padding(.top, 12)
            
            Text(furniture.description)
                .fontWeight(.regular)
                .font(.system(size: 16))
                .foregroundColor(Color.init(hex: 0x43494D))
                .padding(.top, 2)
            
            Text(furniture.price)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(Color.init(hex: 0x43494D))
                .padding(.top, 12)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    MenuPage()
}
