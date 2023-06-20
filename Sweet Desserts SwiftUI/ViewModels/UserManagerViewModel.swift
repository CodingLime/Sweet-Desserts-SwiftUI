
import Foundation

final class UserManagerViewModel: ObservableObject {
    
    @Published var currentUser: User? {
        didSet {
            saveCurrentUser()
        }
    }
    
    init() {
        loadCurrentUser()
    }
    
    private func saveCurrentUser() {
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(currentUser)
            UserDefaults.standard.set(userData, forKey: "CurrentUser")
        } catch {
            print("Error encoding user data:", error)
        }
    }
    
    private func loadCurrentUser() {
        if let userData = UserDefaults.standard.data(forKey: "CurrentUser") {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: userData) {
                currentUser = user
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping () -> Void) {
        // Perform login validation and set the currentUser
        // For simplicity, we'll assume successful login for any non-empty username/password combination
        /*
         if !username.isEmpty && !password.isEmpty {
         self.currentUser = User(id: 1, token: "exampleToken", username: username, password: password)
         // Save the userManager data
         self.saveCurrentUser()
         }
         */
        
        // Normally you check if email & password are valid
        // then do a network call
        // and process it depending on the response
        // here I'm doing manually a 1 second delay to more "represent"
        // the real world, and thus allow to show the spinner "while loading"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !email.isEmpty && !password.isEmpty {
                self.currentUser = User(id: 1, token: "exampleToken", email: email, password: password)
            }
            // Save the userManager data
            self.saveCurrentUser()
            completion()
        }
        
        // Call the completion closure
        // completion()
        
    }
    
    func register(email: String, password: String, completion: @escaping () -> Void) {
        // Perform user registration and set the currentUser
        // For simplicity, we'll assume successful registration for any non-empty username/password combination
        /*
         if !email.isEmpty && !password.isEmpty {
         self.currentUser = User(id: 1, token: "exampleToken", username: email, password: password)
         // Save the userManager data
         self.saveCurrentUser()
         }
         */
        
        // Normally you check if email & password are valid
        // then do a network call
        // and process it depending on the response
        // here I'm doing manually a 1 second delay to more "represent"
        // the real world, and thus allow to show the spinner "while loading"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !email.isEmpty && !password.isEmpty {
                self.currentUser = User(id: 1, token: "exampleToken", email: email, password: password)
            }
            // Save the userManager data
            self.saveCurrentUser()
            completion()
        }
        
        // Call the completion closure
        // completion()
    }
    
    func logoff() {
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: "CurrentUser")
    }
}

