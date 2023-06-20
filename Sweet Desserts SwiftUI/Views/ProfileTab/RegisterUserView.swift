import SwiftUI

struct RegisterUserView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var wrongEmail: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var wrongConfirmPassword: Float  = 0
    
    @EnvironmentObject private var userManager: UserManagerViewModel
    
    var body: some View {
        VStack {
            Text("Register User")
                .font(.largeTitle)
                .bold()
                .padding()
            TextField("Email address", text: $email)
                .padding()
                //.frame(width: 300, height: 50)
                .background(Color("ColorTextField"))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongEmail))
            
            
            SecureField("Password", text: $password)
                .padding()
                //.frame(width: 300, height: 50)
                .background(Color("ColorTextField"))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongPassword))
                .padding(.top)
            
            SecureField("Password", text: $password)
                .padding()
                //.frame(width: 300, height: 50)
                .background(Color("ColorTextField"))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongConfirmPassword))
                .padding(.top)
            
            Button(action: {
                userManager.register(email: email, password: password){
                    
                }
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            VStack {
                Text("Note: no API for the register is being used right now. Just type random stuff into the email and password field and hit 'Register'")
                    .font(.subheadline)
                    .padding()
                    
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}

struct RegisterUserView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUserView()
    }
}
