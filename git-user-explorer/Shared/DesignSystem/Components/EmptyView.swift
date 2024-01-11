//
//  EmptyView.swift
//  git-user-explorer
//
//  Created by Paramitha on 09/01/24.
//

import Foundation
import SwiftUI

struct EmptyView: View {
    
    var title: String = "Go on,"
    var subtitle: String = "There's nothing here..."
    var imageName: String = "icon_meh"
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: imageName)!)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.justBlue)
                .frame(width: 64, height: 64)
                
            Text(title).title()
            Text(subtitle).subtitle()
            
            
        }
    }
    
}
