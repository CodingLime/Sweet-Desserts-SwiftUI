import SwiftUI

struct DessertCell: View {
    
    let dessert: Dessert
    
    var body: some View {
        NavigationLink(destination: DessertDetailsView(dessert: dessert)){
            HStack {
                DessertRemoteImage(urlString: NetworkManager.baseURL + dessert.imageURL)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 90)
                    .cornerRadius(8)

                VStack(alignment: .leading, spacing: 5) {
                    Text(dessert.name)
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text("$\(dessert.price, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                }
                //.padding(.leading)
            }
        }
        //.padding(.leading)
    }
}


struct DessertCell_Previews: PreviewProvider {
    static var previews: some View {
        DessertCell(dessert: MockData.sampleDessert)
    }
}
