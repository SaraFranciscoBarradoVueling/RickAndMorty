//
//  LoadingCell.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import SwiftUI

struct LoadingCell: View {
    var body: some View {
        VStack {
            Spacer()
            Image("loading")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
            Text("Loading...")
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
        }.cornerRadius(100)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoadingCell_Previews: PreviewProvider {
    static var previews: some View {
        RickAndMortyList()
    }
}
