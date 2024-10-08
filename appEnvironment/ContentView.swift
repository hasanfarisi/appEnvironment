//
//  ContentView.swift
//  appEnvironment
//
//  Created by mac on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    //@StateObject var userAuth = AuthUser()
    @State var userAuth:AuthUser
    
    var body: some View {
        if !userAuth.isLoggedIn{
            return AnyView(Login(userAuth: AuthUser()))
        }else{
            return AnyView(Home(userAuth: AuthUser()))
        }
    }
}

struct Home:View {
    @State var userAuth:AuthUser
    var body: some View {
        NavigationView{
            ZStack{
                Color.purple
                Text("Home").foregroundColor(.white)
                    .navigationBarTitle("Home", displayMode: .inline)
                    .navigationBarItems(trailing:
                                            Button(action: {self.userAuth.isLoggedIn = false}){
                                                Image(systemName: "arrowshape.turn.up.right.circle")
                                            }
                    )
            }
        }
    }
}

struct Login:View {
    @State var userAuth:AuthUser
    
    @State var username:String = ""
    @State var password:String = ""
    
    let lightGreyColor = Color(red: 239.00/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 0.5)
    
    // 7. buat validasi jika field tidak diisi
    @State var isEmptyField = false
    
    var body: some View {
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    HStack{
                        VStack{
                            Text("Risyad").bold().font(.largeTitle).foregroundColor(Color.white)
                            Text("App").font(.title).foregroundColor(Color.white)
                        }
                        Spacer()
//                        Image("illustration")
//                            .resizable()
//                            .frame(width: 120, height: 120)
//                            .padding()
                    }
                    Spacer()
                }
                .frame(height: 180)
                .padding(30)
                .background(Color.purple)
                .clipShape(CustomShape(corner: .bottomRight, radii: 50))
                .edgesIgnoringSafeArea(.top)
                
                VStack(alignment: .leading){
                    Text("Username")
                    TextField("Username...", text: $username)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5)
                        .autocapitalization(.none)
                        //.keyboardType(.emailAddress)
                    
                    Text("Password")
                    SecureField("Password...", text: $password)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5)
                        .autocapitalization(.none)
                    
                    //showing error message
                    if !self.userAuth.isCorrect{
                        Text("Invalid username or password").foregroundColor(.red)
                    }
                    
                    // 8. peringatan jika field kosong
                    if self.isEmptyField{
                        Text("Username or password can not be blank").foregroundColor(.red)
                    }
                    
                    HStack{
                        Button(action: {}){
                            Text("Forgot password")
                        }
                        Spacer()
                    }.padding([.top, .bottom],10)
                    
                    //Sign in button
                    HStack{
                        Spacer()
                        Button(action: {
                            // 9. event check login
                            if self.username.isEmpty || self.password.isEmpty{
                                self.isEmptyField = true
                            }else{
                                self.userAuth.checkLogin(password: self.password, username: self.username)
                            }
                        }){
                            Text("Sign in").bold().font(.callout).foregroundColor(Color.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(15)
                    
                    //Privacy policy
                    
                    HStack{
                        Spacer()
                        Button(action: {}){
                            Text("Our privacy policy").bold().font(.callout).foregroundColor(Color.purple)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    HStack{
                        Text("Don't have an account?").bold().font(.callout).foregroundColor(Color.black)
                        Spacer()
                        Button(action: {}){
                            Text("Sign up").bold().font(.callout).foregroundColor(Color.purple)
                        }
                    }
                    .padding()
                }
                .padding(30)
                
                Spacer()
            }
        }
    }
}

//custom shape
struct CustomShape:Shape {
    var corner: UIRectCorner
    var radii: CGFloat
    
    func path(in react: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: react, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        return Path(path.cgPath)
    }
}

#Preview {
    ContentView(userAuth: AuthUser())
}
