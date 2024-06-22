//
//  MoreFromUs.swift
//  Sundance
//
//  Created by Imran razak on 21/06/2024.
//

import SwiftUI

struct MoreFromUs: View {
    var body: some View {
        VStack{
            Divider()
                .padding()
            HStack{
                //MARK: - Feedback
                Button{
                    //Opens Feedback Form
                }label: {
                    Text("Give Feedback & Suggestion")
                        .font(.caption)
                }
                .frame(width: 190, height: 50)
                .background(Color(.systemGray5))
                .cornerRadius(18)
                
                //MARK: - Report Probleem
                Button{
                    //Opens Pre-filled Email
                }label: {
                    Text("Report Problem")
                        .font(.caption)
                }
                .frame(width: 190, height: 50)
                .background(Color(.systemGray5))
                .cornerRadius(18)
                
            }
        }
    }
}

#Preview {
    MoreFromUs()
}
