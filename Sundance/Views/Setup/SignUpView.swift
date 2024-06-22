//
//  SignUpView.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack{
            VStack{
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(height: 450)
            }
            .ignoresSafeArea()
            
            //Spacer()

            VStack(alignment: .center){
                Text("Sundance")
                    .font(.title)
                    .bold()
                    .foregroundColor(.sundanceBlue)
                Text("""
                     Made for the Everday Pro.
                     10 Mins. That's all you need.
                     """)
                    .multilineTextAlignment(.center)
                
                
                
                Button {
                    //Action
                    
                }label: {
                    Text("Try 7 days free")
                        .foregroundColor(.midnightBlue)
                        .bold()
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(.blue)
                .cornerRadius(18)
                .shadow(radius: 10)
                .padding([.leading, .trailing])
                .padding(.top)
                .padding(.bottom, 5)
                
                
                Text("Then £5.99/month. Cancel at anytime.")
                    .foregroundColor(.gray)
                    .font(.footnote)

            }
            
            Spacer()
        }
       
        
    }
}

#Preview {
    SignUpView()
}
