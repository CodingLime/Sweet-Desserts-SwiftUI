import SwiftUI

struct FavoriteDessertsView: View {
    
    @State private var loadedOnce = false
    @State private var searchTerm = ""
    
    @EnvironmentObject private var userManager: UserManagerViewModel
    @EnvironmentObject private var viewModel: DessertListViewModel
    
    @State var showModalLogin: Bool = false
    
    //@Binding var selectedTab: Int
    
    var filteredDesserts: [Dessert] {
        guard !searchTerm.isEmpty else { return viewModel.favoriteDesserts  }
        // forEach name -> $0
        return viewModel.favoriteDesserts.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)} 
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List(filteredDesserts, id: \.id) { dessert in
                    DessertCell(dessert: dessert)
                }
                .navigationTitle("Favorites")
            }
            .searchable(text: $searchTerm, prompt: "Search for your favorites")
            
            if(filteredDesserts.isEmpty){
                VStack(){
                    Text("No favorites found")
                        .font(.title)
                        .fontWeight(.bold)
                    if ((userManager.currentUser?.email) != nil){
                        Text("Go add some to your list!")
                            .font(.subheadline)
                            .fontWeight(.bold)
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
                
            }
//            .onAppear {
//                if(!loadedOnce) {
//                    viewModel.getDesserts()
//                    loadedOnce = true;
//                }
//            }
            //.environmentObject(viewModel) /// Set viewModel as environment object
            
            /*
             By setting the 'viewModel' as an environment object, it becomes accessible to all child views of AppetizerListView, including the AppetizerDetailsView. This allows the child views to access and modify the shared data.
             */
            
            if viewModel.isLoading { LoadingView() }
        }
        
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

struct FavoriteDessertsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDessertsView()
            .environmentObject(UserManagerViewModel())
            .environmentObject(DessertListViewModel())
    }
}
