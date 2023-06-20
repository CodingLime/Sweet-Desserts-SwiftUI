import SwiftUI

struct AppMainView: View {
    
    @State private var selectedTab: Int = 0
    @StateObject private var userManager = UserManagerViewModel()
    @StateObject private var viewModel = DessertListViewModel()
    @State private var currentUser: User? = nil
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DessertListView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Desserts")
                }
                .tag(0)
                .environmentObject(userManager)
                .environmentObject(viewModel)
            
            FavoriteDessertsView()
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Favorites")
                }
                .tag(1)
                .environmentObject(userManager)
                .environmentObject(viewModel)
            
            Group {
                if currentUser == nil {
                    //SignInAndUpUserView()
                    LoginUserView(isModal: false)
                } else {
                    ProfileUserView()
                }
            }
            .tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Profile")
            }
            .tag(2)
            .environmentObject(userManager)
            .environmentObject(viewModel)
        }
        .onReceive(userManager.$currentUser) { user in
            /**
             We use .onReceive here to keep an check on userManager.$currentUser
                to see if it changes, and if yes, update the @State currentUser,
                and this way allow to change the views we show
             */
            currentUser = user
        }
    }
}

struct AppMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainView()
    }
}
