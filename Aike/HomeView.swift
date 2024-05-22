import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                                    Image("homepagebg3") // Ganti dengan nama gambar latar belakang Anda
                                        .resizable()
                                        
                                        .aspectRatio(contentMode: .fill)
                                        .scaledToFill()
                //Background5
//                                        .offset(y: 10)
                                        .offset(x: -10)
                                        .edgesIgnoringSafeArea(.all)
                                        
                                        // Pastikan gambar menutupi seluruh layar
                
                    
                    HStack{ Image("LOGO4")
                            .resizable() // Membuat gambar bisa diubah ukurannya
                            .aspectRatio(contentMode: .fit
                            ) // Mengatur content mode, bisa .fit atau .fill
                            .frame(maxWidth: 100, maxHeight: 100) // Mengatur ukuran frame
                            .clipped()
                        //Background5
                            .position(CGPoint(x: 160, y: 60))
//                            .position(x: 70, y: 50)
                
                        Spacer()
                    }
                
                
                VStack {
                    Spacer() // Push content down

                    VStack {
                        VStack{
                            Text("Welcome to the Aike App")
                                .font(.system(size: 32))
                                .fontWeight(.medium)
                                .foregroundColor(Color.init(hex: 0x43494D)) // Change text color to be visible on the background
                            
                            
                            Text("Experience the new way to buy furnitures with AR")
                                .font(.title2)
                                .fontWeight(.regular)
                                .foregroundColor(Color.init(hex: 0x43494D))
//                                .foregroundColor(.white)// Change text color to be visible on the background
                                
                        }

                        NavigationLink(destination: MenuPage()) {
                            Text("Start Decorate")
                                .foregroundColor(.white)
                                .fontWeight(.regular)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                                .background(Color.init(hex:0x43494D))
                                .cornerRadius(32)
                                .shadow(radius: 2)
                                .padding(.top, 8)
                                
                        }
                    }
                    
                    Spacer() // Push content up
                }.padding(.bottom, 48)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensure single column navigation on iPad
        .statusBar(hidden: true)
    }
}

#Preview {
    HomeView()
}
