//
//  ContentView.swift
//  CourseNetworking
//
//  Created by DataBunker on 2022-10-28.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CourseViewModel()
    
    let items = [
        GridItem(.flexible()),
        
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: items, spacing: 30) {
                    ForEach(viewModel.projects) { project in
                        if project.thumbnail.contains("https") {
                            VStack(alignment: .leading) {
                                
                                AsyncImage(url: URL(string: project.thumbnail)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.white
                                }
                                
                                .padding()
    //                            .frame(width: 200, height: 200)
                                .scaledToFill()
//                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                 
                                Text(project.projectName)
                                    .lineLimit(1)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text(project.description)
                                    .lineLimit(2)
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(.gray)
                                
                                
                               
                               
                                

                                
                            }
                            .padding()
                            .background(Color(white: 0.97))
                        }
                        
                    }
                }.padding()
            }.navigationTitle("Projects")
                .scrollIndicators(.hidden)
                .navigationBarItems(trailing: Button {
                    viewModel.fetchProjects()
                } label: {
                    Text("Download")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                })
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
