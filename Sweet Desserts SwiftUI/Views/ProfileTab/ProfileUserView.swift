import SwiftUI

struct ProfileUserView: View {
    
    @EnvironmentObject private var userManager: UserManagerViewModel
    @EnvironmentObject private var viewModel: DessertListViewModel
    
    var body: some View {
        VStack{
            Text("User Profile")
                .padding()
            Text("Email: " + (userManager.currentUser?.email ?? "not found"))
                .padding()
            Button("Logoff") {
                userManager.logoff()
                viewModel.clearFavoriteDessertsForLogoff()
            }
            .padding()
        }
        
    }
}

struct ProfileUserView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUserView()
            .environmentObject(UserManagerViewModel())
            .environmentObject(DessertListViewModel())
        /**
         Added the .environmentObject(UserManagerViewModel()) above to solve the following preview error:
         
         "SwiftUI Playground crashed due to missing environment of type: UserManagerViewModel.
         To resolve this, add environmentObject(UserManagerViewModel(...)) to the appropriate preview"
         */
    }
}
