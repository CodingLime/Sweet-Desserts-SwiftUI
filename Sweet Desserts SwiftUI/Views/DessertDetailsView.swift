import SwiftUI

struct DessertDetailsView: View {
    let dessert: Dessert
    
    @EnvironmentObject private var viewModel: DessertListViewModel
    @EnvironmentObject private var userManager: UserManagerViewModel
    
    @State var showModalLogin: Bool = false
    
    //@Binding var selectedTab: Int
    
    var body: some View {
        VStack() {
            DessertRemoteImage(urlString: NetworkManager.baseURL + dessert.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 240, height: 180)
                .cornerRadius(8)
            
            Text(dessert.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(String(format: "Price: $%.2f", dessert.price))
                .font(.subheadline)
                .padding(.bottom)
            
            Text(dessert.description)
                .font(.body)
            
            Text("Calories: \(dessert.calories)")
                .font(.subheadline)
                .padding(.bottom)
            
            if ((userManager.currentUser?.email) != nil){
                Button(action: {
                    if(viewModel.favoriteDesserts.contains { $0.id == dessert.id }){
                        viewModel.removeFromFavorites(dessert)
                    } else {
                        viewModel.addToFavorites(dessert)
                    }
                }) {
                    
                    if(viewModel.favoriteDesserts.contains { $0.id == dessert.id }){
                        Text("Remove from favorites")
                            .foregroundColor(.red)
                            .frame(width: 200, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.red, lineWidth: 1)
                            )
                    } else {
                        Text("Add to favorites")
                            .foregroundColor(.blue)
                            .frame(width: 150, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.blue, lineWidth: 1)
                            )
                    }
                }
            } else {
                
                Button(action: {
                    //isShowingRegisterView = true
                    //viewModel.addToFavorites(dessert)
                    self.showModalLogin = true
                }) {
                    Text("Login to save to favorites")
                        .foregroundColor(.blue)
                        .frame(width: 250, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                }
                .sheet(isPresented: $showModalLogin) {
                    LoginUserView(isModal: showModalLogin)
                }
                
                
            }
        }
        .padding()
        
    }
}

struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailsView(dessert: MockData.sampleDessert)
            .environmentObject(UserManagerViewModel())
            .environmentObject(DessertListViewModel())
    }
}
