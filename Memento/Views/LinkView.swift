//
//  ItemView.swift
//  Memento
//
//  Created by Roscoe Rubin-Rottenberg on 6/1/24.
//

import SwiftUI
import LinkPresentation

struct LinkView: View {
    var link: Link
    
    var body: some View {
        VStack(alignment: .leading) {
            if let data = link.metadata?.siteImage, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(height: 100)
                    .shadow(radius: 2)
            } else {
                Image("EmptyLink")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(height: 100)
                    .shadow(radius: 2)
            }
            VStack {
                Text(link.metadata?.title ?? link.address)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.primary)
            }
        }
        .frame(height: 170)
        .padding(5)
    }
}

#Preview {
    struct AsyncTestView: View {
        
        @State var passedValue = LPLinkMetadata()
        
        var body: some View {
            LinkView(link: Link(address: "https://x.com/itswords_/status/1796776745112072330/photo/1", url: URL(string: "https://x.com/itswords_/status/1796776745112072330/photo/1")!, metadata: CodableLinkMetadata(metadata: passedValue)))
                .task {
                    passedValue = await fetchMetadata(url: URL(string: "https://chess.com")!)
                }
        }
    }
    
    return AsyncTestView()
}
