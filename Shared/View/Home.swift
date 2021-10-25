//
//  Home.swift
//  DoubleSidedGallery (iOS)
//
//  Created by Mac on 25/10/2021.
//

import SwiftUI

struct Home: View {
    @State var posts :[Post] = []
    @State var CurrentPost :String = ""
    @State var fullPre :Bool = false
    var body: some View {
       //double sided gallery
        TabView(selection: $CurrentPost) {
            ForEach (posts){
                post in
                //for getting screen sizze for image
                GeometryReader
                {
                    proxy in
                    let size = proxy.size
                    Image(post.postImge)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height )
                        .cornerRadius(0)
                    
                }
                .tag(post.id)
                .ignoresSafeArea()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        
        .onTapGesture {
            withAnimation {
                fullPre.toggle()
            }
        }
        // top detail view
        
        
        
        .overlay(
            HStack{
                Text("Beautifull Scenes")
                    .font(.title2.bold())
                
                Spacer(minLength: 0)
                
                Button{
                    
                }label:{
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2.bold())
                }
               
            }
                .foregroundColor(.white)
                .padding()
                .background(BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea())
                .offset(y:fullPre ? -150 : 0 )
            , alignment : .top
        )
        //button image view
        
        .overlay(
        
        //scroller reader to navigate to next iamge
            ScrollViewReader {
                proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15 ){
                        
                        ForEach(posts){
                            post in
                            Image(post.postImge)
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width: 70, height: 60 )
                                .cornerRadius(12)
                            
                            //showing ring for currunt for post
                                .padding(2)
                                .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.white,lineWidth: 2)
                                    .opacity(CurrentPost == post.id ? 1 : 0)
                                )
                                .id(post.id)
                                .onTapGesture {
                                    withAnimation {
                                        CurrentPost = post.id
                                    }
                                }
                        }
                    }
                    .padding()
                }.frame(height:80)
                .background(BlurView(style:.systemUltraThinMaterialDark).ignoresSafeArea())
                
                //while currnt post chaing
                
                
                    .onChange(of: CurrentPost) { _ in
                    withAnimation {
                        proxy.scrollTo(CurrentPost, anchor: .bottom)
                    }
                }
            }
                .offset(y:fullPre ? 150 : 0 )
            , alignment: .bottom
        )
        //Inseting sample posts
        .onAppear {
            for index in 1...11{
                posts.append(Post(postImge: "Pic\(index)"))
                  }
            CurrentPost = posts.first?.id ?? ""
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
