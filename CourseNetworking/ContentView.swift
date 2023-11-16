//
//  ContentView.swift
//  CourseNetworking
//
//  Created by DataBunker on 2022-10-28.
//

import SwiftUI

struct ContentView: View {
    
    /// A view model used for this view.
    @ObservedObject var viewModel: ProjectViewModel
    
    /// An array of grid item to render the grid views.
    var gridItemsLayout: [GridItem]
    
    init() {
        self.viewModel = ProjectViewModel()
        gridItemsLayout = [ GridItem(.flexible()), GridItem(.flexible())]
    }
    
    func projectThumbnailImage(thumbNailImageUrl: String) -> some View {
        return AsyncImage(url: URL(string: thumbNailImageUrl)) { image in
               image.resizable()
           } placeholder: {
               GeometryReader(content: { geometry in
                   let size = geometry.size
                   Rectangle()
                       .fill(Color.blue)
                       .cornerRadius(4)
                       .frame(width: size.width - 10)
                       .redacted(reason: .placeholder)
               })
           }
           .scaledToFit()
    }
    
    
    /// A view to render the each grid item in the VStack.
    /// - Parameters:
    ///   - projectName: The name of the project.
    ///   - projectImageUrl: The image url used for the project.
    ///   - projectDescription: The description of the project.
    /// - Returns: A view which has all the information for the grid view item.
    func projectItemView(projectName: String, projectImageUrl: String, projectDescription: String) -> some View {
        VStack(alignment: .leading) {
            projectThumbnailImage(thumbNailImageUrl: projectImageUrl)
            Text(projectName)
                .lineLimit(1)
                .font(.system(size: 20, weight: .semibold))
            Text(projectDescription)
                .lineLimit(3)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.secondary)
        }
        .padding()
    }
    
    
    /// A view to render the complete list of items in the grid view Settings.
    /// - Returns: A view which has all the grid view items to render
    func projectsGridView () -> some View {
        LazyVGrid(columns: gridItemsLayout, spacing: 10) {
            ForEach(viewModel.projects) { project in
                // Hacky fix for loading the temporary image for insecured image content!
                if project.thumbnail.contains("https") {
                    projectItemView(projectName: project.projectName, projectImageUrl: project.thumbnail, projectDescription: project.description)
                } else {
                    projectItemView(projectName: project.projectName, projectImageUrl: "https://thereader.mitpress.mit.edu/wp-content/uploads/2020/11/pacman-lead-graphic-700x420.jpg", projectDescription: project.description)
                }
            }
            
        }.padding()
    }
 
    
    var body: some View {
        NavigationView {
            ScrollView {
                projectsGridView()
            }
            .navigationTitle("Projects")
                .scrollIndicators(.hidden)
                .navigationBarItems(trailing: Button {
                    viewModel.fetchProjects()
                } label: {
                    Image(systemName: "arrow.down.app")
                })
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
