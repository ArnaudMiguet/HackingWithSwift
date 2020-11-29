//
//  ContentView.swift
//  Challenge02
//
//  Created by Arnaud Miguet on 29.11.20.
//

import SwiftUI

struct ContentView: View {
    var flags = (try? FileManager.default.contentsOfDirectory(atPath: Bundle.main.resourcePath!).filter{$0.hasSuffix(".png")}.map{String($0.dropLast(7))}) ?? []
    
    var body: some View {
        NavigationView {
            VStack {
                List(flags, id: \.self) { flag in
                    NavigationLink(destination: DetailView(country: flag)) {
                        HStack {
                            Image(uiImage: UIImage(named: flag+"@2x.png")!)
                                .resizable()
                                .frame(maxHeight: 40)
                                .aspectRatio(UIImage(named: flag+"@2x.png")!.size, contentMode: .fit)
                                .padding(.trailing)
                            Text(flag.capitalized)
                        }
                        .clipped()
                    }
                }
            }.navigationBarTitle("Flags")
        }
    }
}

struct DetailView: View {
    var country: String
    
    @State var showShareSheet = false
    
    var body: some View {
        Image(uiImage: UIImage(named: country+"@2x.png")!)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle(country.capitalized)
            .navigationBarItems(trailing: Button("Share") {
                showShareSheet = true
            })
            .sheet(isPresented: $showShareSheet) {
                ActivityView(activityItems: [UIImage(named: country+"@2x.png")!], applicationActivities: nil)
            }
    }
}

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
