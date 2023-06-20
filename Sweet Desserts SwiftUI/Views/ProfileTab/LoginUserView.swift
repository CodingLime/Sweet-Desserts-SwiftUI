import SwiftUI

struct LoginUserView: View {
    
    let isModal: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var wrongEmail: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var showingLoginScreen = false
    @State private var isLoggingIn = false
    
    @EnvironmentObject private var userManager: UserManagerViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingRegisterView = false
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                TextField("Email address", text: $email)
                    .padding()
                    .background(Color("ColorTextField"))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongEmail))
                
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color("ColorTextField"))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongPassword))
                    .padding(.top)
                
                HStack {
                    Button(action: {
                        isShowingRegisterView = true
                    }) {
                        Text("Register")
                            .foregroundColor(.blue)
                            .frame(width: 150, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.blue, lineWidth: 1)
                            )
                    }
                    .sheet(isPresented: $isShowingRegisterView) {
                        RegisterUserView()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isLoggingIn = true
                        userManager.login(email: email, password: password){
                            // Completion closure, called when login is finished
                            isLoggingIn = false
                            if(isModal) { presentationMode.wrappedValue.dismiss() }
                        }
                    }) {
                        
                        if !isLoggingIn {
                            Text("Login")
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        if isLoggingIn {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .foregroundColor(.white)
                                .frame(width: 150, height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    
                }
                .padding(.top)
                
                VStack {
                    Text("Note: no API for the login is being used right now. Just type random stuff into the email and password field and hit 'Login'")
                        .font(.subheadline)
                        .padding()
                        
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
            
            
        }
        
    }
}

struct LoginUserView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUserView(isModal: false)
    }
}
