//
//  ShopListView.swift
//  CoffeeShop
//
//  Created by Vanessa Cassandra on 26/11/22.
//

import SwiftUI

struct ShopListView: View {
    // MARK: - PROPERTIES
    
    @State private var searchText: String = ""
    
    private var shopSearchResult: [Coffeeshop] {
        let result = CoffeeshopProvider.all()
        
        if searchText.isEmpty {
            return result
        }
        
        return result.filter{
            $0.name.lowercased().contains(searchText.lowercased())
        }
        
    }
    
    private var suggestedResult: [Coffeeshop] {
        if searchText.isEmpty {
            return []
        }
        
        return shopSearchResult
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List(shopSearchResult) { result in
                
                NavigationLink(destination: ShopDetailView(shopDetail: result)) {
                    
                    Image(result.image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(result.name)
                            .fontWeight(.bold)
                        
                        Text(result.location)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        Text("Rating 4/5")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Coffeeshop")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search coffeeshops")
            {
                
                ForEach(suggestedResult) { result in
                    Text("Looking for \(result.name)?")
                        .searchCompletion(result.name)
                }
                
            }
            
        }
    }
}

struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        ShopListView()
    }
}
