import Foundation

final class DessertListViewModel: ObservableObject {
    
    @Published var desserts: [Dessert] = []
    //@Published var favoriteDesserts: [Dessert] = []
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
    @Published var favoriteDesserts: [Dessert] = [] {
        didSet {
            saveFavoriteDesserts()
        }
    }
    
    init() {
        loadFavoriteDesserts()
    }
    
    func addToFavorites(_ dessert: Dessert) {
        /*
         Favorites are being store localy for simplicities sake
         
         Might implement a API for all this using Supabase in the future
         For proper implementation you would call an API to add it
         then if success add it to the favoriteDesserts array
         
         The API call would be done in NetworkManagerInSwiftUI
         */
        favoriteDesserts.append(dessert)
    }
    
    func removeFromFavorites(_ dessert: Dessert) {
        // same as above, only doing locally for simplicities sake
        favoriteDesserts.removeAll { $0.id == dessert.id }
    }
    
    private func saveFavoriteDesserts() {
        do {
            let encoder = JSONEncoder()
            let dessertsData = try encoder.encode(favoriteDesserts)
            UserDefaults.standard.set(dessertsData, forKey: "FavoriteDesserts")
        } catch {
            print("Error encoding favorite desserts:", error)
        }
    }
    
    private func loadFavoriteDesserts() {
        if let dessertsData = UserDefaults.standard.data(forKey: "FavoriteDesserts") {
            let decoder = JSONDecoder()
            if let desserts = try? decoder.decode([Dessert].self, from: dessertsData) {
                favoriteDesserts = desserts
            }
        }
    }
    
    func getDesserts() {
        isLoading = true
        
        NetworkManager.shared.getDesserts { [self] result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                
                switch result {
                case .success(let desserts):
                    self.desserts = desserts
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func clearFavoriteDessertsForLogoff() {
        self.favoriteDesserts = []
        UserDefaults.standard.removeObject(forKey: "FavoriteDesserts")
    }
    
}
