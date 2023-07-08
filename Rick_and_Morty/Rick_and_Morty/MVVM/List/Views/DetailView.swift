//
//  DetailView.swift
//  Rick_and_Morty
//
//  Created by Sara Francisco on 8/7/23.
//

import SwiftUI

struct DetailView: View {
    var image = ""
    var name = ""
    var info = ""
    var moreInfo = ""
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image)){ image in
                image.resizable()
                    .cornerRadius(10)
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            VStack(alignment:.leading) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                Text(info)
                    .font(.subheadline)
                    .fontWeight(.regular)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.leading)
            Text(moreInfo)
                .font(.footnote)
                .fontWeight(.light)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
