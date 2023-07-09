//
//  DetailView.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import SwiftUI

struct DetailView: View {
    var character: Results!
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.image ?? "")){ image in
                image.resizable()
                    .cornerRadius(100)
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            Text(character.name ?? "")
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
            Text(character.status ?? "")
                    .font(.subheadline)
                    .fontWeight(.regular)
            Text(character.species ?? "")
                .font(.footnote)
                .fontWeight(.light)
        }
        .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.center)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
