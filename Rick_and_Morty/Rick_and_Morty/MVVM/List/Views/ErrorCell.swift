//
//  ErrorCell.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import SwiftUI

struct ErrorCell: View {
    var body: some View {
        HStack {
            Image("error")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text("A connection error has occurred, please try again.")
                .font(.footnote)
                .fontWeight(.light)
        }
    }
}

struct ErrorCell_Previews: PreviewProvider {
    static var previews: some View {
        RickAndMortyList()
    }
}
