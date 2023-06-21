import SwiftUI

struct DessertDetailsView: View {
    let dessert: Dessert
    
    @EnvironmentObject private var viewModel: DessertListViewModel
    @EnvironmentObject private var userManager: UserManagerViewModel
    
    @State var showModalLogin: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Header(urlString: dessert.imageURL)
            
            GeometryReader { proxy in
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    
                    VStack(alignment: .leading){
                        HStack {
                            Spacer()
                        }
                        
                        Text(dessert.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(String(format: "Price: $%.2f", dessert.price))
                            .font(.subheadline)
                            .padding(.bottom)
                            .padding(.top, 1)
                            .foregroundColor(Color("ColorTextSub"))
                        
                        HStack(spacing: 20) {
                            SubInfoView(image: "flame.circle", info: "\(dessert.calories) Calories")
                            SubInfoView(image: "timer", info: "\(dessert.duration) min")
                            SubInfoView(image: "chart.bar", info: dessert.easeOfMaking)
                        }
                        
                        Text("Description: ")
                            .fontWeight(.medium)
                            .padding(.top, 20)
                        
                        Text(dessert.description)
                            .foregroundColor(Color("ColorTextSub"))
                            .fontWeight(.light)
                            .padding(.top, 5)
                        
                        VStack{
                            Spacer()
                        }
                        
                    }
                    .frame(minHeight: proxy.size.height/2)
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    .background(Color("ColorBackground"))
                    .customCornerRadius(40, corners: [.topLeft, .topRight])
                    .padding(.top, UIScreen.main.bounds.height / 5 * 2)
                    
                }
                .padding(.top, 1) // prevents glass navbar of showing up on scrolling up (https://timothycbryant.com/2022/04/28/swiftui-prevent-navigationbar-from-fading-on-scroll/)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBarHidden()
        
    }
}

struct SubInfoView: View {
    var image: String
    var info: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: image)
                .font(.subheadline)
            Text(info)
                .font(.subheadline)
        }
    }
}

struct Header: View {
    var urlString: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // TO DO: CREATE CUSTOM COLOR FOR TOOLBARITEMS FOR DARK & LIGHT MODE
    // TO DO: CREATE CUSTOM COLOR FOR TOOLBARITEMS FOR DARK & LIGHT MODE
    // TO DO: CREATE CUSTOM COLOR FOR TOOLBARITEMS FOR DARK & LIGHT MODE
    // TO DO: CREATE CUSTOM COLOR FOR TOOLBARITEMS FOR DARK & LIGHT MODE
    
    var body: some View {
        ZStack(alignment: .top) {
            DessertRemoteImage(urlString: NetworkManager.baseURL + urlString)
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4 * 2)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: { presentationMode.wrappedValue.dismiss() }){
                    Image(systemName: "chevron.backward")
                    //.font(.title3)
                        .foregroundColor(Color("ColorTextMain"))
                        .frame(width: 45, height: 45)
                        .background(Color("ColorBackground"))
                        .cornerRadius(10)
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {}){
                    Image(systemName: "heart")
                    //.font(.title3)
                        .foregroundColor(Color("ColorTextMain"))
                        .frame(width: 45, height: 45)
                        .background(Color("ColorBackground"))
                        .cornerRadius(10)
                }
            }
        }
        
    }
}

// MARK: - Extend view to apply cornerRadius
extension View {
    func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailsView(dessert: MockData.sampleDessert)
            .environmentObject(UserManagerViewModel())
            .environmentObject(DessertListViewModel())
    }
}
