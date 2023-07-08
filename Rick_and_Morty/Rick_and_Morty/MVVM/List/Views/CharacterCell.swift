//
//  CharacterCell.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import SwiftUI

struct CharacterCell: View {
    var results: Results
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: results.image ?? "")){ image in
                image.resizable()
                    .cornerRadius(35)
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            VStack(alignment:.leading) {
                Text(results.name ?? "")
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                Text(results.gender ?? "")
                    .font(.subheadline)
                    .fontWeight(.regular)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.leading)
            Text(results.species ?? "")
                .font(.footnote)
                .fontWeight(.light)
        }
        .padding(.bottom)
        .padding(.top)
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        RickAndMortyList()
    }
}

