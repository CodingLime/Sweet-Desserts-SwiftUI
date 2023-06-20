import SwiftUI

class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://example-rest-api-codinglime.vercel.app/"
    private let dessertsURL = baseURL + "api/desserts"
    
    private init() {}
    
    func getDesserts(completed: @escaping (Result<[Dessert], APError>) -> Void) {
        guard let url = URL(string: dessertsURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Dessert].self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    func loginUser(credentials: UserCredentials, completion: @escaping (Result<User, Error>) -> Void) {
        let loginURL = URL(string: "\(NetworkManager.baseURL)/login")!
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(credentials)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let User = try JSONDecoder().decode(User.self, from: data)
                    
                    completion(.success(User))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func registerUser(data: RegistrationData, completion: @escaping (Result<Void, Error>) -> Void) {
        let registerURL = URL(string: "\(NetworkManager.baseURL)/register")!
        
        var request = URLRequest(url: registerURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(data)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Handle success response
            completion(.success(()))
        }.resume()
    }
    
    // Additional function for log out
    func logoutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        let logoutURL = URL(string: "\(NetworkManager.baseURL)/logout")!
        
        var request = URLRequest(url: logoutURL)
        request.httpMethod = "POST"
        // Set authorization token in the header if required
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Handle success response
            completion(.success(()))
        }.resume()
    }
}
