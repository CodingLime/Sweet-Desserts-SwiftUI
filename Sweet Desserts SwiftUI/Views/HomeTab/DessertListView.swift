import SwiftUI

struct DessertListView: View {
    
    //@StateObject private var viewModel = DessertListViewModel()
    @State private var loadedOnce = false
    @State private var searchTerm = ""
    
    @EnvironmentObject private var viewModel: DessertListViewModel
    
    var filteredDesserts: [Dessert] {
        guard !searchTerm.isEmpty else { return viewModel.desserts }
        // forEach name -> $0
        return viewModel.desserts.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                List(filteredDesserts, id: \.id) { dessert in
                    DessertCell(dessert: dessert)
                }
                .navigationTitle("Desserts")
                .refreshable() {
                    viewModel.getDesserts()
                }
            }
            .onAppear {
                if(!loadedOnce) {
                    viewModel.getDesserts()
                    loadedOnce = true;
                }
            }
            .searchable(text: $searchTerm, prompt: "Search for desserts")
            .environmentObject(viewModel) // Set viewModel as environment object
            
            /*
             By setting the 'viewModel' as an environment object, it becomes accessible to all child views of DessertsListView, including the DessertsDetailsView. This allows the child views to access and modify the shared data.
             */
            
            if viewModel.isLoading && !loadedOnce { LoadingView() }
        }
        
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
    
    
}


struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView()
            .environmentObject(DessertListViewModel())
    }
}
